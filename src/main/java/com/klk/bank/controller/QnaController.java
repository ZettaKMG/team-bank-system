package com.klk.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("qnaBoard")
public class QnaController {
	
	@GetMapping("list")
	public void qnaListPage() {
		
	}
	
	@GetMapping("write")
	public void qnaWritePage() {
		
	}
	
	@GetMapping("get")
	public void qnaGetPage() {
		
	}
}
