package com.klk.bank.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class UserDto {
	private String userId;
	private String userPw;
	private String userName;
	private String userAddress;
	private String userPhone;
	private String userEmail;
	private Date userBirth;
}
