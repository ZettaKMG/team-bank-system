package com.klk.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.UserDto;
import com.klk.bank.mapper.UserMapper;

@Service
public class UserService {
	
	@Autowired
	UserMapper userMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	public boolean addUser(UserDto userDto) {

		// 평문 암호를 암호화
		String encodedPassword = passwordEncoder.encode(userDto.getUserPw());

		// 암호화 후 세팅
		userDto.setUserPw(encodedPassword);

		// insert member
		int cnt1 = userMapper.insertUser(userDto);

		// insert auth
		int cnt2 = userMapper.insertAuth(userDto.getUserId(), "ROLE_USER");
		
		return cnt1 == 1 && cnt2 == 1;
	}

	public boolean hasUserId(String userId) {
		return userMapper.countUserId(userId) > 0;
	}

	public boolean hasUserEmail(String userEmail) {
		return userMapper.countUserEmail(userEmail) > 0;
	}

}
