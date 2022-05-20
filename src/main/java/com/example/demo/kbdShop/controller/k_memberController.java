package com.example.demo.kbdShop.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.example.demo.kbdShop.svc.k_memberSVC;
import com.example.demo.kbdShop.svc.k_productSVC;
import com.example.demo.kbdShop.vo.k_memberVO;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/kbdmem")
@SessionAttributes("id")
public class k_memberController {
	
	@Autowired
	private k_memberSVC svc;
	
	@Autowired
	k_productSVC prodSvc;
	
	@GetMapping("")
	@ResponseBody
	public String index() {
		return "Kbd Shop memberController index page";
	}
	
	@GetMapping("/login")
	public String move() {
		return "kbd_login_form";
	}
	
	@PostMapping("/login")
	@ResponseBody
	public String conf(k_memberVO mem, Model m) { 
		k_memberVO vo = svc.login(mem);
		if(vo!=null) { 
			m.addAttribute("id", vo.getId());
			m.addAttribute("memNum", vo.getMemNum());
			return String.format("{\"login\":%b}", true);
		}
		return String.format("{\"login\":%b}", false);	
	}
	
	@GetMapping("/logout")
	@ResponseBody
	public String logout(SessionStatus status) {
		status.setComplete(); // 세션에 저장된 모든 데이터를 삭제함
		boolean ok = status.isComplete();
		return String.format("{\"logout\":%b}", ok);
	}
	
	@GetMapping("/add")
	public String goAddForm() {
		return "kbd_sign_up_form";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public String insertUser(k_memberVO mem) {
		return String.format("{\"sign\":%b}", svc.insert(mem));
	}
	
	@PostMapping("/add/idCheck")
	@ResponseBody
	public String idOverlapCheck(String idCheck) {
		if(svc.idOverlapCheck(idCheck)==null) {
			return String.format("{\"idChecked\":%b}", true);
		}else {
			return String.format("{\"idChecked\":%b}", false);
		}	
	}
	
	@GetMapping("/user/detail")
	public String getUser(Model m) {
		if(svc.isLogin()) {
			m.addAttribute("user_detail", svc.getUserById((String)m.getAttribute("id")));
			m.addAttribute("user_orderList", prodSvc.getUserOrderList((String)m.getAttribute("id")));
			return "kbd_mem_edit_form";
		}else {
			return "redirect:/kbdmem/login";
		}
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateUser(k_memberVO mem) {
		return String.format("{\"sign\":%b}",svc.update(mem));
	}
	
	@GetMapping("/delete/{num}")
	public boolean deleteUser( @PathVariable("num") int num) {
		return svc.delete(num);
	}
	
	@GetMapping("/findWithoutId")
	public String findWithoutId(k_memberVO mem, Model m) {
		mem.setName("daniel");
		m.addAttribute("find_wo_detail", svc.findWithoutId(mem));
		return "";
	}

	@GetMapping("/list/page/{pgNum}")
	public String getListByPage(@PathVariable("pgNum")int pg, Model model) {
		PageInfo<k_memberVO> pgInfo = svc.getUserListPage(pg, 3);
		model.addAttribute("pageInfo", pgInfo);
		return "user_list_page";
	}
	
	@GetMapping("/add/getKey")
	public int insertAndGetKey(k_memberVO mem) {
		int rows = svc.addAndGetKey(mem);
		if(rows>0) {
			return mem.getMemNum();
		}
		return 0;
	}

	@GetMapping("/user/list")
	public String getUserList(Model m) {
		m.addAttribute("user_list",svc.getUserList());
		return "";
	}
}
