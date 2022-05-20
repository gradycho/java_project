package com.example.demo.kbdShop.controller;

import java.text.NumberFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.kbdShop.svc.k_memberSVC;
import com.example.demo.kbdShop.svc.k_productSVC;
import com.example.demo.kbdShop.vo.k_productVO;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/kbdprod")
public class k_productController {
	// list, 페이지나눔
	// 관리자 페이지 : 상품등록, 가격 & 수량 & 날짜 변경
	
	@Autowired
	k_productSVC svc;
	
	@Autowired
	k_memberSVC memSvc;
	
	@Autowired
	HttpSession session;
	
	@GetMapping("/list/{pDiv}") 
	public String divideList(@PathVariable("pDiv") String pDiv, HttpSession session) {
		session.setAttribute("productDivision", pDiv);
		return "redirect:/kbdprod/list/page/1";
		//return "redirect:/kbdprod/list/page?page=1&size=2";
	}
	
	@GetMapping("/list/page/{pgNum}")
	public String showProductListPage(@PathVariable("pgNum") int pgNum, Model m) {
		PageInfo<k_productVO> pgInfo = svc.getProductListPage(pgNum, 2);
		m.addAttribute("pageInfoProd", pgInfo);
		return "kbd_product_list";
	}
	/*
	@GetMapping("/list/page") // "user/list/page?page=1&size=2" => url이 이렇게 구성되어있어야함
	public String getProductListPage(Pageable pageable){
		return svc.getProductListPage(pageable).toString();
	}*/
	
	@GetMapping("/detail/{pId}") 
	public String goDetailPage(@PathVariable("pId") String pId, Model m) {
		m.addAttribute("product_detail", svc.getProduct(pId));
		m.addAttribute("product_img_list", svc.getImg(pId));
		return "kbd_product_detail";
	}
	
	@PostMapping("/tocart")
	@ResponseBody
	public String toCart(k_productVO prod, Model m) {
		return String.format("{\"incart\":%b}", svc.toCart(prod));
	}
	
	@GetMapping("/showcart")
	@ResponseBody
	public String showcart(Model m) {
		if(memSvc.isLogin()) {
			if(session.getAttribute("cart")!=null) {
				m.addAttribute("cart_list", svc.showCart());
				m.addAttribute("cart_sumPrice", svc.totalPrice());
				m.addAttribute("user_coupon", svc.getUserCoupon((String)session.getAttribute("id")));
				return String.format("{\"cart_confirm\":%b}", true);
			}
			return String.format("{\"cart_confirm\":%b}", false);	
		}
		return String.format("{\"cart_login\":%b}", false);
	}
	
	@GetMapping("/gocart")
	public String goCart(Model m) {
		m.addAttribute("cart_list", svc.showCart());
		m.addAttribute("cart_sumPrice", svc.totalPrice());
		m.addAttribute("user_coupon", svc.getUserCoupon((String)session.getAttribute("id")));
		return "kbd_product_cart";
	}
	
	@PostMapping("/editcart")
	@ResponseBody
	public Map<String, Object> editcart(k_productVO prod) {
		boolean ok = svc.editcart(prod);
		Map<String, Object> map = new HashMap<>();
		int total = 0;
		if(ok) total = svc.totalPrice();
		String sTotal = NumberFormat.getInstance().format(total);
		map.put("edited", ok);
		map.put("edited_cart_sumPrice", sTotal);
		return map;
	}
	
	@GetMapping("/islogin")
	@ResponseBody
	public String islogin() {
		return String.format("{\"login\":%b}", memSvc.isLogin());
	}
	
	@GetMapping("/del/{pNum}")
	public String delete(@PathVariable("pNum") int pNum) {
		svc.delCart(pNum);
		return "redirect:/kbdprod/showcart";		
	}

	@GetMapping("/delcart")
	public String delCart() {
		svc.delAllCart();
		return "redirect:/kbdprod/showcart";
	}
	
	@GetMapping("/applycoupon")
	@ResponseBody
	public Map<String, Object> applycoupon(Model m) {
		Map<String, Object> map = new HashMap<>();
		int coupon = svc.getUserCoupon((String)session.getAttribute("id"));
		if(coupon>0) {
			int appliedPrice = svc.applyCoupon();
			if(appliedPrice==svc.totalPrice()) {
				String sTotal = NumberFormat.getInstance().format(appliedPrice);
				map.put("applied", true);
				map.put("apply_coupon_sumPrice", sTotal);
				return map;
			}
		}
		map.put("applied", false);
		return map;
	}
	
	@GetMapping("/cancelcoupon")
	@ResponseBody
	public Map<String, Object> cancelcoupon(Model m) {
		Map<String, Object> map = new HashMap<>();
		int canceledPrice = svc.cancelcoupon();
		if(canceledPrice==svc.totalPrice()) {
			String sTotal = NumberFormat.getInstance().format(canceledPrice);
			map.put("canceled", true);
			map.put("cancel_coupon_sumPrice", sTotal);
			return map;
		}
		map.put("canceled", false);
		return map;
	}
	
	@GetMapping("/order")
	@ResponseBody
	public String order() {	
		return String.format("{\"paid\":%b}", svc.order());
	} // 저장하고 회원정보에서 쿠폰 -1 해야함 //list 에서 쿠폰 +1 수량변경시 다시 원래값으로 변경
		
	// 결제시 품목 갯수에 따라 (list.size()) 쿠폰 수 발행 -> 강사님께 물어봄
	// onpresskey -> 물어봄
	// 카트항목에서 쿠폰 갯수 불러와 적용, 오직 한개만 사용가능
}
