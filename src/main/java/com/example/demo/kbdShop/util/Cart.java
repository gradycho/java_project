package com.example.demo.kbdShop.util;

import java.util.ArrayList;
import java.util.List;

import com.example.demo.kbdShop.vo.k_productVO;

public class Cart {
		
	private List<k_productVO> list = new ArrayList<>();

	public boolean add(k_productVO prod) {
		if(list!=null) {
			for(int i=0; i<list.size();i++) {
				k_productVO vo = list.get(i);
				if(prod.getpNum() == vo.getpNum()) {
					vo.setQty(vo.getQty()+prod.getQty());
					vo.setSumPrice(vo.getPrice()*vo.getQty());
					return true;
				}
			}
		}
		list.add(prod);
		return true;
	}
	
	public int totalPrice() {
		int total = 0;
		for(int i=0; i<list.size();i++) {
			k_productVO prod = list.get(i);
			total += prod.getSumPrice();
		}
		return total;
	}

	public List<k_productVO> getList() {
		return list;
	}

	public void refreshSumPrice() {
		for(int i=0; i<list.size();i++) {
			k_productVO vo = list.get(i);
			vo.setSumPrice(vo.getPrice()*vo.getQty());
		}
	}

	public boolean editCart(k_productVO prod) {
		for(int i=0; i<list.size();i++) {
			k_productVO vo = list.get(i);
			if(prod.getpNum()==vo.getpNum()) {
				vo.setQty(prod.getQty());
				vo.setSumPrice(vo.getPrice()*vo.getQty());
				vo.setUseCoupon(0);
				return true;
			}
		}
		return false;
	}

	public boolean delcart(int pNum) {
		for(int i=0; i<list.size();i++) {
			k_productVO vo = list.get(i);
			if(pNum==vo.getpNum()) {
				list.remove(i);
				return true;
			}	
		}
		return false;
	}

	public void delAllCart() {
		list.clear();
	}

	public int applycoupon() {
		int total = 0;
		for(int i=0; i<list.size();i++) {
			k_productVO prod = list.get(i);
			int applyPrice = (int) (prod.getSumPrice() * 0.9);
			prod.setSumPrice(applyPrice);
			prod.setUseCoupon(1);
			total += applyPrice;
		}
		return total;
	}

	public boolean checkCoupon() {
		for(int i=0; i<list.size();i++) {
			k_productVO prod = list.get(i);
			if(prod.getUseCoupon()>0) {
				return true;
			}
		}
		return false;
	}

	

}