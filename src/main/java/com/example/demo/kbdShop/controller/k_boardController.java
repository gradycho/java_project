package com.example.demo.kbdShop.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.kbdShop.svc.k_boardSVC;
import com.example.demo.kbdShop.svc.k_memberSVC;
import com.example.demo.kbdShop.vo.k_boardVO;
import com.github.pagehelper.PageInfo;

@Controller
@RequestMapping("/kbdboard")
public class k_boardController {
	// k_board: list, read, input/write, edit/update, delete
	
	@Autowired
	k_boardSVC svc;
	
	@Autowired
	k_memberSVC memSvc;
	
	@GetMapping("/list/{num}") 
	public String showBoardList(@PathVariable("num") int deptNum, HttpSession session) {
		session.setAttribute("deptNumber", deptNum);
		return "redirect:/kbdboard/list/page/1";
	}
		
	@GetMapping("/list/page/{pgNum}")
	public String showProductListPage(@PathVariable("pgNum") int pgNum, Model m) {
		PageInfo<k_boardVO> pgInfo = svc.getBoardListPage(pgNum, 5);
		m.addAttribute("pageInfoBoard", pgInfo);
		return "kbd_board_list";
	}
	
	@GetMapping("/add/{num}")
	public String add(@PathVariable("num") int deptNum) {
		if(memSvc.isLogin()) { 
			return "kbd_board_write";
		}
		return "redirect:/kbdmem/login";
	}
	
	@PostMapping("/add")
	@ResponseBody
	public String saveBoard(k_boardVO board) {
		return String.format("{\"saved\":%b}", svc.saveBoard(board));
	}
	
	@GetMapping("/read/{num}")
	public String readContent(@PathVariable("num") int boardNum, Model m) {
		if(memSvc.isLogin()) {
			m.addAttribute("read_content", svc.readContent(boardNum));
			return "kbd_board_detail";
		}
		return "redirect:/kbdmem/login";
	}
	
	@GetMapping("/edit/{num}")
	public String getContent(@PathVariable("num") int boardNum, Model m) {
		if(memSvc.isLogin()) {
			m.addAttribute("edit_content", svc.readContent(boardNum));
			return "kbd_board_edit";
		}
		return "redirect:/kbdmem/login";
	}
	
	@PostMapping("/update")
	@ResponseBody
	public String updateContent(k_boardVO board) {
		return String.format("{\"updated\":%b}", svc.updateContent(board));	
	}
	
	@GetMapping("/del/{num}")
	@ResponseBody
	public String deleteContent(@PathVariable("num") int boardNum) {
		return String.format("{\"deleted\":%b}", svc.deleteContent(boardNum));
	}

	
}
