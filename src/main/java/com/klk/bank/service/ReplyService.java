package com.klk.bank.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.domain.ReplyDto;
import com.klk.bank.mapper.ReplyMapper;

@Service
public class ReplyService {

	@Autowired
	private ReplyMapper replyMapper;

	public List<ReplyDto> getReplyByProductId(int id) {
		// TODO Auto-generated method stub
		return null;
	}
}
