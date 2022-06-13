package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.UserDto;

public interface UserMapper {

	int insertUser(UserDto userDto);

	int insertAuth(@Param("userId") String userId, @Param("auth") String auth);

	int countUserId(String userId);

	int countUserEmail(String userEmail);

	UserDto selectUserById(String userId);

	int updateUser(UserDto userDto);

	void deleteAuthById(String userId);

	int deleteUserById(String userId);

	List<UserDto> selectAllUserList();

}
