package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.mapper.PageInfoMapper;

@Service
public class PageInfoService {
	
	@Autowired
	private PageInfoMapper pageInfoMapper;
	
	public List<ProductDto> listProductPage(int page, int row_per_page){
		int from = (page - 1) * row_per_page;
		
		return pageInfoMapper.listProductPage(from, row_per_page);
	}
	
	public int countProduct() {
		return pageInfoMapper.countProduct();
	}
}
