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
	
	public List<ProductReviewDto> getProductReview(int product_rev_item_id, String product_rev_user_id) {
		
		return product_review_mapper.selectAllProductReview(product_rev_item_id, product_rev_user_id);
	}

	public boolean addProductReview(ProductReviewDto dto) {
		
		return product_review_mapper.insertProductReview(dto) == 1;
	}

	public boolean updateProductReview(ProductReviewDto dto, Principal principal) {
		ProductReviewDto old = product_review_mapper.selectProductReview(dto.getId());
		
		if(old.getProduct_rev_user_id().equals(principal.getName())) {
			return product_review_mapper.updateProductReview(dto) == 1;
		} else {
			return false;
		}
		
	}

	public boolean removeProductReview(int id, Principal principal) {
		ProductReviewDto old = product_review_mapper.selectProductReview(id);
		
		if(old.getProduct_rev_user_id().equals(principal.getName())) {
			return product_review_mapper.deleteProductReview(id) == 1;
		} else {
			return false;
		}
		
		
	}

}
