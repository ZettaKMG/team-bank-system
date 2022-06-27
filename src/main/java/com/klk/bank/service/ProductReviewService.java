package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.ProductReviewDto;
import com.klk.bank.mapper.ProductReviewMapper;

@Service
public class ProductReviewService {
	
	@Autowired
	private ProductReviewMapper product_review_mapper;
	
	public List<ProductReviewDto> getProductReview(int product_rev_item_id) {
		
		return product_review_mapper.selectProductReview(product_rev_item_id);
	}

	public boolean addProductReview(ProductReviewDto dto) {
		// TODO Auto-generated method stub
		return product_review_mapper.insertProductReview(dto) == 1;
	}

}
