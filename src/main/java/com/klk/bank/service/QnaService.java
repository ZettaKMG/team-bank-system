package com.klk.bank.service;

import java.util.List;

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

	public List<QnaDto> qnaBoardList() {
		return qnaMapper.selectQnaBoardAll();
	}
	
	
}
