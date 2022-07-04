package com.klk.bank.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.AccountPageInfoDto;
import com.klk.bank.domain.TransferDto;
import com.klk.bank.mapper.AccountMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class AccountService {
	
	@Autowired
	private AccountMapper account_mapper;
	
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	@Autowired
	private BCryptPasswordEncoder password_encoder;
	
	@PostConstruct
	public void init() {
		Region region = Region.AP_NORTHEAST_2;
		this.s3 = S3Client.builder().region(region).build();
	}
	
	@PreDestroy
	public void destroy() {
		this.s3.close();
	}

	//계좌리스트
	public List<AccountDto> listAccount(AccountPageInfoDto page_info, String type, String keyword) {
		
		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return account_mapper.selectAllAccount(from, row_per_page, type, "%" + keyword + "%");
	}		
	
    //계좌추가
	public boolean addAccount(AccountDto account, MultipartFile[] file) {	
		// 평문암호를 암호화(encoding)		
		String encodedPassword = password_encoder.encode(account.getAccount_pw());
		
		// 암호화된 암호를 다시 세팅
		account.setAccount_pw(encodedPassword);
		
		addFiles(account.getAccount_num(), file);

		// addAccount
		int cnt = account_mapper.insertAccount(account);
						
		return cnt == 1;
	}
	
	// 파일 등록 
	private void addFiles(String account_num, MultipartFile[] files) {
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					account_mapper.insertFile(account_num, file.getOriginalFilename());
					saveFileAwsS3(account_num, file); // s3에 업로드
				}
			}
		}
	}
		
	// AWS에 파일 저장하기
	private void saveFileAwsS3(String account_num, MultipartFile file) {
		String key = "account/" + account_num + "/" + file.getOriginalFilename();
		
		PutObjectRequest put_object_request = PutObjectRequest.builder()
				.acl(ObjectCannedACL.PUBLIC_READ)
				.bucket(bucketName)
				.key(key)
				.build();
		
		RequestBody request_body;
		try {
			request_body = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
			s3.putObject(put_object_request, request_body);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new RuntimeException(e);
		}				
	}	

	//계좌정보보기
	public AccountDto getAccount(String account_num) {		
				
		return account_mapper.selectAccount(account_num);
	}	
	
	public List<String> selectFileByAccount(String account_num) {
		
		return account_mapper.selectFileNameByAccount(account_num);
	}

	// 계좌정보 수정하기(파일 수정/삭제 기능 포함)
	@Transactional
	public boolean modifyAccount(AccountDto account, ArrayList<String> remove_file_list, MultipartFile[] add_file_list) {
				
		if (remove_file_list != null) {
			for (String file_name : remove_file_list) {
				deleteFromAwsS3(account.getAccount_num(), file_name);
				account_mapper.deleteFileByAccountNumAndFileName(account.getAccount_num(), file_name);
			}
		}		
		
		if (add_file_list != null) {
			addFiles(account.getAccount_num(), add_file_list);
		}
		
		String encoded_password = password_encoder.encode(account.getAccount_pw());
		
		account.setAccount_pw(encoded_password);
		
		int cnt = account_mapper.updateAccount(account);
		return cnt == 1;
	}

	// 계좌 삭제
	@Transactional
	public boolean removeAccount(String account_num) {
		// 파일 목록 읽기
		List<String> file_list = account_mapper.selectFileNameByAccount(account_num);
		
		removeFiles(account_num, file_list);
		
		int cnt = account_mapper.deleteAccount(account_num);
		return cnt == 1;
	}
	
	// 첨부한 파일 삭제하기
	private void removeFiles(String account_num, List<String> file_list) {		
		for (String file_name : file_list) {
			deleteFromAwsS3(account_num, file_name);
		}		
		
		account_mapper.deleteFileByAccountNum(account_num);		
	}

	// AWS에 첨부된 파일 삭제하기
	private void deleteFromAwsS3(String account_num, String file_name) {
		String key = "account/" + account_num + "/" + file_name;
		
		DeleteObjectRequest delete_object_request = DeleteObjectRequest.builder()
																	 .bucket(bucketName)
																	 .key(key)
																	 .build();
		
		s3.deleteObject(delete_object_request);
		
	}

	
	//검색어에 따른 모든계좌갯수
	public int searchCountAccount(String type, String keyword) {
		
		return account_mapper.selectSearchCountAccount(type, "%" + keyword + "%");
	}
	
	//계좌존재여부
	public boolean hasAccountNum(String account_num) {
		return account_mapper.countAccountNum(account_num) > 0;
	}
	
	//계좌이체
	@Transactional
	public boolean transferAccount(String send_account_num, String send_account_cost, String account_num) {
		
		int cnt1 = 0, cnt2 = 0;
		BigDecimal b1 = new BigDecimal(send_account_cost);
		BigDecimal b2 = new BigDecimal(send_account_cost);
		TransferDto transfer_send = new TransferDto();
		TransferDto transfer_receive = new TransferDto();
		
		AccountDto account1 = account_mapper.selectAccount(send_account_num);
		if(send_account_num.equals(account_num)) {
			transfer_send.setTrans_account_num(send_account_num);
			transfer_send.setTrans_cost(b1);
			transfer_send.setTrans_div("withdraw");
			b1 = account1.getAccount_balance().subtract(b1);
			account_mapper.insertTransfer(transfer_send);
			
			transfer_receive.setTrans_account_num(send_account_num);
			transfer_receive.setTrans_cost(b2);
			transfer_receive.setTrans_div("deposit");
			b1 = b1.add(b2);
			account_mapper.insertTransfer(transfer_receive);
			
			account1.setAccount_balance(b1);
			cnt1 = account_mapper.updateAccount(account1);
			
			return cnt1 == 1;
		} else {
			
			AccountDto account2 = account_mapper.selectAccount(account_num);
			
			transfer_send.setTrans_account_num(send_account_num);
			transfer_send.setTrans_cost(b1);
			transfer_send.setTrans_div("withdraw");
			b1 = account1.getAccount_balance().subtract(b1);
			account_mapper.insertTransfer(transfer_send);
			
			transfer_receive.setTrans_account_num(account_num);
			transfer_receive.setTrans_cost(b2);
			transfer_receive.setTrans_div("deposit");
			b2 = account2.getAccount_balance().add(b2);
			account_mapper.insertTransfer(transfer_receive);
			
			account1.setAccount_balance(b1);
			account2.setAccount_balance(b2);
		
			cnt1 = account_mapper.updateAccount(account1);
			cnt2 = account_mapper.updateAccount(account2);
			
			return (cnt1 == 1) && (cnt2 == 1);
		}
	}
	
	//계좌이력출력
	public List<TransferDto> getAccountHistory(String account_num) {
		return account_mapper.selectTransferAccount(account_num);
	}
	
	//현재사용자의 검색어에 따른 계좌갯수
	public int searchCurrentUserCountAccount(String user_id, String type, String keyword) {
		
		return account_mapper.selectSearchCurrentUserCountAccount(user_id, type, "%" + keyword + "%");
	}
	
	//현재사용자의 계좌리스트
	public List<AccountDto> listCurrentUserAccount(AccountPageInfoDto page_info, String user_id, String type,
			String keyword) {
		
		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return account_mapper.selectCurrentUserAccount(from, row_per_page, user_id, type, "%" + keyword + "%");
		
	}
	
	//계좌비밀번호 체크
	public boolean accountPwCheck(String send_account_num, String send_account_pw) {
		
		AccountDto send_account = account_mapper.selectAccount(send_account_num);
		
		String encoded_pw = send_account.getAccount_pw();
		
		if(password_encoder.matches(send_account_pw, encoded_pw)) { 
			return true;
		}
		
		return false;
	}
	
}
