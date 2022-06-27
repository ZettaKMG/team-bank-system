package com.klk.bank.mapper;

import java.util.List;

import com.klk.bank.domain.ProductReviewDto;

public interface ProductReviewMapper {

	List<ProductReviewDto> selectProductReview(int product_rev_item_id);

	int insertProductReview(ProductReviewDto dto);

}
