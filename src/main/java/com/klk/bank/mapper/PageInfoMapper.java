package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.ProductDto;

public interface PageInfoMapper {
	List<ProductDto> listProductPage(@Param("from") int from, @Param("row_per_page") int row_per_page);
	
	int countProduct();
}
