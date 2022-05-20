package com.example.demo.kbdShop.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.demo.kbdShop.vo.k_memberVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Repository
public class k_memberDAO {
	
	@Autowired
	private k_memberXMLMapper memMapper;
	
	public int insert(k_memberVO mem) {
		return memMapper.insertUser(mem);
	}
	
    public int addAndGetKey(k_memberVO mem) {
        return memMapper.addAndGetKey(mem);
    }
	public k_memberVO getUserById(String id) {
		return memMapper.getUserById(id);
    }
	
	public List<k_memberVO> getUserList() {
		return memMapper.getUserList();
    }

	public int update(k_memberVO mem) {
		return memMapper.updateUser(mem);
	}
	
	public int delete(int num) {
		return memMapper.deleteUser(num);
	}
	
	public k_memberVO findWithoutId(k_memberVO mem) {
		return memMapper.findWithoutId(mem);
	}
	
	public PageInfo<k_memberVO> getUserListPage(int pageNum, int pageSize){
		PageHelper.startPage(pageNum, pageSize);	
		PageInfo<k_memberVO> pageInfo = new PageInfo<>(memMapper.getUserList());
		return pageInfo;
	}
	
	public k_memberVO login(k_memberVO mem) {
		return memMapper.login(mem);
	}

	public k_memberVO idOverlapCheck(String idCheck) {
		return memMapper.idCheck(idCheck);
	}

	public boolean addCoupon(int countRental, String id) {
		k_memberVO vo = new k_memberVO();
		vo.setId(id);
		int cnt = getUserCoupon(id);
		vo.setCoupon(countRental+cnt);
		return memMapper.updateUserCoupon(vo)>0;
	}
	
	public int getUserCoupon(String id) {
		return memMapper.getUserCouponById(id);
	}

	public boolean subUserCoupon(String id) {
		k_memberVO vo = new k_memberVO();
		vo.setId(id);
		int cnt = getUserCoupon(id);
		vo.setCoupon(cnt-1);
		return memMapper.updateUserCoupon(vo)>0;
	}
	

}
