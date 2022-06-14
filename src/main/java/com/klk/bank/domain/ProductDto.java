package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProductDto {
	
	private int id;
	
	private String user_id;
	
	private String item_name;
	
	private String item_summary;
	
	private String detail;
	
	private int rate;
	
	private int exp_period;
	
	private LocalDateTime date;
	
	private String sav_method;
	
	public String getPrettyDate() {
		// 상품정보 올린지 24시간 이내면 시간만
		// 그 이전이면 년-월-일
		LocalDateTime now = LocalDateTime.now();
		if (now.minusHours(24).isBefore(date)) {
			return date.toLocalTime().toString();
		} else {
			return date.toLocalDate().toString();
		}
	}
	
}
