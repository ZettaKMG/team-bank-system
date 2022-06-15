package com.klk.bank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.AccountPageInfoDto;
import com.klk.bank.service.AccountService;

@Controller
@RequestMapping("account")
public class AccountController {
	
	@Autowired
	private AccountService account_service;
	
	@RequestMapping("account_list")
	public void accountList(@RequestParam(name = "page", defaultValue = "1") int page,
							@RequestParam(name = "type", defaultValue = "") String type,
							@RequestParam(name = "keyword", defaultValue = "") String keyword, 
							Model model) {
		
		AccountPageInfoDto page_info = new AccountPageInfoDto();
		page_info.setCurrent_page(page);
		
		int total_record = account_service.searchCountAccount(type, keyword);
		int end_page = (total_record - 1) / page_info.getRowPerPage() + 1;
		page_info.setEnd_page(end_page);
						
		List<AccountDto> account_list = account_service.listAccount(page_info, type, keyword);
				
		model.addAttribute("account_list", account_list);
		model.addAttribute("keyword", keyword);
		model.addAttribute("account_page_info", page_info);
	}
	
	@GetMapping("account_register")
	public void accountRegister() {
		
	}
	
	@PostMapping("account_register")
	public String accountRegister(AccountDto account) {
		
		boolean success = account_service.addAccount(account);
		
		return "redirect:/account/account_list";
	}
	
	@GetMapping("{account_num}")
	public String accountGet(@PathVariable("account_num")String account_num, Model model) {
		AccountDto account = account_service.getAccount(account_num);
		
		model.addAttribute("account", account);
		
		return "account/account_get";
	}
	
	@PostMapping("account_modify")
	public String accountModify(AccountDto account) {
		boolean success = account_service.modifyAccount(account);
		
		return "redirect:/account/" + account.getAccount_num();
	}
	
	@PostMapping("account_remove")
	public String accountRemove(String account_num) {
		boolean success = account_service.removeAccount(account_num);
		
		return "redirect:/account/account_list";
	}
	
	@PostMapping(path = "account_check", params = "account_num")
	@ResponseBody
	public String accountCheck(String account_num) {
		boolean exist = account_service.hasAccountNum(account_num);
		
		if(exist) {
			return "notOk";
		} else {
			return "ok";
		}
	}
	
	@RequestMapping("account_transfer")
	public void accountTransfer() {
		
	}
	
}
