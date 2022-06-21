package com.klk.bank.dummy;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.UserDto;

public interface OpenAnAccountMapper {

	// 상품 정보
	List<OpenAnAccountDto> selectProductAll(@Param("keyword") String keyword, @Param("sav_method") String sav_method, @Param("exp_period") String exp_period, @Param("rate") String rate);

	int insertProduct(OpenAnAccountDto product);

	OpenAnAccountDto selectProductById(int id);

	int updateProduct(OpenAnAccountDto product);
	
	int deleteProduct(int id);
	
	// 회원 정보
	int insertUser(OpenAnAccountDto userDto);

	int insertAuth(@Param("user_id") String user_id, @Param("auth") String auth);

	int countUserId(String user_id);

	int countUserEmail(String user_email);

	UserDto selectUserById(String user_id);

	int updateUser(OpenAnAccountDto userDto);

	void deleteAuthById(String user_id);

	int deleteUserById(String user_id);

	List<OpenAnAccountDto> selectAllUserList(@Param("role") String role);

	void updateAuth(@Param("user_id") String user_id, @Param("user_role") String user_role);		
	
	// 계좌 정보
	List<OpenAnAccountDto> selectAllAccount(@Param("from")int from, @Param("row_per_page")int row_per_page, @Param("type") String type, @Param("keyword")String keyword);

	int insertAccount(OpenAnAccountDto account);

	OpenAnAccountDto selectAccount(String account_num);

	int updateAccount(OpenAnAccountDto account);

	int deleteAccount(String account_num);

	int selectSearchCountAccount(@Param("type") String type, @Param("keyword")String keyword);

	int countAccountNum(String account_num);	
	
}
