package com.example.demo.kbdShop.dao;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.data.web.SpringDataWebProperties.Pageable;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.kbdShop.vo.k_pictureVO;
import com.example.demo.kbdShop.vo.k_productVO;

@Repository
public class k_productDAO {
	
	@Autowired
	private k_productXMLMapper mapper;

	public boolean uploadProduct(k_productVO prod) {
		return mapper.uploadProduct(prod)>0;
	}
	
	public boolean uploadFile(k_productVO prod, MultipartFile[] mfiles) {
		List<k_pictureVO> picList = new ArrayList<>();
		
		String saveFolder = "/opt/tomcat9/webapps/ROOT/WEB-INF/classes/static/upload";
		//String saveFolder = "C:/ESWork/ESJava/springDemo2/src/main/resources/static/upload";
		try {
			for(int i=0;i<mfiles.length;i++) {
				String fileName = mfiles[i].getOriginalFilename();
				String savedFile = saveFolder+"/"+fileName;
				File file = new File(savedFile);
				mfiles[i].transferTo(file); 
				k_pictureVO vo = new k_pictureVO();
				
				if(file.exists()) {
					vo.setpId(prod.getpId());
					vo.setImgName(fileName);
					vo.setImgPath(savedFile);
					picList.add(vo);
					if(i==0) {
						prod.setRepImgName(fileName);
						prod.setRepImgPath(savedFile);
					}
				}
			}
			return insertList(picList) && uploadRepPicture(prod);
			
		} catch (Exception e) {
			e.printStackTrace();
	    }
		return false;
	}
	
	public boolean insertList(List<k_pictureVO> picList) {
		int imgCount = 0;
		for(int i=0; i<picList.size();i++) {
			k_pictureVO pic = picList.get(i);
			pic.setImgIndex(i);
			imgCount += mapper.uploadPicture(pic);
		}
		if(imgCount==picList.size()) {
			return true;
		}
		return false;
	}
	
	public boolean uploadRepPicture(k_productVO prod) {
		return mapper.uploadRepPicture(prod)>0;
	}
	
	public List<k_productVO> getList(String pDiv) {
		return mapper.getList(pDiv);
	}
	
	public k_productVO getProduct(String pId) {
		return mapper.getProduct(pId);
	}

	public List<k_pictureVO> getImg(String pId) {
		return mapper.getImg(pId);
	}

	public String getRepImg(String pId) {
		return mapper.getRepImg(pId);
	}

	public int saveOrder(k_productVO prod) {
		return mapper.saveOrder(prod);
	}

	public List<k_productVO> getListAll() {
		return mapper.getListAll();
	}

	public boolean updateProduct(k_productVO prod) {
		return mapper.updateProduct(prod)>0;
	}
	
	public boolean updateFile(k_productVO prod, MultipartFile[] mfiles) {
		List<k_pictureVO> picList = new ArrayList<>();
		String saveFolder = "/opt/tomcat9/webapps/ROOT/WEB-INF/classes/static/upload";
		//String saveFolder = "C:/ESWork/ESJava/springDemo2/src/main/resources/static/upload";
		try {
			for(int i=0;i<mfiles.length;i++) {
				String fileName = mfiles[i].getOriginalFilename();
				String savedFile = saveFolder+"/"+fileName;
				File file = new File(savedFile);
				mfiles[i].transferTo(file); 
				k_pictureVO vo = new k_pictureVO();
				
				if(file.exists()) {
					vo.setpId(prod.getpId());
					vo.setImgName(fileName);
					vo.setImgPath(savedFile);
					picList.add(vo);
					if(i==0) {
						prod.setRepImgName(fileName);
						prod.setRepImgPath(savedFile);
					}
				}
			}
			boolean ok1 = updateList(picList);
			boolean ok2 =updateRepPicture(prod);
			System.out.println(ok1 +" "+ok2);
			return  ok1&&ok2 ;
			
		} catch (Exception e) {
			e.printStackTrace();
	    }
		return false;	
	}

	private boolean updateList(List<k_pictureVO> picList) {
		int imgCount = 0;
		for(int i=0; i<picList.size();i++) {
			k_pictureVO pic = picList.get(i);
			pic.setImgIndex(i);
			imgCount += mapper.updateFile(pic);
		}
		if(imgCount==picList.size()) {
			return true;
		}
		return false;
	}
	
	public boolean updateRepPicture(k_productVO prod) {
		return mapper.updateRepImg(prod)>0;
	}

	public List<k_productVO> getUserOrderList(String id) {
		return mapper.getUserOrderList(id);
	}

	public List<k_productVO> getProductListPage(Pageable pageable, String pDiv) {
		return mapper.getProductListPage(pageable, pDiv);
	}

}
