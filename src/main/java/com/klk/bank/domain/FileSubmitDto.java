package com.klk.bank.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class FileSubmitDto {
	
//	private int id;
//	private String user_id;
	private String item_name;	
	private String summary;	
	private String sav_method;	
	private Integer exp_period;	
	private BigDecimal rate;	
	private String detail;	
	private LocalDateTime date;	
//	private String account_num;	
	private List<String> file_name;	
	private boolean hasFile;
	
	private String account_num;
	private String account_user_id;
	private String account_user_name;
	private Integer account_item_id;
	private String account_pw;
	private BigDecimal account_balance;
	private LocalDateTime account_date;
	
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
