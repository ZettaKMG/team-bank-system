package com.klk.bank.service;

import java.util.List;

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

	public List<QnaReplyDto> getReplyByQnaId(int qna_id) {
		return qnaRepMapper.selectQnaReplyById(qna_id);
	}

	public List<QnaReplyDto> getReplyWithOwnByQnaId(int qna_id, String user_id) {
		return qnaRepMapper.selectAllQnaReplyById(qna_id, user_id);
	}

}
