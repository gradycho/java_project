package com.example.demo.kbdShop.svc;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.kbdShop.dao.k_memberDAO;
import com.example.demo.kbdShop.dao.k_productDAO;
import com.example.demo.kbdShop.vo.k_pictureVO;
import com.example.demo.kbdShop.vo.k_productVO;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.example.demo.kbdShop.util.Cart;

@Service
public class k_productSVC {
	
	@Autowired
	k_productDAO dao;
	
	@Autowired
	k_memberDAO memDao;
	
	@Autowired
	private HttpSession session;

	public boolean uploadProduct(k_productVO prod) {
		return dao.uploadProduct(prod);
	}

	public boolean uploadFile(k_productVO prod, MultipartFile[] mfiles) {
		return dao.uploadFile(prod, mfiles);
	}
	
	public List<k_productVO> getList(String pDiv) {
		return dao.getList(pDiv);
	}
	
	public k_productVO getProduct(String pId) {
		return dao.getProduct(pId);
	}

	public List<k_pictureVO> getImg(String pId) {
		return dao.getImg(pId);
	}

	public boolean toCart(k_productVO prod) {
		if(session.getAttribute("cart") == null) {
			session.setAttribute("cart", new Cart());
		}
		Cart cart  = (Cart) session.getAttribute("cart");
		String id = (String) session.getAttribute("id");
		prod.setRepImgName(getRepImg(prod.getpId())); 
		prod.setId(id);
		return cart.add(prod);
	}
	
	public String getRepImg(String pId) {
		return dao.getRepImg(pId);
	}
	
	public List<k_productVO> showCart() {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.refreshSumPrice();
		return cart.getList();
	}

	public boolean editcart(k_productVO prod) {
		Cart cart = (Cart) session.getAttribute("cart");
		return cart.editCart(prod);
	}

	public void delCart(int pNum) {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.delcart(pNum);
	}

	public void delAllCart() {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.delAllCart();
	}	

	public int totalPrice() {
		Cart cart = (Cart) session.getAttribute("cart");
		return cart.totalPrice();
	}

	public PageInfo<k_productVO> getProductListPage(int pgNum, int pageSize) {
		PageHelper.startPage(pgNum, pageSize);
		String pDiv = (String)session.getAttribute("productDivision");
		PageInfo<k_productVO> pageInfo = new PageInfo<>(dao.getList(pDiv));
		return pageInfo;
	}
	/*
	public List<k_productVO> getProductListPage(Pageable pageable) {
		String pDiv = (String)session.getAttribute("productDivision");
		return dao.getProductListPage(pageable, pDiv);
	}*/


	public int getUserCoupon(String id) {
		return memDao.getUserCoupon(id);
	}

	public int applyCoupon() {
		Cart cart = (Cart) session.getAttribute("cart");
		return cart.applycoupon();
	}
	
	public int cancelcoupon() {
		Cart cart = (Cart) session.getAttribute("cart");
		cart.refreshSumPrice();
		return cart.totalPrice();
	}
	
	public boolean order() {
		Cart cart = (Cart) session.getAttribute("cart");
		List<k_productVO> list = cart.getList();
		boolean updateUserInfo = false;
		if(cart.checkCoupon()) {
			updateUserInfo = updateCoupon();
		}else {
			updateUserInfo = true;
		}
		
		if(updateUserInfo) {
			int orderCount = insertOrder(list);
			if(orderCount==list.size()) {
				int addcoupon = countRental(list);
				if(addcoupon>0) {
					memDao.addCoupon(addcoupon, (String)session.getAttribute("id"));
				}
				delAllCart();
				return true;
			}
		}
		return false;
	}
	
	private boolean updateCoupon() {
		return memDao.subUserCoupon((String)session.getAttribute("id"));
	}

	public int insertOrder(List<k_productVO> prodList) {
		int orderCount = 0;
		for(int i=0; i<prodList.size();i++) {
			k_productVO vo = prodList.get(i);
			orderCount += dao.saveOrder(prodList.get(i));
		}
		return orderCount;
	}
	
	public int countRental(List<k_productVO> prodList) {
		int coupon = 0;
		for(int i=0; i<prodList.size();i++) {
			if(prodList.get(i).getpDiv().equals("r")) {
				coupon += 1;
			}
		}
		return coupon;
	}
	
	public List<k_productVO> getListAll() {
		return dao.getListAll();
	}

	public boolean updateProduct(k_productVO prod, MultipartFile[] mfiles) {
		return dao.updateProduct(prod) && dao.updateFile(prod, mfiles);
	}

	public List<k_productVO> getUserOrderList(String id) {
		return dao.getUserOrderList(id);
	}

	public boolean isCart() {
		return session.getAttribute("cart")!=null;
	}

	
}
