package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonArrayFormatVisitor;
import com.klk.bank.domain.UserDto;
import com.klk.bank.service.UserService;

@Controller
@RequestMapping("user")
public class UserContorller {
	
	@Autowired
	UserService userService;
	
	// 로그인
	@GetMapping("login")
	public void loginPage(String error, String logout, Model model) {
		if(error != null) {
			model.addAttribute("LoginFailMessage", "로그인 오류, 계정을 확인해 주세요.");
		}
		if(logout != null) {
			model.addAttribute("logout", "로그아웃 되었습니다.");
		}		
	}
	
	@GetMapping("logout")
	public void logout() {
		
	}
	
	@GetMapping("signup")
	public void signupPage() {}
	
	// 회원 가입
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
	
	// 아이디 중복 체크
	@GetMapping(path="check", params="user_id")
	@ResponseBody
	public String idCheck(String user_id) {
		boolean exist = userService.hasUserId(user_id);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}
	
	// 이메일 중복 체크
	@GetMapping(path="check", params="user_email")
	@ResponseBody
	public String emailCheck(String user_email) {
		boolean exist = userService.hasUserEmail(user_email);
		
		if(exist) {
			return "unavailable";
		} else {
			return "available";
		}
	}
	
	// 회원 목록 페이지
	@GetMapping("list")
	public void userListPage(Model model, @RequestParam(name = "role", defaultValue = "") String role) {
		List<UserDto> userList = userService.getUserList(role);
		model.addAttribute("userList", userList);	
	}
	
	// ajax 회원 리스트 불러오기
	@PostMapping("list")
	@ResponseBody
	public List<UserDto> list(@RequestParam(name = "role", defaultValue = "") String role) {
		return userService.getUserList(role);
	}
	
	// 회원 ID 검색 기능
	@PostMapping("search")
	@ResponseBody
	public List<UserDto> searchUserList(@RequestParam(name = "role", defaultValue = "") String role, @RequestParam(name = "keyword", defaultValue = "") String keyword) {
		return userService.getUserListById(role, keyword);
	}
	
	@GetMapping("info")
	public String getUser(String user_id, Principal principal, HttpServletRequest request, Model model) {
		// 본인인지 관리자 권한을 가지고 있는지 확인
		if (hasAuthOrAdmin(user_id, principal, request)) {
			// 회원 정보 불러오기
			UserDto userDto = userService.getUserById(user_id);
			model.addAttribute("user", userDto);
			
			return null;
		}

		return "redirect:/user/login";
	}

	private boolean hasAuthOrAdmin(String user_id, Principal principal, HttpServletRequest request) {
		return request.isUserInRole("ROLE_ADMIN") || (principal != null && principal.getName().equals(user_id));
	}
	
	@PostMapping("modify")
	public String modifyUser(UserDto userDto, String oldPassword, Principal principal, HttpServletRequest request, RedirectAttributes rttr) {
		// 본인인지 관리자 권한을 가지고 있는지 확인		
		if(hasAuthOrAdmin(userDto.getUser_id(), principal, request)) {
			// 회원 정보 변경 진행
			boolean success = userService.modifyUser(userDto, oldPassword);
			
			if(success) {
				rttr.addFlashAttribute("message", "회원 정보가 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "회원 정보가 수정되지 않았습니다.");
			}
			
			rttr.addFlashAttribute("user", userDto);
			rttr.addAttribute("user_id", userDto.getUser_id());
			
			return "redirect:/user/info";
		} else {
			return "redirect:/user/login";			
		}
	}
	
	@PostMapping("remove")
	public String removeMember(UserDto userDto, Principal principal, HttpServletRequest request, RedirectAttributes rttr) {
		// 본인인지 관리자 권한을 가지고 있는지 확인
		if(hasAuthOrAdmin(userDto.getUser_id(), principal, request)) {
			// 회원 탈퇴 진행
			boolean success = userService.removeUser(userDto);
			
			if(success) {
				rttr.addFlashAttribute("message", "탈퇴되었습니다.");
				return "redirect:/user/login";
			} else {
				rttr.addAttribute("user_id", userDto.getUser_id());
				return "redirect:/user/info";
			}
		} else {
			return "redirect:/user/login";
		}
	}
	
	// 로그인한 유저의 권한 확인 메소드
	@PostMapping("auth")
	public String modifyAuth(@RequestParam("user_id") String user_id, @RequestParam("user_role") String user_role) {
		userService.modifyUserRole(user_id, user_role);
		return "redirect:/user/list";
	}
	
}
