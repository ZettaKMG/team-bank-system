package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.TransferDto;
import com.klk.bank.domain.UserDto;

public interface AccountMapper {

	List<AccountDto> selectAllAccount(@Param("from")int from, @Param("row_per_page")int row_per_page, @Param("type") String type, @Param("keyword")String keyword);

	int insertAccount(AccountDto account, UserDto user, ProductDto product);

	AccountDto selectAccount(String account_num);

	int updateAccount(AccountDto account);

	int deleteAccount(String account_num);

	int selectSearchCountAccount(@Param("type") String type, @Param("keyword")String keyword);

	int countAccountNum(String account_num);

	int insertTransfer(TransferDto transfer_send);

	List<TransferDto> selectTransferAccount(String account_num);

//	void insertFile(@Param("account_num") String account_num, @Param("file_name") String file_name);

	

}
