package com.klk.bank.dummy;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.AccountPageInfoDto;
import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.UserDto;

@Service
public class OpenAnAccountService {
	
	@Autowired
	private OpenAnAccountMapper openAnAccountMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;	
	
	// 상품 정보
	/*public List<OpenAnAccountDto> listProduct(String keyword, String sav_method, String exp_period, String rate) {
		
		return openAnAccountMapper.selectProductAll("%" + keyword + "%", sav_method, exp_period, rate);
	}*/

	/*@Transactional
	public boolean insertProduct(OpenAnAccountDto product) {
		// 상품 정보 등록
		int count = openAnAccountMapper.insertProduct(product);
		
		return count == 1;
	}*/

	public OpenAnAccountDto getProductById(int id) {
		OpenAnAccountDto open_an_account = openAnAccountMapper.selectProductById(id);		
		
		return open_an_account;
	}

	/*@Transactional
	public boolean updateProduct(OpenAnAccountDto product) {
	
		// Product 테이블 update
		int count = openAnAccountMapper.updateProduct(product);
		
		return count == 1;
	}*/

	/*@Transactional
	public boolean deleteProduct(int id) {
		
	//		// Reply 테이블 삭제
	//		replyMapper.deleteByProductId(id);
		
		return openAnAccountMapper.deleteProduct(id) == 1;
	}*/
	
	
	// 회원 정보
	/*public boolean addUser(OpenAnAccountDto userDto) {
	
		// 평문 암호를 암호화
		String encodedPassword = passwordEncoder.encode(userDto.getUser_pw());
	
		// 암호화 후 세팅
		userDto.setUser_pw(encodedPassword);
	
		// insert member
		int cnt1 = openAnAccountMapper.insertUser(userDto);
	
		// insert auth
		int cnt2 = openAnAccountMapper.insertAuth(userDto.getUser_id(), "ROLE_USER");
		
		return cnt1 == 1 && cnt2 == 1;
	}*/

	public boolean hasUserId(String user_id) {
		return openAnAccountMapper.countUserId(user_id) > 0;
	}

	/*public boolean hasUserEmail(String user_email) {
		return openAnAccountMapper.countUserEmail(user_email) > 0;
	}*/

	public UserDto getUserById(String user_id) {
		return openAnAccountMapper.selectUserById(user_id);
	}

	/*public boolean modifyUser(OpenAnAccountDto userDto, String oldPassword) {
		// db에서 member 읽어서
		UserDto oldUser = openAnAccountMapper.selectUserById(userDto.getUser_id());
	
		String encodedPw = oldUser.getUser_pw();
		// 기존password가 일치할 때만 계속 진행
		if (passwordEncoder.matches(oldPassword, encodedPw)) {
			// 암호 인코딩
			userDto.setUser_pw(passwordEncoder.encode(userDto.getUser_pw()));
	
			return openAnAccountMapper.updateUser(userDto) == 1;
		}
		return false;
	}*/
	
	/*@Transactional
	public boolean removeUser(UserDto userDto) {
		UserDto user = openAnAccountMapper.selectUserById(userDto.getUser_id());
	
		String rawPw = userDto.getUser_pw();
		String encodedPw = user.getUser_pw();
	
		if (passwordEncoder.matches(rawPw, encodedPw)) {
	
			// 권한 테이블 삭제
			openAnAccountMapper.deleteAuthById(userDto.getUser_id());
	
			// 멤버 테이블 삭제
			int cnt = openAnAccountMapper.deleteUserById(userDto.getUser_id());
	
			return cnt == 1;
		}
		return false;
	}*/

	/*public List<OpenAnAccountDto> getUserList(String role) {
		return openAnAccountMapper.selectAllUserList(role);
	}*/

	/*public void modifyUserRole(String user_id, String user_role) {
		openAnAccountMapper.updateAuth(user_id, user_role);
	}*/
	
	
	// 계좌 정보
	/*public List<OpenAnAccountDto> listAccount(AccountPageInfoDto page_info, String type, String keyword) {
		
		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return openAnAccountMapper.selectAllAccount(from, row_per_page, type, "%" + keyword + "%");
	}*/

	public boolean addAccount(OpenAnAccountDto account) {
		int cnt = openAnAccountMapper.insertAccount(account);
		return cnt == 1;
	}

	public OpenAnAccountDto getAccount(String account_num) {
		
		return openAnAccountMapper.selectAccount(account_num);
	}

	public boolean modifyAccount(OpenAnAccountDto account) {
		int cnt = openAnAccountMapper.updateAccount(account);
		return cnt == 1;
	}

	public boolean removeAccount(String account_num) {
		int cnt = openAnAccountMapper.deleteAccount(account_num);
		return cnt == 1;
	}

	/*public int searchCountAccount(String type, String keyword) {
		
		return openAnAccountMapper.selectSearchCountAccount(type, keyword);
	}*/

	public boolean hasAccountNum(String account_num) {
		return openAnAccountMapper.countAccountNum(account_num) > 0;
	}
	
	/*@Transactional
	public boolean transferAccount(String send_account_num, String send_account_cost, String account_num) {
		
		int cnt1 = 0, cnt2 = 0;
		BigDecimal b1 = new BigDecimal(send_account_cost);
		BigDecimal b2 = new BigDecimal(send_account_cost);
		
		OpenAnAccountDto account1 = openAnAccountMapper.selectAccount(send_account_num);
		if(send_account_num.equals(account_num)) {
			b1 = account1.getAccount_balance().subtract(b1);
			b1 = b1.add(b2);
						
			account1.setAccount_balance(b1);
			cnt1 = openAnAccountMapper.updateAccount(account1);
			
			return cnt1 == 1;
		} else {
			
			OpenAnAccountDto account2 = openAnAccountMapper.selectAccount(account_num);
				
			b1 = account1.getAccount_balance().subtract(b1);
			b2 = account2.getAccount_balance().add(b2);
				
			account1.setAccount_balance(b1);
			account2.setAccount_balance(b2);
		
			cnt1 = openAnAccountMapper.updateAccount(account1);
			cnt2 = openAnAccountMapper.updateAccount(account2);
			
			return (cnt1 == 1) && (cnt2 == 1);
		}
	}*/

	public boolean openAnAccount(OpenAnAccountDto open_an_account) {
		// TODO Auto-generated method stub
		return false;
	}
	
}
