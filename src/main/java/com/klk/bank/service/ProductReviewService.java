package com.klk.bank.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.ProductReviewDto;
import com.klk.bank.mapper.ProductReviewMapper;

@Service
public class ProductReviewService {
	
	@Autowired
	private ProductReviewMapper product_review_mapper;
	
	//상품평리스트
	public List<ProductReviewDto> getProductReview(int product_rev_item_id, String product_rev_user_id) {
		
		return product_review_mapper.selectAllProductReview(product_rev_item_id, product_rev_user_id);
	}
	
	//상품평추가
	public boolean addProductReview(ProductReviewDto dto) {
		
		int cnt1 = product_review_mapper.insertProductReview(dto);
		dto.setProduct_rev_group_num(dto.getId());
		int cnt2 = product_review_mapper.updateProductReview(dto);
		
		return cnt1 == 1 && cnt2 == 1;
	}
	
	//상품평수정
	public boolean updateProductReview(ProductReviewDto dto, Principal principal) {
		ProductReviewDto old = product_review_mapper.selectProductReview(dto.getId());
		
		if(old.getProduct_rev_user_id().equals(principal.getName())) {
			return product_review_mapper.updateProductReview(dto) == 1;
		} else {
			return false;
		}
		
	}
	
	//상품평삭제
	public boolean removeProductReview(int id, Principal principal) {
		ProductReviewDto old = product_review_mapper.selectProductReview(id);
		
		if(old.getProduct_rev_user_id().equals(principal.getName())) {
			return product_review_mapper.deleteProductReview(id) == 1;
		} else {
			return false;
		}
		
		
	}

	//상품평댓글추가
	public boolean addProductReviewReply(ProductReviewDto dto) {
		
		ProductReviewDto parent = product_review_mapper.selectProductReview(dto.getId());
		parent.setProduct_rev_group_end(false);
		product_review_mapper.updateProductReview(parent);
		
		ProductReviewDto child = new ProductReviewDto();
		child.setProduct_rev_item_id(dto.getProduct_rev_item_id());
		child.setProduct_rev_user_id(dto.getProduct_rev_user_id());
		child.setProduct_rev_content(dto.getProduct_rev_content());
		child.setProduct_rev_parent_id(parent.getId());
		child.setProduct_rev_group_num(parent.getProduct_rev_group_num());
		child.setProduct_rev_group_depth(parent.getProduct_rev_group_depth() + 1);
		child.setProduct_rev_group_end(true);
		
		return product_review_mapper.insertProductReviewReply(child) == 1;
		
	}

}
