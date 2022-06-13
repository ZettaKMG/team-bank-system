package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.mapper.ProductMapper;
import com.klk.bank.mapper.ReplyMapper;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private ReplyMapper replyMapper;

	public List<ProductDto> listProduct(String keyword) {
		
		return productMapper.selectProductAll(keyword);
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
		
		// Reply 테이블 삭제
		replyMapper.deleteByProductId(id);
		
		return productMapper.deleteProduct(id) == 1;
	}
}
