package com.klk.bank.service;

import java.math.BigDecimal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.AccountPageInfoDto;
import com.klk.bank.mapper.AccountMapper;

@Service
public class AccountService {
	
	@Autowired
	private AccountMapper account_mapper;
	
	public List<AccountDto> listAccount(AccountPageInfoDto page_info, String type, String keyword) {
		
		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return account_mapper.selectAllAccount(from, row_per_page, type, "%" + keyword + "%");
	}

	public boolean addAccount(AccountDto account) {
		int cnt = account_mapper.insertAccount(account);
		return cnt == 1;
	}

	public AccountDto getAccount(String account_num) {
		
		return account_mapper.selectAccount(account_num);
	}

	public boolean modifyAccount(AccountDto account) {
		int cnt = account_mapper.updateAccount(account);
		return cnt == 1;
	}

	public boolean removeAccount(String account_num) {
		int cnt = account_mapper.deleteAccount(account_num);
		return cnt == 1;
	}

	public int searchCountAccount(String type, String keyword) {
		
		return account_mapper.selectSearchCountAccount(type, keyword);
	}

	public boolean hasAccountNum(String account_num) {
		return account_mapper.countAccountNum(account_num) > 0;
	}
	
	@Transactional
	public boolean transferAccount(String send_account_num, String send_account_cost, String receive_account_num) {
		
		AccountDto account1 = account_mapper.selectAccount(send_account_num);
		AccountDto account2 = account_mapper.selectAccount(receive_account_num);
		
		BigDecimal b1 = new BigDecimal(send_account_cost);
		BigDecimal b2 = new BigDecimal(send_account_cost);
		
		b1 = account1.getAccount_balance().subtract(b1);
		
		
		b2 = account2.getAccount_balance().add(b2);
		
		
		
		account1.setAccount_balance(b1);
		account2.setAccount_balance(b2);
		
		int cnt1 = account_mapper.updateAccount(account1);
		int cnt2 = account_mapper.updateAccount(account2);
		
		return (cnt1 == 1) && (cnt2 == 1);
	}
	
}
