package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.UserDto;

public interface UserMapper {

	int insertUser(UserDto userDto);

	int insertAuth(@Param("user_id") String user_id, @Param("auth") String auth);

	int countUserId(String user_id);

	int countUserEmail(String user_email);

	UserDto selectUserById(String user_id);

	int updateUser(UserDto userDto);

	void deleteAuthById(String user_id);

	int deleteUserById(String user_id);

	List<UserDto> selectAllUserList(@Param("role") String role);

	void updateAuth(@Param("user_id") String user_id, @Param("user_role") String user_role);

}
