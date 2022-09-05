package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.klk.bank.domain.ProductReviewDto;
import com.klk.bank.service.ProductReviewService;


@RestController
@RequestMapping("product_review")
public class ProductReviewController { 
	
	@Autowired
	private ProductReviewService product_review_service;
	
	//상품평 list출력 메소드
	@GetMapping("list")
	public List<ProductReviewDto> productReviewList(int product_rev_item_id, Principal principal) {
		
		if(principal == null) {
			// 비로그인 시			
			return product_review_service.getProductReview(product_rev_item_id, null);
		} else {
			// 로그인 시 
			return product_review_service.getProductReview(product_rev_item_id, principal.getName());
		}
			
	}
	
	//상품평 글 삽입 메소드
	@PostMapping(path = "insert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> productReviewAdd(ProductReviewDto dto, Principal principal) {
		
		if(principal == null) {
			// 비 로그인 시 에러처리
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			// 로그인 시 로그인한 사람 user_id받아서 
			dto.setProduct_rev_user_id(principal.getName());
			// 상품평 글 삽입
			boolean success = product_review_service.addProductReview(dto);
							
			if (success) {
				return ResponseEntity.ok("상품평이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}
	}
	
	//상품평 글 수정 메소드
	@PutMapping(path = "modify", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> productReviewModify(@RequestBody ProductReviewDto dto, Principal principal) {

		if (principal == null) {
			// 비 로그인 시 에러처리
			return ResponseEntity.status(401).build();
		} else {
			// 로그인 시 실행
			boolean success = product_review_service.updateProductReview(dto, principal);
			
			if (success) {
				return ResponseEntity.ok("글이 변경되었습니다.");
			}
			
			return ResponseEntity.status(500).body("");
			
		}	
	}
	
	//상품평 글 삭제 메소드
	@DeleteMapping(path = "delete/{id}", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> productReviewRemove(@PathVariable("id") int id, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.status(401).build();
		} else {
			boolean success = product_review_service.removeProductReview(id, principal);
			
			if (success) {
				return ResponseEntity.ok("상품평을 삭제 하였습니다.");
			} else {
				return ResponseEntity.status(500).body("");
			}
			
		}
	}
	
	//상품평 댓글 삽입 메소드
	@PostMapping(path = "reply_insert", produces = "text/plain;charset=UTF-8")
	public ResponseEntity<String> productReviewReplyAdd(ProductReviewDto dto, Principal principal) {
		
		if(principal == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
		} else {
			dto.setProduct_rev_user_id(principal.getName());
			
			boolean success = product_review_service.addProductReviewReply(dto);
			
			if (success) {
				return ResponseEntity.ok("새 댓글이 등록되었습니다.");
			} else {
				return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("error");
			}
		}
	}
	
}
