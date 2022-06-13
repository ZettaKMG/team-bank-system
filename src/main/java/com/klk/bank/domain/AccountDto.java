package com.klk.bank.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class AccountDto {
	private String account_num;
	private String account_user_id;
	private Integer account_item_id;
	private String account_pw;
	private BigDecimal account_balance;
	private LocalDateTime account_date;
}
