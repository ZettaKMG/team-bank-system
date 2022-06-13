package com.klk.bank.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.klk.bank.service.ReplyService;

@RestController
@RequestMapping("reply")
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
}
