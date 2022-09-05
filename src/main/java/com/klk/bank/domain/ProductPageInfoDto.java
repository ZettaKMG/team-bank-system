package com.klk.bank.domain;

import lombok.Data;

@Data
public class ProductPageInfoDto {
	private int current_page;
	private int end_page;
	private static final int row_per_page = 5;
	
	public int getLeft() {
		return Math.max(1, current_page - 5);
	}
	
	public int getRight() {
		return Math.min(end_page, current_page + 5);
	}
	
	public int getRowPerPage() {
		return row_per_page;
	}
}
