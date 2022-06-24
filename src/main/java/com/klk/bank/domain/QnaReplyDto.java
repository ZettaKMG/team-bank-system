package com.klk.bank.domain;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class QnaReplyDto {
	private int id;
	private int qna_id;
	private String user_id;
	private String qna_rep_content;
	private LocalDateTime qna_rep_inserted;
	private int qna_rep_parent;
	private int qna_rep_dep;
	
	public void setIncreseRepDep(int depth) {
		this.qna_rep_dep = depth + 1;
	}
}
