package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReplyDto {

	private int id;
	
	private int product_id;
	
	private String detail;
	
	private String member_id;
	
	private String writer_nickname;
	
	private LocalDateTime date;
	
}
