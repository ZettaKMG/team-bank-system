package com.klk.bank.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.ReplyDto;
import com.klk.bank.service.ProductService;
import com.klk.bank.service.ReplyService;

@Controller
@RequestMapping("products")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private ReplyService replyService;
	
	// 상품 조회
	@GetMapping("search")
	public void searchPage(String keyword, String type, Model model) {
		List<ProductDto> list = productService.listProduct(type, keyword);
		
		model.addAttribute("product_list", list);
	}	
	
	// 상품 등록
	@GetMapping("registration")
	public void registrationPage() {
		
	}
	
	@PostMapping("registration")
	public String registrationPage(ProductDto product, RedirectAttributes rttr) {
		boolean success = productService.insertProduct(product);
		
		if (success) {
			rttr.addFlashAttribute("message", "상품정보가 정상 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "상품정보가 등록되지 않았습니다.");
		}
		
		return "redirect:/product/search";
	}

	// 상품 상세정보
	@GetMapping("detail")
	public void searchDetailPage(int id, Model model) {
		
		ProductDto product = productService.getProductById(id);
		List<ReplyDto> replyList = replyService.getReplyByProductId(id);
		model.addAttribute("product", product);
		model.addAttribute("replyList", replyList);
		
	}

	// 상품 수정
	@GetMapping("edit")
	public void editPage() {
		
	}
	
	@PostMapping("edit")
	public String editPage(ProductDto product, RedirectAttributes rttr) {
		
		boolean success = productService.updateProduct(product);
		
		if (success) {
			rttr.addFlashAttribute("message", "상품 정보가 수정되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "상품 정보가 수정되지 않았습니다.");
		}
		
		return "redirect:/product/detail";
		
	}
	
	// 상품 삭제
	@PostMapping("remove")
	public String remove(ProductDto product, RedirectAttributes rttr) {
		
		boolean success = productService.deleteProduct(product.getId());
		
		if (success) {
			rttr.addFlashAttribute("message", "상품 정보가 삭제되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "상품 정보가 삭제되지 않았습니다.");
		}
		
		return "redirect:/product/search";
	}
	
}
