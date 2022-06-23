package com.klk.bank.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class AccountDto {
	private String account_num;
	private String account_user_id;
	private String account_user_name;
	private Integer account_item_id;
	private String account_pw;
	private BigDecimal account_balance;
	private LocalDateTime account_date;
	private List<String> file_name;
}
