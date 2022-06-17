package com.klk.bank.service;

import java.util.List;

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
		String encodedPassword = passwordEncoder.encode(userDto.getUser_pw());

		// 암호화 후 세팅
		userDto.setUser_pw(encodedPassword);

		// insert member
		int cnt1 = userMapper.insertUser(userDto);

		// insert auth
		int cnt2 = userMapper.insertAuth(userDto.getUser_id(), "ROLE_USER");
		
		return cnt1 == 1 && cnt2 == 1;
	}

	public boolean hasUserId(String user_id) {
		return userMapper.countUserId(user_id) > 0;
	}

	public boolean hasUserEmail(String user_email) {
		return userMapper.countUserEmail(user_email) > 0;
	}

	public UserDto getUserById(String user_id) {
		return userMapper.selectUserById(user_id);
	}

	public boolean modifyUser(UserDto userDto, String oldPassword) {
		// db에서 member 읽어서
		UserDto oldUser = userMapper.selectUserById(userDto.getUser_id());

				String encodedPw = oldUser.getUser_pw();
				// 기존password가 일치할 때만 계속 진행
				if (passwordEncoder.matches(oldPassword, encodedPw)) {
					// 암호 인코딩
					userDto.setUser_pw(passwordEncoder.encode(userDto.getUser_pw()));

					return userMapper.updateUser(userDto) == 1;
				}
				return false;
	}
	
	@Transactional
	public boolean removeUser(UserDto userDto) {
		UserDto user = userMapper.selectUserById(userDto.getUser_id());

		String rawPw = userDto.getUser_pw();
		String encodedPw = user.getUser_pw();

		if (passwordEncoder.matches(rawPw, encodedPw)) {

			// 권한 테이블 삭제
			userMapper.deleteAuthById(userDto.getUser_id());

			// 멤버 테이블 삭제
			int cnt = userMapper.deleteUserById(userDto.getUser_id());

			return cnt == 1;
		}
		return false;
	}

	public List<UserDto> getUserList(String role) {
		return userMapper.selectAllUserList(role);
	}

	public void modifyUserRole(String user_id, String user_role) {
		userMapper.updateAuth(user_id, user_role);
	}

}
