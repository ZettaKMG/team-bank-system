package com.klk.bank.service;

import java.io.File;
import java.io.IOException;
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
import com.klk.bank.domain.FileSubmitDto;
import com.klk.bank.mapper.AccountMapper;
import com.klk.bank.mapper.FileSubmitMapper;

import software.amazon.awssdk.core.sync.RequestBody;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.services.s3.S3Client;
import software.amazon.awssdk.services.s3.model.DeleteObjectRequest;
import software.amazon.awssdk.services.s3.model.ObjectCannedACL;
import software.amazon.awssdk.services.s3.model.PutObjectRequest;

@Service
public class FileSubmitService {

	@Autowired
	private AccountMapper account_mapper;
		
	@Autowired
	private FileSubmitMapper file_submit_mapper;
	
	@Autowired
	private BCryptPasswordEncoder password_encoder;
	
//	private S3Client s3;
//	
//	@Value("${aws.s3.bucket_name}")
//	private String bucket_name;
//	
//	@PostConstruct
//	public void init() {
//		Region region = Region.AP_NORTHEAST_2;
//		this.s3 = S3Client.builder().region(region).build();		
//	}
//	
//	@PreDestroy
//	public void destroy() {
//		this.s3.close();
//	}
	
	@Transactional
	public boolean addAccountWithFile(FileSubmitDto file_submit, MultipartFile[] files) {
		String encoded_password = password_encoder.encode(file_submit.getAccount_pw());
		
		file_submit.setAccount_pw(encoded_password);
		
		int cnt = file_submit_mapper.insertAccountWithFile(file_submit);
		
		addFiles(file_submit.getAccount_num(), files);
		
		return cnt == 1;
	}
	
	private void addFiles(String account_num, MultipartFile[] files) {
		// 파일 등록 
		if (files != null) {
			for (MultipartFile file : files) {
				if (file.getSize() > 0) {
					file_submit_mapper.insertFile(account_num, file.getOriginalFilename());
					saveFile(account_num, file); // 로컬 서버에 저장
//					saveFileAwsS3(account_num, file); // s3에 업로드
				}
			}
		}
	}

//	private void saveFileAwsS3(String account_num, MultipartFile file) {
//		String key = "account/" + account_num + "/" + file.getOriginalFilename();
//		
//		PutObjectRequest put_object_request = PutObjectRequest.builder()
//															  .acl(ObjectCannedACL.PUBLIC_READ)
//															  .bucket(bucket_name)
//															  .key(key)
//															  .build();
//		
//		RequestBody request_body;
//		try {
//			request_body = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
//			s3.putObject(put_object_request, request_body);
//		} catch (IOException e) {
//			e.printStackTrace();
//
//			throw new RuntimeException(e);
//		}		
//		
//	}

	private void saveFile(String account_num, MultipartFile file) {
		// 디렉토리 만들기
		String path_str = "C:/imgtmp/account/" + account_num + "/";
		File path = new File(path_str);
		path.mkdirs();
		
		// 작성할 파일
		File des = new File(path_str + file.getOriginalFilename());
		
		try {
			// 파일 저장
			file.transferTo(des);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
			
			throw new RuntimeException(e);
		}
		
	}
	
	public FileSubmitDto getAccountByAccountNumWithFile(String account_num) {
		FileSubmitDto file_submit = file_submit_mapper.selectAccountByAccountNum(account_num);
		List<String> file_names = file_submit_mapper.selectFileNameByAccountNum(account_num);
		
		file_submit.setFile_name(file_names);
				
		return file_submit;
	}

	@Transactional
	public boolean modifyAccountWithFile(FileSubmitDto file_submit, List<String> remove_file_list, MultipartFile[] add_file_list) {
		
		if (remove_file_list != null) {
			for (String file_name : remove_file_list) {
//				deleteFromAwsS3(file_submit.getAccount_user_id(), file_name);
				file_submit_mapper.deleteFileByAccountNumAndFileName(file_submit.getAccount_num(), file_name);
			}
		}
		
		if (add_file_list != null) {
			// File 테이블에 추가된 파일 insert
			// s3에 upload
			addFiles(file_submit.getAccount_num(), add_file_list);
		}		
		
		String encoded_password = password_encoder.encode(file_submit.getAccount_pw());
		
		file_submit.setAccount_pw(encoded_password);
		
		int cnt = file_submit_mapper.updateAccountWithFile(file_submit);
		return cnt == 1;
	}

	@Transactional
	public boolean removeAccountWithFile(String account_num) {
		// 파일 목록 읽기
		List<String> file_list = file_submit_mapper.selectFileNameByAccountNum(account_num);
		
		removeFiles(account_num, file_list);
		
		int cnt = account_mapper.deleteAccount(account_num);
		return cnt == 1;
	}
	
	private void removeFiles(String account_num, List<String> file_list) {
		// s3에서 지우기
		for (String file_name : file_list) {
//			deleteFromAwsS3(account_num, file_name);
		}
		
		// 파일테이블 삭제
		file_submit_mapper.deleteFileByAccountNum(account_num);
	}

//	private void deleteFromAwsS3(String account_num, String file_name) {
//		String key = "account/" + account_num + "/" + file_name;
//		
//		DeleteObjectRequest delete_object_request = DeleteObjectRequest.builder()
//																	   .bucket(bucket_name)
//																	   .key(key)
//																	   .build();
//		
//		s3.deleteObject(delete_object_request);
//	}
	
}
