package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
		// TODO Auto-generated method stub
		return account_mapper.countAccountNum(account_num) > 0;
	}
	
}
