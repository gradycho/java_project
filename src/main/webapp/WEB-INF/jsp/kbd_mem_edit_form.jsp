<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="header.jsp" %>
<% 
   response.setHeader("Cache-Control","no-store"); 
   response.setHeader("Pragma","no-cache"); 
   response.setDateHeader("Expires",0); 
   if (request.getProtocol().equals("HTTP/1.1"))
        response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>회원 정보 수정 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	var isPwdChecked = false;

	function formCheck(){
		var id = $('#id').val();
		var pwd = $('#pwd').val();
		var pwdCheck = $('#pwdCheck').val();
		var name = $('#name').val();
		var phone = $('#phone').val();
		var email = $('#email').val();
		var address = $('#address').val();
		
		if(id==''||pwd==''||pwdCheck==''||name==''||phone==''||email==''){
			alert('주소를 제외한 모든항목을 기입해주세요');
			return false;
		}
		
		if(isPwdChecked==false){
			alert('비밀번호체크를 확인해주세요');
			return false;
		}
		
		var serData = $('#formData').serialize();
		$.ajax({
			url:'/kbdmem/update',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				if(res.sign){
					alert('회원 정보가 수정되었습니다');
					location.href="/kbdmem/login";
				}else{
					alert('회원정보 수정 양식을 확인후 다시 작성해주세요');
				}
			},
			error:function(xhr, status, err){
				alert('에러: '+err);
			}
		});
		return false;
	}

	function pwdCheck1(){
		if($('#pwd').val()==$('#pwdCheck').val()){
			isPwdChecked = true;
			$('#afterPwd').text('확인');
		}else{
			alert('비밀번호가 같지 않습니다');
			return;
		}
	}
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

	<section class="py-2">
		<div class="container px-4 px-lg-5 mt-5">
			<h4 class="text-center">회원 정보 수정</h4>	
				<form id="formData" onsubmit="return formCheck()">
					<div class="form-group">
						<input type="hidden" id="memNum" name="memNum" value="${user_detail.memNum}">
					</div>
					<div class="form-group">
						<label for="id">ID (*)</label>
						<input type="text" class="form-control"id="id" name="id" value="${user_detail.id}" readonly>
					</div>
					<div class="form-group">
						<label for="pwd">PW (*)</label>
						<input type="password" class="form-control"id="pwd" name="pwd" value="${user_detail.pwd}">
					</div>
					<div class="form-group">
						<label for="pwdCheck">PW 확인 (*)</label>
						<input type="password" class="form-control"id="pwdCheck" name="pwdCheck" >
						<button type="button" class="btn btn-primary mb-2" onclick="pwdCheck1()">비밀번호체크</button>&nbsp;&nbsp;<span id="afterPwd">&nbsp;</span>
					</div>
					<div class="form-group">
						<label for="name">이름 (*)</label>
						<input type="text" class="form-control" id="name" name="name" value="${user_detail.name}">
					</div>
					<div class="form-group">
						<label for="phone">전화 (*)</label>
						<input type="text" class="form-control" id="phone" name="phone" value="${user_detail.phone}">
					</div>
					<div class="form-group">
						<label for="email">메일 (*)</label>
						<input type="text" class="form-control" id="email" name="email" value="${user_detail.email}">
					</div>
					<div class="form-group">
						<label for="email">주소</label>
						<input type="text" class="form-control" id="address" name="address" value="${user_detail.address}">
					</div>
					<div class="form-group">
						<label for="coupon">쿠폰</label>
						<input type="text" class="form-control" id="coupon" name="coupon" value="${user_detail.coupon}" readonly>
					</div>
					<div class="text-left">
						(*) 는 필수항목 입니다
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">수정</button>&nbsp;<button type="reset" class="btn btn-primary">취소</button>
					</div>
				</form>
					
				<br>
				<h4 class="text-left">${user_detail.id} 님의 구매 내역</h4>
				<table class="table table-bordered">
					<thead>
						<tr align="center"><th scope="col">번호</th><th scope="col">구매일</th><th scope="col">상품명</th><th scope="col">상품 ID</th><th scope="col">모델명</th><th scope="col">회사명</th><th scope="col">제품 가격</th><th scope="col">구매갯수</th><th scope="col">총가격</th><th scope="col">쿠폰사용갯수</th></tr>
					</thead>
						<c:forEach var="user_order" items="${user_orderList}" varStatus="status">
							<tbody>
								<tr align="center"><th scope="row">${status.index+1}</th><td>${user_order.orderDate}</td><td>${user_order.pName}</td><td>${user_order.pId}</td>
									<td>${user_order.modelNo}</td><td>${user_order.pCompany}</td><td>${user_order.price}</td><td>${user_order.qty}</td>
									<td>${user_order.sumPrice}</td><td>${user_order.useCoupon}</td>
								</tr>
							</tbody>
						</c:forEach>
				</table>			
		</div>
	</section>
</body>
</html>