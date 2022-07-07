package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	
	// 댓글 추가
	@PostMapping(path = "write", produces = "text/plain;charset=UTF-8")
	public String addQnaReply(QnaReplyDto qnaRep, Principal principal) {
		// 부모댓글이 있을 경우 입력한 댓글의 depth값 증가
		if(qnaRep.getQna_rep_parent() != 0) {
			qnaRep.setIncreseRepDep(qnaRep.getQna_rep_dep());
		}
		
		// 로그인 되어있는지 확인
		if(principal == null) {
		} else {
			qnaRep.setUser_id(principal.getName());
			qnaRepService.insertQnaReply(qnaRep);
		}
		
		return "redirect:/qnaBoard/get?id=" + qnaRep.getQna_id();
	}
	
	// 댓글 목록
	@PostMapping("list")
	@ResponseBody
	public List<QnaReplyDto> list(int qna_id, Principal principal) {
		
		// 로그인 되어있는지 확인
		if (principal == null) {
			return qnaRepService.getReplyWithOwnByQnaId(qna_id, null);
		} else {
			return qnaRepService.getReplyWithOwnByQnaId(qna_id, principal.getName());
		}
	}
	
	// 댓글 수정
	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> qnaReplyModify(@RequestBody QnaReplyDto dto, Principal principal) {
		
		// 로그인 되어있는지 확인
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
	
	// 댓글 삭제
	@DeleteMapping(path = "delete/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> delete(@PathVariable("id") int id, Principal principal) {
		
		// 로그인 되어있는지 확인
		if(principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = qnaRepService.deleteQnaReply(id, principal);
			
			if (success) {
				return ResponseEntity.ok("댓글을 삭제하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}			
		}		
	}
}
