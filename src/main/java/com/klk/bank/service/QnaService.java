package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.klk.bank.domain.QnaDto;
import com.klk.bank.mapper.QnaMapper;
import com.klk.bank.mapper.QnaReplyMapper;

@Service
public class QnaService {
	
	@Autowired
	QnaMapper qnaMapper;
	
	@Autowired
	QnaReplyMapper qnaRepMapper; 

	public void insertQnaBoard(QnaDto qna) {
		qnaMapper.insertQnaBoard(qna);
	}

	public List<QnaDto> qnaBoardList() {
		return qnaMapper.selectQnaBoardAll();
	}

	public QnaDto getQnaBoardById(int id) {
		return qnaMapper.selectQnaBoardById(id);
	}

	public void updateQnaBoard(QnaDto qna) {
		qnaMapper.updateQnaBoard(qna);
	}
	
	@Transactional
	public void deleteQnaBoard(QnaDto qna) {
		// 글에 달린 댓글 삭제
		qnaRepMapper.deleteRepByQnaId(qna.getId());
		// 글 삭제
		qnaMapper.deleteQnaBoard(qna);
	}
	
	
}
