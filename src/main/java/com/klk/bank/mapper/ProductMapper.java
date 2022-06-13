package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.ProductDto;

public interface ProductMapper {

	List<ProductDto> selectProductAll(@Param("keyword") String keyword);

	int insertProduct(ProductDto product);

	ProductDto selectProductById(int id);

	int updateProduct(ProductDto product);
	
	int deleteProduct(int id);

}
