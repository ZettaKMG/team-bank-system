package com.klk.bank.dummy;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class OpenAnAccountDto {

	// ProductDto에서 가져옴
	private int id;	
	private String user_id;	
	private String item_name;	
//	private String summary;	
	private String sav_method;	
	private Integer exp_period;	
//	private BigDecimal rate;	
//	private String detail;	
//	private LocalDateTime date;
	
//	public String getPrettyDate() {
//		// 상품정보 올린지 24시간 이내면 시간만
//		// 그 이전이면 년-월-일
//		LocalDateTime now = LocalDateTime.now();
//		if (now.minusHours(24).isBefore(date)) {
//			return date.toLocalTime().toString();
//		} else {
//			return date.toLocalDate().toString();
//		}
//	}
	
	
	// UserDto에서 가져옴
//	private String user_id;
	private String user_pw;
	private String user_name;
//	private String user_address;
//	private String user_phone;
//	private String user_email;
	private String user_role;
//	private Date user_birth;
	
	
	// AccountDto에서 가져옴
	private String account_num;
	private String account_user_id;
	private String account_user_name;
	private Integer account_item_id;
	private String account_pw;
//	private BigDecimal account_balance;
	private LocalDateTime account_date;
}
