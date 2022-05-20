package com.example.demo.kbdShop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.kbdShop.svc.k_memberSVC;
import com.example.demo.kbdShop.svc.k_productSVC;
import com.example.demo.kbdShop.vo.k_productVO;

@Controller
@RequestMapping("/kbdmain")
public class k_mainController {
	
	@Autowired
	private k_memberSVC memSvc;
	
	@Autowired
	private k_productSVC prodSvc;
	
	@GetMapping("")
	public String index(Model m) {
		m.addAttribute("r_main_product_list", prodSvc.getList("r"));
		m.addAttribute("k_main_product_list", prodSvc.getList("k"));
		m.addAttribute("s_main_product_list", prodSvc.getList("s"));
		return "kbd_main";
	}
	
	@GetMapping("/admin")
	public String goAdmin() {
		if(memSvc.isAdminLogin()) {
			return "kbd_admin";
		}
		return "kbd_main";
	}
	
	@GetMapping("/upload")
	public String add() {
		if(memSvc.isAdminLogin()) { 
			return "kbd_admin_product_write";
		}
		return "redirect:/kbdmain";
	}
	
	@PostMapping("/upload")
	@ResponseBody
	public String uploadProduct(@RequestParam("files")MultipartFile[] mfiles, k_productVO prod) {
		if(prodSvc.uploadProduct(prod) && prodSvc.uploadFile(prod, mfiles)) {
			return String.format("{\"uploaded\":%b}", true);
		}else {
			return String.format("{\"uploaded\":%b}", false);
		}
	}
	
	@GetMapping("/product/list")
	public String goProductList(Model m) {
		if(memSvc.isAdminLogin()) { 
			m.addAttribute("admin_product_list", prodSvc.getListAll());
			return "kbd_admin_product_list";
		}
		return "redirect:/kbdmain";
	}
	
	@GetMapping("/product/detail/{productId}")
	public String goProductEdit(@PathVariable("productId") String pId, Model m) {
		m.addAttribute("admin_product_detail", prodSvc.getProduct(pId));
		m.addAttribute("admin_product_Repimg_detail", prodSvc.getRepImg(pId));
		m.addAttribute("admin_product_imgs_detail", prodSvc.getImg(pId));
		return "kbd_admin_product_edit_form";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateProduct(@RequestParam("files")MultipartFile[] mfiles, k_productVO prod) {
		return String.format("{\"updated\":%b}", prodSvc.updateProduct(prod, mfiles));
	}
	
	@GetMapping("/header")
	public String goTestPage() {
		return "header";
	}
	
}
