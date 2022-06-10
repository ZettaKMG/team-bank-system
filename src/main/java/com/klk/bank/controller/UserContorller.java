package com.klk.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user")
public class UserContorller {
	
	@GetMapping("login")
	public void loginPage() {}
	
	@GetMapping("signup")
	public void signupPage() {}
	
	@GetMapping("userlist")
	public void adminListPage() {}
}
