package com.klk.bank.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.klk.bank.mapper.ProductMapper;
import com.klk.bank.mapper.ReplyMapper;

@Service
public class ProductService {

	@Autowired
	private ProductMapper productMapper;
	
	@Autowired
	private ReplyMapper replyMapper;
}
