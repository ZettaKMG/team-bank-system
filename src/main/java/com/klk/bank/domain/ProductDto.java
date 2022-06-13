package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ProductDto {
	
	private int id;
	
	private String item_name;
	
	private int rate;
	
	private int exp_period;
	
	private LocalDateTime date;
	
	private String sav_method;
	
}
