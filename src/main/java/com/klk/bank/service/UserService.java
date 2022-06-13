package com.klk.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	public UserDto getUserById(String userId) {
		return userMapper.selectUserById(userId);
	}

	public boolean modifyUser(UserDto userDto, String oldPassword) {
		// db에서 member 읽어서
		UserDto oldUser = userMapper.selectUserById(userDto.getUserId());

				String encodedPw = oldUser.getUserPw();
				// 기존password가 일치할 때만 계속 진행
				if (passwordEncoder.matches(oldPassword, encodedPw)) {
					// 암호 인코딩
					userDto.setUserPw(passwordEncoder.encode(userDto.getUserPw()));

					return userMapper.updateUser(userDto) == 1;
				}
				return false;
	}
	
	@Transactional
	public boolean removeUser(UserDto userDto) {
		UserDto user = userMapper.selectUserById(userDto.getUserId());

		String rawPw = userDto.getUserPw();
		String encodedPw = user.getUserPw();

		if (passwordEncoder.matches(rawPw, encodedPw)) {

			// 권한 테이블 삭제
			userMapper.deleteAuthById(userDto.getUserId());

			// 멤버 테이블 삭제
			int cnt = userMapper.deleteUserById(userDto.getUserId());

			return cnt == 1;
		}
		return false;
	}

}
