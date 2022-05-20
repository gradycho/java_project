package com.example.demo.kbdShop.svc;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.kbdShop.dao.k_boardDAO;
import com.example.demo.kbdShop.vo.k_boardVO;
import com.example.demo.kbdShop.vo.k_productVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class k_boardSVC {
	
	@Autowired
	k_boardDAO dao;
	@Autowired
	HttpSession session;

	public List<k_boardVO> getList(int deptNum) {
		return dao.getList(deptNum);
	}

	public boolean saveBoard(k_boardVO board) {
		return dao.saveBoard(board);
	}
	
	public k_boardVO readContent(int boardNum) {
		return dao.readContent(boardNum);
	}

	public boolean updateContent(k_boardVO board) {
		return dao.updateContent(board);
	}

	public boolean deleteContent(int boardNum) {	
		return dao.deleteContent(boardNum);
	}

	public PageInfo<k_boardVO> getBoardListPage(int pgNum, int pageSize) {
		PageHelper.startPage(pgNum, pageSize);
		int deptNum = (Integer) session.getAttribute("deptNumber");
		PageInfo<k_boardVO> pageInfo = new PageInfo<>(dao.getList(deptNum));
		return pageInfo;
	}
	

}
