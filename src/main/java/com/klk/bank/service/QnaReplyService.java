package com.klk.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.QnaReplyDto;
import com.klk.bank.mapper.QnaReplyMapper;

@Service
public class QnaReplyService {
	
	@Autowired
	QnaReplyMapper qnaRepMapper;
	
	public void insertQnaReply(QnaReplyDto dto) {
		qnaRepMapper.insertQnaReply(dto);
	}

}
