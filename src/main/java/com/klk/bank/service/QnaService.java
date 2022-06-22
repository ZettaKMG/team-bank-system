package com.klk.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.QnaDto;
import com.klk.bank.mapper.QnaMapper;

@Service
public class QnaService {
	
	@Autowired
	QnaMapper qnaMapper;

	public void insertQnaBoard(QnaDto qna) {
		qnaMapper.insertQnaBoard(qna);
	}
	
	
}
