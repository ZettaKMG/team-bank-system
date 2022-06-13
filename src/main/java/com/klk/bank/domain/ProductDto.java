package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProductDto {
	
	private int id;
	
	private String memberId;
	
	private String itemName;
	
	private int rate;
	
	private int expPeriod;
	
	private LocalDateTime date;
	
	private String savMethod;
	
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
