package com.klk.bank.controller;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klk.bank.domain.AccountDto;
import com.klk.bank.domain.AccountPageInfoDto;
import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.TransferDto;
import com.klk.bank.domain.UserDto;
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
							HttpServletRequest req,
							Principal principal,
							Model model) {
		
		AccountPageInfoDto page_info = new AccountPageInfoDto();
		page_info.setCurrent_page(page);
		
		if(req.isUserInRole("ROLE_USER")) {
			
			int total_record = account_service.searchCurrentUserCountAccount(principal.getName(), type, keyword);
			int end_page = (total_record - 1) / page_info.getRowPerPage() + 1;
			page_info.setEnd_page(end_page);
			
			List<AccountDto> account_list = account_service.listCurrentUserAccount(page_info, principal.getName(), type, keyword);
			
			model.addAttribute("account_list", account_list);
			model.addAttribute("keyword", keyword);
			model.addAttribute("account_page_info", page_info);
			
		} else {
			
			int total_record = account_service.searchCountAccount(type, keyword);
			int end_page = (total_record - 1) / page_info.getRowPerPage() + 1;
			page_info.setEnd_page(end_page);
			
			List<AccountDto> account_list = account_service.listAccount(page_info, type, keyword);
			
			model.addAttribute("account_list", account_list);
			model.addAttribute("keyword", keyword);
			model.addAttribute("account_page_info", page_info);
		}
	}
	
	@GetMapping("account_register")
	public void accountRegister(ProductDto product, Model model) {
				
//		System.out.println(product);
//		System.out.println(user);
		
		model.addAttribute("product", product);
//		model.addAttribute("user", user);
		
	}
	
	@PostMapping("account_register")
	public String accountRegister(AccountDto account, Model model, MultipartFile[] file, RedirectAttributes rttr) {
						
//		if (file != null) {
//			List<String> file_list = new ArrayList<String>();
//			for (MultipartFile f : file) {
//				file_list.add(f.getOriginalFilename());
//			}
//			account.setFile_name(file_list);
//		}
				
		
		boolean success = account_service.addAccount(account, file);
		
		if (success) {
//			rttr.addAttribute("message", "계좌가 개설되었습니다.");
			return "redirect:/account/" + account.getAccount_num();
		} else {
//			rttr.addAttribute("message", "계좌가 개설되지 않았습니다.");
			return "redirect:/account/account_register";
		}
		
//		return "redirect:/account/account_list";
	}
	
	@GetMapping("{account_num}")
	public String accountGet(@PathVariable("account_num")String account_num, ProductDto product, UserDto user, Model model) {
				
		AccountDto account = account_service.getAccount(account_num);
		
		System.out.println(product);
		System.out.println(user);
		System.out.println(account);
		
		model.addAttribute("account", account);		
		
		model.addAttribute("product", product);
		model.addAttribute("user", user);
		
		return "account/account_get";
	}
	
	@PostMapping("account_get")
	public void accountGet(@PathVariable("account_num") String account_num, AccountDto account, ProductDto product, UserDto user, Model model) {
		System.out.println(product);
		System.out.println(user);
		System.out.println(account);
		
		model.addAttribute("account", account);
		model.addAttribute("product", product);
		model.addAttribute("user", user);
	}
	
	@PostMapping("account_modify")
	public String accountModify(AccountDto account, @RequestParam(name = "remove_file_list", required = false) ArrayList<String> remove_file_list, MultipartFile[] add_file_list, RedirectAttributes rttr) {
		boolean success = account_service.modifyAccount(account, remove_file_list, add_file_list);
		
		if (success) {
			rttr.addFlashAttribute("message", "계좌 정보가 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "계좌 정보가 수정되지 않았습니다.");
		}
		
		return "redirect:/account/" + account.getAccount_num();
	}
	
	@PostMapping("account_remove")
	public String accountRemove(String account_num, RedirectAttributes rttr) {
		boolean success = account_service.removeAccount(account_num);
		
		if (success) {
			rttr.addFlashAttribute("message", "계좌 정보가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "계좌 정보가 삭제되지 않았습니다.");
		}
		
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
	
	@PostMapping(path = "account_pw_check", params = {"send_account_num", "send_account_pw"})
	@ResponseBody
	public String sendAccountPwCheck(String send_account_num, String send_account_pw) {
		
		boolean success = account_service.accountPwCheck(send_account_num, send_account_pw);
		
		if(success) {
			return "ok";
		} else {
			return "notOk";
		}
		
	}
	
	@PostMapping(path = "send_cost_check", params = {"send_account_num", "send_account_cost"})
	@ResponseBody
	public String sendCostCheck(String send_account_num, String send_account_cost){
		boolean exist = account_service.hasAccountNum(send_account_num);
				
		if(exist) {
			AccountDto send_account = account_service.getAccount(send_account_num);
			BigDecimal b1 = new BigDecimal(send_account_cost);
			
			int cnt1 = send_account.getAccount_balance().compareTo(b1);
			if(cnt1 < 0) {
				return "notOk";
			} else {
				return "ok";
			}			
		} 
		
		return "";
	}
	
	@PostMapping(path = "account_send_check", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> accountSendCheck(String send_account_num){
				
		boolean exist = account_service.hasAccountNum(send_account_num);
				
		if(exist) {
			AccountDto send_account = account_service.getAccount(send_account_num);
			
			return ResponseEntity.ok(send_account.getAccount_balance().toPlainString());	
		} else {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
		}
		
	}
	
	@GetMapping("account_transfer")
	public void accountTransfer() {
		
	}
	
	@PostMapping("account_transfer")
	public String accountTransfer(String send_account_num, String send_account_cost, String account_num) {
		boolean success = account_service.transferAccount(send_account_num, send_account_cost, account_num);
		
		return "redirect:/account/account_list";
	}
	
	@PostMapping("account_history")
	public void accountHistory(String account_num, Model model) {
		List<TransferDto> list = account_service.getAccountHistory(account_num);
		
		model.addAttribute("account_history", list);
	}

}
