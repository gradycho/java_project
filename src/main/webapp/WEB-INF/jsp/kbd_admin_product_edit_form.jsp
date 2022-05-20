<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>제품 정보 수정 페이지</title>
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function formUpdate(){
		var pId = $('#pId').val();
		var pDiv = $('#pDiv').val();
		var pName = $('#pName').val();
		var pDate = $('#pDate').val();
		var price = $('#price').val();
		var img1 = $('#img1').val();
		var files = $('files').val();
		if(pId=='' || pDiv=='' || pName=='' || pDate=='' || price=='' || img1=='' || files==''){
			alert('필수 항목들을 모두 기입해주세요');
			return false;
		}
		
		var form = $('#formData')[0];
		var formData = new FormData(form);
		
		$.ajax({
			url:'/kbdmain/update',
			method:'post',
			cache:false,
			enctype:'multipart/form-data',
			data:formData,
			dataType:'json',
			processData:false,
			contentType:false,
			success:function(res){
				if(res.updated){
					alert('성공적으로 업데이트 되었습니다');
					location.href='/kbdmain/admin';
				}else{
					alert('업데이트 실패');
				}
			},
			error:function(xhr, status, err){
				alert('에러: '+err);
			}
		});
		return false;
	}
</script>
</head>
<body>
<h3>제품 정보 수정</h3>
<c:set var="product" value="${admin_product_detail}"/>

<form id="formData" onsubmit="return formUpdate()">
<table>
	<tr><td>상품 ID</td><td> <input type="text" id="pId" name="pId" value="${product.pId}" readonly></td></tr>
	<tr><td>상품구분</td><td> <input type="text" id="pDiv" name="pDiv" value="${product.pDiv}" readonly></td></tr>
	<tr><td>상품명</td><td> <input type="text" id="pName" name="pName" value="${product.pName}"></td></tr>
	<tr><td>모델명</td><td> <input type="text" id="modelNo" name="modelNo" value="${product.modelNo}"></td></tr>
	<tr><td>제조사</td><td> <input type="text" id="pCompany" name="pCompany" value="${product.pCompany}"></td></tr>
	<tr><td>입고일</td><td> <input type="text" id="pDate" name="pDate" value="${product.pDate}"></td></tr>
	<tr><td>가 격</td><td> <input type="text" id="price" name="price" value="${product.price}"></td></tr>
	<tr><td>재 고</td><td> <input type="text" id="stock" name="stock" value="${product.stock}"></td></tr>

	<tr><td>파일 업로드 </td><td><input type="file" id='files' name="files" multiple="multiple"></td></tr>
	<tr><td colspan="2" align="center"><button type="submit">수정</button><button type="reset">취소</button></td></tr>
</table>
</form>
</body>
</html>