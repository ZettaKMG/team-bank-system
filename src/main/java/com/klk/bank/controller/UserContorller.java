package com.klk.bank.controller;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
	public String getUser(String userId, Principal principal, HttpServletRequest request, Model model) {
		if (hasAuthOrAdmin(userId, principal, request)) {
			UserDto userDto = userService.getUserById(userId);
			model.addAttribute("user", userDto);
			
			return null;
		}

		return "redirect:/user/login";
	}

	private boolean hasAuthOrAdmin(String userId, Principal principal, HttpServletRequest request) {
		return request.isUserInRole("ROLE_ADMIN") || (principal != null && principal.getName().equals(userId));
	}
	
	@PostMapping("modify")
	public String modifyUser(UserDto userDto, String oldPassword, Principal principal, HttpServletRequest request, RedirectAttributes rttr) {
				
		if(hasAuthOrAdmin(userDto.getUserId(), principal, request)) {
			boolean success = userService.modifyUser(userDto, oldPassword);
			
			if(success) {
				rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
			}
			
			rttr.addFlashAttribute("user", userDto); // model object
			rttr.addAttribute("userId", userDto.getUserId()); // query string
			
			return "redirect:/user/info";
		} else {
			return "redirect:/user/login";			
		}
	}
	
	@PostMapping("remove")
	public String removeMember(UserDto userDto, Principal principal, HttpServletRequest request, RedirectAttributes rttr) {
		
		if(hasAuthOrAdmin(userDto.getUserId(), principal, request)) {
			boolean success = userService.removeUser(userDto);
			
			if(success) {
				rttr.addFlashAttribute("message", "탈퇴되었습니다.");
				return "redirect:/user/login";
			} else {
				rttr.addAttribute("userId", userDto.getUserId());
				return "redirect:/user/info";
			}
		} else {
			return "redirect:/user/login";
		}
	}
}
