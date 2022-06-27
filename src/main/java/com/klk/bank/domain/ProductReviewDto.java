package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProductReviewDto {
	private int id;
	private int product_rev_item_id;
	private String product_rev_user_id;
	private String product_rev_content;
	private LocalDateTime product_rev_inserted;
	private boolean own;
}
