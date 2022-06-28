package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.ProductPageInfoDto;
import com.klk.bank.mapper.ProductMapper;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;
	
//	@Autowired
//	private ReplyMapper replyMapper;

//	public List<ProductDto> listProduct(String keyword, String sav_method, String exp_period, String rate) {
//		
//		return productMapper.selectProductAll("%" + keyword + "%", sav_method, exp_period, rate);
//	}
	
	public List<ProductDto> listProduct(ProductPageInfoDto page_info, String keyword, String sav_method, String exp_period, String rate) {

		int row_per_page = page_info.getRowPerPage();
		int from = (page_info.getCurrent_page() - 1) * row_per_page;
		
		return productMapper.selectProductAll(from, row_per_page, "%" + keyword + "%", sav_method, exp_period, rate);
	}

	@Transactional
	public boolean insertProduct(ProductDto product) {
		// 상품 정보 등록
		int count = productMapper.insertProduct(product);
		
		return count == 1;
	}

	public ProductDto getProductById(int id) {
		ProductDto product = productMapper.selectProductById(id);		
		
		return product;
	}

	@Transactional
	public boolean updateProduct(ProductDto product) {

		// Product 테이블 update
		int count = productMapper.updateProduct(product);
		
		return count == 1;
	}

	@Transactional
	public boolean deleteProduct(int id) {
		
//		// Reply 테이블 삭제
//		replyMapper.deleteByProductId(id);
		
		return productMapper.deleteProduct(id) == 1;
	}

	public int searchCountAccount(String sav_method, String exp_period, String rate, String keyword) {

		return productMapper.selectSearchCountProduct(sav_method, exp_period, rate, keyword);
	}

}
