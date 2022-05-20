package com.example.demo.kbdShop.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;

import com.example.demo.kbdShop.vo.k_pictureVO;
import com.example.demo.kbdShop.vo.k_productVO;

@Mapper
public interface k_productXMLMapper {

	int uploadProduct(k_productVO prod);
	int uploadRepPicture(k_productVO prod);
	int uploadPicture(k_pictureVO pic);
	
	List<k_productVO> getList(String pDiv);
	k_productVO getProduct(String pId);
	List<k_pictureVO> getImg(String pId);
	String getRepImg(String pId);
	int saveOrder(k_productVO prod);
	
	List<k_productVO> getListAll();
	int updateProduct(k_productVO prod);
	int updateRepImg(k_productVO prod);
	int updateFile(k_pictureVO pic);
	List<k_productVO> getUserOrderList(String id);
	List<k_productVO> getProductListPage(Pageable pageable, String pDiv);
	
}
