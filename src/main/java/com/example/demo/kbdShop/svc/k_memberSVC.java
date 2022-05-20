package com.example.demo.kbdShop.svc;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.kbdShop.dao.k_memberDAO;
import com.example.demo.kbdShop.vo.k_memberVO;
import com.github.pagehelper.PageInfo;

@Service
public class k_memberSVC {
	private HttpSession session;
	
	@Autowired
	private k_memberDAO dao;
	
	@Autowired 
	public k_memberSVC(HttpSession session) {
		this.session  = session;
	}
	
	public k_memberVO login(k_memberVO mem) {
		return dao.login(mem);
	}

	public boolean insert(k_memberVO mem) {
		return dao.insert(mem)>0;
	}

	public int addAndGetKey(k_memberVO mem) {
		return dao.addAndGetKey(mem);
	}

	public k_memberVO getUserById(String id) {
		return dao.getUserById(id);
	}

	public List<k_memberVO> getUserList() {
		return dao.getUserList();
	}

	public boolean update(k_memberVO mem) {
		return dao.update(mem)>0;
	}

	public boolean delete(int num) {
		return  dao.delete(num)>0;
	}

	public k_memberVO findWithoutId(k_memberVO mem) {
		return dao.findWithoutId(mem);
	}

	public PageInfo<k_memberVO> getUserListPage(int pg, int i) {
		return dao.getUserListPage(pg, 3);
	}
	
	public boolean isLogin() {
		return (session.getAttribute("id")!=null);
	}
	
	public boolean isAdminLogin() {
		return (session.getAttribute("id").equals("admin"));
	}

	public k_memberVO idOverlapCheck(String idCheck) {
		return dao.idOverlapCheck(idCheck);
	}
	/*
	public boolean subUserCoupon() {
		return dao.updateUserCoupon(session.getAttribute("id"));
	}*/

	
}
