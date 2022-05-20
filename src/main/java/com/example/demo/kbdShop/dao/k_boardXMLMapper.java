package com.example.demo.kbdShop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.kbdShop.vo.k_boardVO;

@Mapper
public interface k_boardXMLMapper {

	List<k_boardVO> getList(int deptNum);
	int saveBoard(k_boardVO board);
	k_boardVO getContent(int num);
	int updateContent(k_boardVO board);
	int deleteContent(int boardNum);

		
}
