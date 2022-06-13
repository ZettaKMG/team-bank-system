package com.klk.bank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klk.bank.domain.UserDto;
import com.klk.bank.service.UserService;

@Controller
@RequestMapping("user")
public class UserContorller {
	
	@Autowired
	UserService userService;
	
	@GetMapping("login")
	public void loginPage() {}
	
	@GetMapping("signup")
	public void signupPage() {}
	
	@PostMapping("signup")
	public String signupProcess(UserDto userDto, RedirectAttributes rttr) {
		boolean success = userService.addUser(userDto);
		
		if(success) {
			rttr.addFlashAttribute("message", "회원가입이 완료되었습니다.");
			return "redirect:/user/login";
		} else {
			rttr.addFlashAttribute("message", "회원가입에 실패했습니다.");
			rttr.addFlashAttribute("userDto", userDto);
			return "redirect:/user/signup";
		}
	}
	
	@GetMapping(path="check", params="userId")
	@ResponseBody
	public String idCheck(String userId) {
		boolean exist = userService.hasUserId(userId);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}
	@GetMapping(path="check", params="userEmail")
	@ResponseBody
	public String emailCheck(String userEmail) {
		boolean exist = userService.hasUserEmail(userEmail);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}
	
	@GetMapping("list")
	public void userListPage() {}
	
	@GetMapping("info")
	public void userInfoPage() {}
}
