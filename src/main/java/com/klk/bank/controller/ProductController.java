package com.klk.bank.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.klk.bank.domain.ProductDto;
import com.klk.bank.domain.ProductPageInfoDto;
import com.klk.bank.service.AccountService;
import com.klk.bank.service.ProductService;
import com.klk.bank.service.UserService;

@Controller
@RequestMapping("product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private AccountService accountService;
		
	// 상품 조회
	@RequestMapping("search")
	public void searchPage(@RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "keyword", defaultValue = "") String keyword, @RequestParam(name = "sav_method", defaultValue = "") String sav_method, @RequestParam(name = "exp_period", defaultValue = "") String exp_period, @RequestParam(name = "rate", defaultValue = "") String rate, Model model) {
//		System.out.println(keyword);
//		System.out.println(sav_method);
//		System.out.println(exp_period);
//		System.out.println(rate);
		ProductPageInfoDto page_info = new ProductPageInfoDto();
		page_info.setCurrent_page(page);
		
		int total_record = productService.searchCountAccount(sav_method, exp_period, rate, keyword);
		int end_page = (total_record - 1) / page_info.getRowPerPage() + 1;
		page_info.setEnd_page(end_page);
		
		List<ProductDto> list = productService.listProduct(page_info, keyword, sav_method, exp_period, rate);
		
		model.addAttribute("product_list", list);
		model.addAttribute("keyword", keyword);
		model.addAttribute("product_page_info", page_info);
	}	
	
	// 상품 등록
	@GetMapping("registration")
	public void registrationPage() {
		
	}
	
	@PostMapping("registration")
	public String registrationPage(ProductDto product, Principal principal, RedirectAttributes rttr) {
				
//		product.setUser_id(principal.getName());
		boolean success = productService.insertProduct(product);
		
		if (success) {
			rttr.addFlashAttribute("message", "상품정보가 정상 등록되었습니다.");
		} else {
			rttr.addFlashAttribute("message", "상품정보가 등록되지 않았습니다.");
		}
		
		return "redirect:/product/search";
	}

	// 상품 상세정보, 수정
	@GetMapping({"detail", "edit"})
	public void searchDetailPage(@RequestParam("id") Integer id, /*@RequestParam String user_id, UserDto user,*/ Model model) {
		
		ProductDto product = productService.getProductById(id);
//		userService.getUserById(user_id);
		model.addAttribute("product", product);
//		model.addAttribute("user", user);
		
	}

	// 상품 수정
//	@GetMapping("edit")
//	public void editPage() {
//		
//	}
	
	// 상품 수정
	@PostMapping("edit")
	public String editPage(ProductDto product, Principal principal, RedirectAttributes rttr) {
		
		// 상품 정보 얻기
		ProductDto oldProduct = productService.getProductById(product.getId());
		
		// 상품 정보 작성자와 principal의 name과 비교해서 같을 때만 수정
//		if (oldProduct.getUser_id().equals(principal.getName())) {
			
			boolean success = productService.updateProduct(product);
			
			if (success) {
				rttr.addFlashAttribute("message", "상품 정보가 수정되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "상품 정보가 수정되지 않았습니다.");
			}
			
//		} else {
//			rttr.addFlashAttribute("message", "상품 정보 수정 권한이 없습니다.");
//		}
		
		rttr.addAttribute("id", product.getId());
		
		return "redirect:/product/detail";
		
	}
	
	// 상품 삭제
	@PostMapping("remove")
	public String remove(ProductDto product, Principal principal, RedirectAttributes rttr) {
		
		// 상품 정보 얻기
		ProductDto oldProduct = productService.getProductById(product.getId());
		
		// 상품 정보 작성자와 principal의 name과 비교해서 같을 때만 삭제
//		if (oldProduct.getUser_id().equals(principal.getName())) {
			
			boolean success = productService.deleteProduct(product.getId());
			
			if (success) {
				rttr.addFlashAttribute("message", "상품 정보가 삭제되었습니다.");
			} else {
				rttr.addFlashAttribute("message", "상품 정보가 삭제되지 않았습니다.");
			}
			
//		} else {
//			
//			rttr.addFlashAttribute("message", "상품 정보 삭제 권한이 없습니다.");
//			rttr.addAttribute("id", product.getId());
//			return "redirect:/product/detail";
//		}
		
		return "redirect:/product/search";
	}	
	
}
