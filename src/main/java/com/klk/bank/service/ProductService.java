package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.ProductPageInfoDto;
import com.klk.bank.mapper.ProductMapper;
import com.klk.bank.mapper.ProductReviewMapper;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private ProductReviewMapper productReviewMapper;
	

	// 상품목록 전체 불러오기(페이지네이션 적용)
	public List<ProductDto> listProduct(ProductPageInfoDto page_info, String keyword, String sav_method, String exp_period, String rate) {

		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return productMapper.selectProductAll(from, row_per_page, "%" + keyword + "%", sav_method, exp_period, rate);
	}

	// 상품 정보 등록하기
	@Transactional
	public boolean insertProduct(ProductDto product) {
		int count = productMapper.insertProduct(product);
		
		return count == 1;
	}

	// 상품 상세정보 불러오기
	public ProductDto getProductById(int id) {
		ProductDto product = productMapper.selectProductById(id);		
		
		return product;
	}

	// 상품 정보 수정하기
	@Transactional
	public boolean updateProduct(ProductDto product) {

		int count = productMapper.updateProduct(product);
		
		return count == 1;
	}

	// 상품 정보 삭제하기
	@Transactional
	public boolean deleteProduct(int id) {
		
		// 상품평 상품id로 삭제
		int cnt1 = productReviewMapper.deleteProductReviewByProductId(id);		
		int cnt2 = productMapper.deleteProduct(id);
		return cnt1 == 1 && cnt2 == 1;
	}

	// 상품 정보 조건검색 반영(페이지네이션 적용)
	public int searchCountAccount(String sav_method, String exp_period, String rate, String keyword) {
						
		return productMapper.selectSearchCountProduct(sav_method, exp_period, rate, "%" + keyword + "%");
	}

}
