package com.klk.bank.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klk.bank.domain.OpenAnAccountDto;
import com.klk.bank.service.AccountService;
import com.klk.bank.service.OpenAnAccountService;
import com.klk.bank.service.ProductService;
import com.klk.bank.service.UserService;

@Controller
@RequestMapping("product")
public class OpenAnAccountController {
	
	/*@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AccountService accountService;*/
	
	@Autowired
	private OpenAnAccountService openAnAccountService;
	
	// 계좌개설 페이지
	@GetMapping("openAnAccount")
	public void openAnAccountPage() {
		
	}
	
	@PostMapping("openAnAccount")
	public String openAnAccountPage(@RequestParam("id") Integer id, OpenAnAccountDto open_an_account, Principal principal, RedirectAttributes rttr, Model model) {
		System.out.println(open_an_account);
		
		open_an_account = openAnAccountService.getProductById(id);
		model.addAttribute("open_an_account", open_an_account);
		
		open_an_account.setUser_id(principal.getName());
		
		boolean success = openAnAccountService.openAnAccount(open_an_account);
		
		if (success) {
			rttr.addFlashAttribute("message", "계좌가 개설되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "계좌가 개설되지 않았습니다.");
		}
		
		rttr.addAttribute("id", open_an_account.getId());
		
		return "redirect:/product/detail";
	}
}
