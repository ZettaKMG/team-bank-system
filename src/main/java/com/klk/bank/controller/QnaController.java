package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.klk.bank.domain.QnaDto;
import com.klk.bank.domain.QnaPageInfoDto;
import com.klk.bank.service.QnaReplyService;
import com.klk.bank.service.QnaService;

@Controller
@RequestMapping("qnaBoard")
public class QnaController { 
	
	@Autowired
	QnaService qnaService;
	@Autowired
	QnaReplyService qnaRepService;
	
	// 문의게시판 페이지
	@GetMapping("list")
	public void qnaListPage(@RequestParam(name = "page", defaultValue = "1") int page, Model model) {
		QnaPageInfoDto page_info = new QnaPageInfoDto();
		page_info.setCurrent_page(page);
		
		int total_record = qnaService.countAllQnaList();
		int end_page = (total_record - 1) / page_info.getRowPerPage() + 1;
		page_info.setEnd_page(end_page);
		
		List<QnaDto> list = qnaService.qnaBoardList(page_info);
		model.addAttribute("qnaList", list);
		model.addAttribute("qna_page_info", page_info);
	}
	
	// 문의글 작성 페이지
	@GetMapping("write")
	public void qnaWritePage() {
		
	}
	
	// 문의글 작성 프로세스
	@PostMapping("write")
	public String qnaWrite(QnaDto qna, Principal principal) {
		if(qna.getQna_parent() != 0) {
			qna.setIncreseQnaDep(qna.getQna_dep());
		}
		qna.setUser_id(principal.getName());
		qnaService.insertQnaBoard(qna);
		return "redirect:/qnaBoard/get?id=" + qna.getId();
	}
	
	// 문의글 내용 확인 페이지
	@GetMapping("get")
	public void qnaGetPage(int id, Model model) {
		QnaDto qna = qnaService.getQnaBoardById(id);
		model.addAttribute("qna", qna);
	}
	
	// 문의글 수정 프로세스
	@PostMapping("modify")
	public String qnaModify(QnaDto qna, Principal principal) {
		QnaDto oldQna = qnaService.getQnaBoardById(qna.getId());
		
		// 문의글 작성자와 로그인한 회원 아이디가 같은지 확인
		if(oldQna.getUser_id().equals(principal.getName())) {
			qnaService.updateQnaBoard(qna);			
		}
		
		return "redirect:/qnaBoard/get?id=" + qna.getId();
	}
	
	// 문의글 삭제 프로세스
	@PostMapping("remove")
	public String qnaRemove(QnaDto qna, Principal principal) {
		QnaDto oldQna = qnaService.getQnaBoardById(qna.getId());
		
		// 문의글 작성자와 로그인한 회원 아이디가 같은지 확인
		if(oldQna.getUser_id().equals(principal.getName())) {
			qnaService.deleteQnaBoard(qna);			
		}
		
		return "redirect:/qnaBoard/list";
	}
}
