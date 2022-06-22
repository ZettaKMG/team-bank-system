package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnaDto {
	private int id;
	private int uid;
	private String user_id;
	private String title;
	private String body;
	private LocalDateTime inserted;
}
