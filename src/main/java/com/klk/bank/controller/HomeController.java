package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.QnaDto;
import com.klk.bank.mapper.ProductMapper;
import com.klk.bank.service.AccountService;
import com.klk.bank.service.QnaService;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	@Autowired
	QnaService qnaService;
	
	@Autowired
	AccountService accountService;
	
	@Autowired
	ProductMapper productMapper;
	
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model, Principal principal) {
		
		if(principal != null) {
			int accountNum = accountService.searchCurrentUserCountAccount(principal.getName(), "", "");
			model.addAttribute("accountNum", accountNum);
		}
		
		List<QnaDto> qnaList = qnaService.qnaBoardList();
		model.addAttribute("qnaList", qnaList);
		
		int from = 0;
		int row_per_page = 3;
		List<ProductDto> productList = productMapper.selectProductAll(from, row_per_page, "%%", "", "", "");
		model.addAttribute("productList", productList);
		return "home";
	}
	
}
