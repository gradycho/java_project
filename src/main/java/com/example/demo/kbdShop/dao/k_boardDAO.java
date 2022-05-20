package com.example.demo.kbdShop.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.kbdShop.vo.k_boardVO;

@Repository
public class k_boardDAO {
	@Autowired
	private k_boardXMLMapper boardMapper;

	public List<k_boardVO> getList(int deptNum) {
		return boardMapper.getList(deptNum);
	}

	public boolean saveBoard(k_boardVO board) {
		return boardMapper.saveBoard(board)>0;
	}
	
	public k_boardVO readContent(int boardNum) {	
		return boardMapper.getContent(boardNum);
	}

	public boolean updateContent(k_boardVO board) {
		return boardMapper.updateContent(board)>0;
	}

	public boolean deleteContent(int boardNum) {
		return boardMapper.deleteContent(boardNum)>0;
	}
	
}
