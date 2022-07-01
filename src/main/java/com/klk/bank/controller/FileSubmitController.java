package com.klk.bank.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klk.bank.domain.FileSubmitDto;
import com.klk.bank.domain.UserDto;
import com.klk.bank.service.FileSubmitService;

@Controller
@RequestMapping("account")
public class FileSubmitController {
	
	@Autowired
	private FileSubmitService file_submit_service;
	
	@GetMapping("account_register")
	public void accountRegisterWithFile(FileSubmitDto file_submit, Model model) {
		
		model.addAttribute("file_submit", file_submit);
	}
	
	@PostMapping("account_register")
	public String AccountRegisterWithFile(FileSubmitDto file_submit, MultipartFile[] file, Principal principal, Model model) {
		
		if (file != null) {
			List<String> file_list = new ArrayList<String>();
			for (MultipartFile f : file) {
				file_list.add(f.getOriginalFilename());
			}
			
			file_submit.setFile_name(file_list);			
		}
		
		file_submit.setAccount_num(principal.getName());
		boolean success = file_submit_service.addAccountWithFile(file_submit, file);
		
		if (success) {
			
			return "redirect:/account/" + file_submit.getAccount_num();
			
		} else {
			
			return "redirect:/account/account_register";
		}
	}
	
	@GetMapping("{account_num}")
	public String accountGetWithFile(@PathVariable("account_num")String account_num, FileSubmitDto file_submit, Model model) {
				
		file_submit = file_submit_service.getAccountByAccountNumWithFile(account_num);
		
//		System.out.println(product);
//		System.out.println(user);
//		System.out.println(account);
		
		model.addAttribute("file_submit", file_submit);
		
		return "account/account_get";
	}
	
	@PostMapping("account_get")
	public void accountGetWithFile(@PathVariable("account_num") String account_num, FileSubmitDto file_submit, UserDto user, Model model) {
//		System.out.println(user);

		model.addAttribute("file_submit", file_submit);
		model.addAttribute("user", user);
	}
	
	@PostMapping("account_modify")
	public String accountModifyWithFile(FileSubmitDto file_submit, @RequestParam(name = "remove_file_list", required = false) ArrayList<String> remove_file_list, MultipartFile[] add_file_list, Principal principal, RedirectAttributes rttr) {
		
		boolean success = file_submit_service.modifyAccountWithFile(file_submit, remove_file_list, add_file_list);
		
		if (success) {
			rttr.addFlashAttribute("message", "계좌 정보가 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "계좌 정보가 수정되지 않았습니다.");
		}
		
		return "redirect:/account/" + file_submit.getAccount_num();
	}
	
	@PostMapping("account_remove")
	public String accountRemoveWithFile(String account_num, RedirectAttributes rttr) {
		boolean success = file_submit_service.removeAccountWithFile(account_num);
		
		if (success) {
			rttr.addFlashAttribute("message", "계좌 정보가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "계좌 정보가 삭제되지 않았습니다.");
		}
		
		return "redirect:/account/account_list";
	}
}
