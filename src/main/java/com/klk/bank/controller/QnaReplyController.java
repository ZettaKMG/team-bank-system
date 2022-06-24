package com.klk.bank.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.klk.bank.domain.QnaReplyDto;
import com.klk.bank.service.QnaReplyService;

@Controller
@RequestMapping("qnaReply")
public class QnaReplyController {
	
	@Autowired
	QnaReplyService qnaRepService;
	
	@PostMapping(path = "write", produces = "text/plain;charset=UTF-8")
	public String addQnaReply(QnaReplyDto dto, Principal principal) {
		if(dto.getQna_rep_parent() != 0) {
			dto.setIncreseRepDep(dto.getQna_rep_dep());
		}
		
		if(principal == null) {
			System.out.println("로그인이 필요합니다.");
		} else {
			dto.setUser_id(principal.getName());
			qnaRepService.insertQnaReply(dto);
		}
		
		return "redirect:/qnaBoard/get?id=" + dto.getQna_id();
	}
}
