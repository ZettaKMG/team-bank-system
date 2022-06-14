package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.mapper.AccountMapper;

@Service
public class AccountService {
	
	@Autowired
	private AccountMapper account_mapper;
	
	public List<AccountDto> listAccount(String type, String keyword) {
		
		return account_mapper.selectAllAccount(type, "%" + keyword + "%");
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
	
}
