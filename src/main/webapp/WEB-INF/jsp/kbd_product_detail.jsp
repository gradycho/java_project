<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<!-- <style>
	img#i1 {float: left; margin-right: .5em;  width: 400px;  height: 250px;  object-fit: cover;}

</style> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900" rel="stylesheet">
<link href="/css/blog.css" rel="stylesheet">
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>	
	function plus(){
		let qtyPlus = $('#qty').val();
		qtyPlus = parseInt(qtyPlus)+1;
		$('#qty').val(qtyPlus);
		$('#sumPrice').val(qtyPlus*$('#price').val());
	}
	
	function minus(){
		if($('#qty').val() > 1){
			let qtyMinus = $('#qty').val()
			qtyMinus = parseInt(qtyMinus)-1;
			$('#qty').val(qtyMinus);
			$('#sumPrice').val(qtyMinus*$('#price').val());
		}
	}
	<%--
	function inputQtyBox_onkeypress() {
	    if (event == null) {
	        return false;
	    }
	    var keyCode = event.keyCode || event.which;
	    if (keyCode == 13) {
	    	calculation();
	    }
	}
	
	function calculation(){
		let qty = if($('#qty').val();
		if(qty > 1){
			$('#sumPrice').val(qty*$('#price').val());
		}
	}--%>
	
	function toCart(){
		var serData = $('#formData').serialize();
		$.ajax({
			url:'/kbdprod/islogin',
			method:'get',
			dataType:'json',
			success:function(res){
				if(res.login){
					$.ajax({
						url:'/kbdprod/tocart',
						method:'post',
						cache:false,
						data:serData,
						dataType:'json',
						success:function(res){
							if(res.incart){
								if(confirm('장바구니 페이지로 이동하시겠습니가?')){
									location.href='/kbdprod/gocart';
								}
							}else{
								alert('저장실패');
							}	
						},
						error:function(xhr, status, err){
							alert('에러: '+err);
						}
					});
				}else{
					alert('로그인 페이지로 이동합니다');
					location.href='/kbdmem/login';
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

<section class="py-2">
	<div class="container px-4 px-lg-5 mt-5">
		
		<c:if test="${productDivision=='r'}">
			<h4 class="text-center">Keyboard Rental</h4>
		</c:if>
		<c:if test="${productDivision=='k'}">
			<h4 class="text-center">Keyboard </h4>
		</c:if>
		<c:if test="${productDivision=='s'}">
			<h4 class="text-center">Switch</h4>
		</c:if>

		<c:set var="detail" value="${product_detail}"/>
		
		<div class="row gx-4 gx-lg-5 align-items-center">
			<c:forEach var="img" items="${product_img_list}">
				<c:if test="${img.imgIndex==0}">
					<div class="col-md-6"><img id="i1" src="/upload/${img.imgName}" class="img-fluid" alt="${detail.pName}"></div>
				</c:if>
			</c:forEach>
			<div class="col-md-6">
				<form id="formData" onsubmit="return toCart();">
						<input type="hidden" id="pNum" name="pNum" value="${detail.pNum}">
						<input type="hidden" id="pDiv" name="pDiv" value="${detail.pDiv}">
						<input type="hidden" id="pId" name="pId" value="${detail.pId}">	
						<input type="hidden" id="pCompany" name="pCompany" value="${detail.pCompany}">
						<div>상품명: ${detail.pName}<input type="hidden" id="pName" name="pName" value="${detail.pName}" ></div>
						<div >브랜드/품번: ${detail.pCompany}/${detail.pId}</div>
						<div >가격: <input type="text" id="price" name="price" value="${detail.price}" readonly></div>
						<div >수량: <input type="text" id="qty" name="qty" value="1" onkeypress="inputQtyBox_onkeypress()">
						<input type="button" value="+" onclick="plus();"><input type="button" value="-" onclick="minus();"></div>
						<div >금액: <input type="text" id="sumPrice" name="sumPrice" value="${detail.price}" readonly>원</div>
						<br>
						<div ><button type="submit">장바구니 담기</button></div>
				</form>
			</div>
		</div>
		<br><br><br>
		<c:forEach var="img" items="${product_img_list}">
			<div align="center"><img src="/upload/${img.imgName}"></div><br><br>
		</c:forEach>
	</div>
</section>

</body>
</html>