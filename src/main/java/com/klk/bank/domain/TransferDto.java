package com.klk.bank.domain;

import java.math.BigDecimal;
import java.time.LocalDateTime;

import lombok.Data;

@Data
public class TransferDto {
	private int trans_id;
	private String trans_account_num;
	private String trans_div;
	private BigDecimal trans_cost;
	private LocalDateTime trans_date;
	
}
