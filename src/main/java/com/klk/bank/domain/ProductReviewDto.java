package com.klk.bank.domain;

import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ProductReviewDto {
	private int rownumber;
	private int id;
	private int product_rev_item_id;
	private String product_rev_user_id;
	private String product_rev_content;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss")
	private LocalDateTime product_rev_inserted;
	private boolean own;
	private int product_rev_group_num;
	private int product_rev_parent_id;
	private int product_rev_group_depth;
	private boolean product_rev_group_end = true;

}
