package com.klk.bank.service;

import java.io.IOException;
import java.math.BigDecimal;
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
		
	public List<AccountDto> listAccount(AccountPageInfoDto page_info, String type, String keyword) {
		
		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return account_mapper.selectAllAccount(from, row_per_page, type, "%" + keyword + "%");
	}		
	
	public boolean addAccount(AccountDto account, MultipartFile[] files) {
		// 평문암호를 암호화(encoding)
		String encodedPassword = password_encoder.encode(account.getAccount_pw());
		
		// 암호화된 암호를 다시 세팅
		account.setAccount_pw(encodedPassword);
		
		// addAccount
		int cnt = account_mapper.insertAccount(account);
		
		addFiles(account.getAccount_num(), files);
				
		return cnt == 1;
	}
	
	private void addFiles(String account_num, MultipartFile[] files) {
		// 파일 등록 
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					account_mapper.insertFile(account_num, file.getOriginalFilename());
					saveFileAwsS3(account_num, file); // s3에 업로드
				}
			}
		}
	}
		
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

	public AccountDto getAccount(String account_num) {
		AccountDto account = account_mapper.selectAccount(account_num);
				
		return account_mapper.selectAccount(account_num);
	}


	public boolean modifyAccount(AccountDto account) {
		
		String encoded_password = password_encoder.encode(account.getAccount_pw());
		
		account.setAccount_pw(encoded_password);
		
		int cnt = account_mapper.updateAccount(account);
		return cnt == 1;
	}

	@Transactional
	public boolean removeAccount(String account_num) {
				
		int cnt = account_mapper.deleteAccount(account_num);
		return cnt == 1;
	}

	public int searchCountAccount(String type, String keyword) {
		
		return account_mapper.selectSearchCountAccount(type, "%" + keyword + "%");
	}

	public boolean hasAccountNum(String account_num) {
		return account_mapper.countAccountNum(account_num) > 0;
	}
			
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

	public List<TransferDto> getAccountHistory(String account_num) {
		return account_mapper.selectTransferAccount(account_num);
	}

	public int searchCurrentUserCountAccount(String user_id, String type, String keyword) {
		
		return account_mapper.selectSearchCurrentUserCountAccount(user_id, type, "%" + keyword + "%");
	}

	public List<AccountDto> listCurrentUserAccount(AccountPageInfoDto page_info, String user_id, String type,
			String keyword) {
		
		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return account_mapper.selectCurrentUserAccount(from, row_per_page, user_id, type, "%" + keyword + "%");
		
	}

	public boolean accountPwCheck(String send_account_num, String send_account_pw) {
		
		AccountDto send_account = account_mapper.selectAccount(send_account_num);
		
		String encoded_pw = send_account.getAccount_pw();
		
		if(password_encoder.matches(send_account_pw, encoded_pw)) { 
			return true;
		}
		
		return false;
	}
	
}
