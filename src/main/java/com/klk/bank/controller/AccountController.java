package com.klk.bank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.service.AccountService;

@Controller
@RequestMapping("account")
public class AccountController {
	
	@Autowired
	private AccountService account_service;
	
	@RequestMapping("account_list")
	public void AccountList(@RequestParam(name = "type", defaultValue = "") String type,
							@RequestParam(name = "keyword", defaultValue = "") String keyword, 
							Model model) {
		List<AccountDto> account_list = account_service.listAccount(type, keyword);
		
		model.addAttribute("account_list", account_list);
	}
	
	@GetMapping("account_register")
	public void AccountRegister() {
		
	}
	
	@PostMapping("account_register")
	public String AccountRegister(AccountDto account) {
		
		boolean success = account_service.addAccount(account);
		
		return "redirect:/account/account_list";
	}
	
	@GetMapping("account_get")
	public void AccountGet() {
		
	}
	
	@RequestMapping("account_transfer")
	public void AccountTransfer() {
		
	}
	
}
