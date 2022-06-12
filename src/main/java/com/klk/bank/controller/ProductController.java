package com.klk.bank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("products")
public class ProductController {
	
	// 상품 수정
	@GetMapping("edit")
	public void editPage() {
		
	}
	
	// 상품 등록
	@GetMapping("registration")
	public void registrationPage() {
		
	}
	
	// 상품 조회
	@GetMapping("search")
	public void searchPage() {
		
	}
	
	// 상품 상세정보
	@GetMapping("detail")
	public void searchDetailPage() {
		
	}
}
