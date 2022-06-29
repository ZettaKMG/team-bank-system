package com.klk.bank.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.klk.bank.domain.ProductDto;

public interface ProductMapper {

	List<ProductDto> selectProductAll(@Param("from") int from, @Param("row_per_page") int row_per_page, @Param("keyword") String keyword, @Param("sav_method") String sav_method, @Param("exp_period") String exp_period, @Param("rate") String rate);

	int insertProduct(ProductDto product);

	ProductDto selectProductById(int id);

	int updateProduct(ProductDto product);
	
	int deleteProduct(int id);
	
	//void insertFile(@Param("account_num") String account_num, @Param("file_name") String file_name);

	//void deleteFileByAccountNum(String account_num);

	//List<String> selectFileNameByAccountNum(String account_num);

	//void deleteFileByAccountNumAndFileName(@Param("account_num") String account_num, @Param("file_name") String file_name);

	int selectSearchCountProduct(@Param("sav_method") String sav_method, @Param("exp_period") String exp_period, @Param("rate") String rate, @Param("keyword") String keyword);

}
