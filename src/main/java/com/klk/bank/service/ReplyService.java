package com.klk.bank.service;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.ReplyDto;
import com.klk.bank.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper replyMapper;

	public boolean insertReply(ReplyDto reply) {
		
		return replyMapper.insertReply(reply);
	}
	
	public List<ReplyDto> getReplyByProductId(int product_id) {
		
		return replyMapper.selectAllProductId(product_id, null);
	}
	
	public boolean updateReply(ReplyDto reply, Principal principal) {
		ReplyDto oldReply = replyMapper.selectReplyById(reply.getId());
		
		if (oldReply.getUser_id().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 수정
			return replyMapper.updateReply(reply) == 1;
		} else {
			// 그렇지 않으면 return false
			return false;
		}
		
	}

	public boolean deleteReply(int id, Principal principal) {

		ReplyDto oldReply = replyMapper.selectReplyById(id);
		
		if (oldReply.getUser_id().equals(principal.getName())) {
			// 댓글 작성자와 로그인한 유저가 같을 때만 삭제
			return replyMapper.deleteReply(id) == 1;
		} else {
			// 그렇지 않으면 return false
			return false;
		}
	}

	public List<ReplyDto> getReplyWithOwnByProductId(int product_id, String user_id) {
		
		return replyMapper.selectAllProductId(product_id, user_id);
	}
}
