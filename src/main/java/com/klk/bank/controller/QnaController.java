package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.klk.bank.domain.QnaDto;
import com.klk.bank.service.QnaService;

@Controller
@RequestMapping("qnaBoard")
public class QnaController {
	
	@Autowired
	QnaService qnaService;
	
	@GetMapping("list")
	public void qnaListPage(Model model) {
		List<QnaDto> list = qnaService.qnaBoardList();
		model.addAttribute("qnaList", list);
	}
	
	@GetMapping("write")
	public void qnaWritePage() {
		
	}
	
	@PostMapping("write")
	public String qnaWrite(QnaDto qna, Principal principal) {
		qna.setUser_id(principal.getName());
		qnaService.insertQnaBoard(qna);
		return "redirect:/qnaBoard/get?id=" + qna.getId();
	}
	
	
	@GetMapping("get")
	public void qnaGetPage(int id, Model model) {
		QnaDto qna = qnaService.getQnaBoardById(id);
		model.addAttribute("qna", qna);
	}
	
	@PostMapping("modify")
	public String qnaModify(QnaDto qna, Principal principal) {
		QnaDto oldQna = qnaService.getQnaBoardById(qna.getId());
		if(oldQna.getUser_id().equals(principal.getName())) {
			qnaService.updateQnaBoard(qna);			
		}
		
		return "redirect:/qnaBoard/get?id=" + qna.getId();
	}
	
	@PostMapping("remove")
	public String qnaRemove(QnaDto qna, Principal principal) {
		QnaDto oldQna = qnaService.getQnaBoardById(qna.getId());
		if(oldQna.getUser_id().equals(principal.getName())) {
			qnaService.deleteQnaBoard(qna);			
		}
		
		return "redirect:/qnaBoard/list";
	}
}
