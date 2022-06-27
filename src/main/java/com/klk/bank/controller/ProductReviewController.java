package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.klk.bank.domain.ProductReviewDto;
import com.klk.bank.service.ProductReviewService;



@RequestMapping("product_review")
@RestController
public class ProductReviewController {
	
	private ProductReviewService product_review_service;
	
	@GetMapping("list")
	public List<ProductReviewDto> productReviewList(int product_rev_item_id) {
		
		return product_review_service.getProductReview(product_rev_item_id);	
	}
	
	@PostMapping("insert")
	public ResponseEntity<String> productReviewAdd(ProductReviewDto dto, Principal principal) {
		
		if(principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			dto.setProduct_rev_user_id(principal.getName());
			
			boolean success = product_review_service.addProductReview(dto);
			
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}
	}
	
}
