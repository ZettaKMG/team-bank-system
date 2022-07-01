package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.FileSubmitDto;

public interface FileSubmitMapper {
	
	int insertAccountWithFile(FileSubmitDto file_submit);

	FileSubmitDto selectAccountByAccountNum(String account_num);

	int updateAccountWithFile(FileSubmitDto file_submit);
	
	void insertFile(@Param("account_num") String account_num, @Param("file_name") String file_name);

	void deleteFileByAccountNum(String account_num);

	List<String> selectFileNameByAccountNum(String account_num);

	void deleteFileByAccountNumAndFileName(@Param("account_num") String account_num, @Param("file_name") String file_name);



}
