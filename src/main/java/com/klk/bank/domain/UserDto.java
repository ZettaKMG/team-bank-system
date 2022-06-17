package com.klk.bank.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class UserDto {
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_address;
	private String user_phone;
	private String user_email;
	private String user_role;
	private Date user_birth;
}
