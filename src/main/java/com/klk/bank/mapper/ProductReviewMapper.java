package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.ProductReviewDto;

public interface ProductReviewMapper {

	List<ProductReviewDto> selectAllProductReview(@Param("product_rev_item_id") int product_rev_item_id,
												  @Param("product_rev_user_id") String product_rev_user_id);

	int insertProductReview(ProductReviewDto dto);

	ProductReviewDto selectProductReview(int id);

	int updateProductReview(ProductReviewDto dto);

	int deleteProductReview(int id);

	int insertProductReviewReply(ProductReviewDto dto);

}
