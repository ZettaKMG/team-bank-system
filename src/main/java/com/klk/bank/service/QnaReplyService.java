package com.klk.bank.service;

import java.security.Principal;
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

	public List<QnaReplyDto> getReplyWithOwnByQnaId(int qna_id, String user_id) {
		return qnaRepMapper.selectAllQnaReplyByQnaId(qna_id, user_id);
	}

	public boolean updateQnaReply(QnaReplyDto dto, Principal principal) {
		QnaReplyDto old = qnaRepMapper.selectReplyByReplyId(dto.getId());
		
		if(old.getUser_id().equals(principal.getName())) {
			// 댓글 작성자와 로그인 유저가 같을때 수정
			return qnaRepMapper.updateQnaReply(dto) == 1;
		} else {
			// 다르면 return false;
			return false;
		}
	}

	public boolean deleteQnaReply(int id, Principal principal) {
		QnaReplyDto old = qnaRepMapper.selectReplyByReplyId(id);
		
		if(old.getUser_id().equals(principal.getName())) {
			return qnaRepMapper.deleteQnaReply(id) == 1;			
		} else {
			return false;
		}
	}

}
