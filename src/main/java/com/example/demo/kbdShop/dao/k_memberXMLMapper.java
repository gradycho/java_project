package com.example.demo.kbdShop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.demo.kbdShop.vo.k_memberVO;

@Mapper
public interface k_memberXMLMapper {
	int insertUser(k_memberVO mem);
	int addAndGetKey(k_memberVO mem);
	k_memberVO getUserById(String id);
	List<k_memberVO> getUserList();
	int updateUser(k_memberVO mem);
	int deleteUser(int num);
	k_memberVO findWithoutId(k_memberVO mem);
	k_memberVO login(k_memberVO mem);
	k_memberVO idCheck(String id);
	int updateUserCoupon(k_memberVO vo);
	int getUserCouponById(String id);
}
