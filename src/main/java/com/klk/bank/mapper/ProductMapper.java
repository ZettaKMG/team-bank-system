package com.klk.bank.mapper;

import java.util.List;

import com.klk.bank.domain.ProductDto;

public interface ProductMapper {

	List<ProductDto> selectProductAll(String type, String string);

	int insertProduct(ProductDto product);

	ProductDto selectProductById(int id);

}
