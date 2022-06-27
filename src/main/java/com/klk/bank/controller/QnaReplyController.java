package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
	@PostMapping("list")
	@ResponseBody
	public List<QnaReplyDto> list(int qna_id, Principal principal) {
		if (principal == null) {
			return qnaRepService.getReplyByQnaId(qna_id);
		} else {
			return qnaRepService.getReplyWithOwnByQnaId(qna_id, principal.getName());
		}
	}
	
	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> qnaReplyModify(@RequestBody QnaReplyDto dto, Principal principal) {
		
		if(principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = qnaRepService.updateQnaReply(dto, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글이 변경되었습니다.");
			}
			return ResponseEntity.status(500).body("");			
		}		
	}
}
