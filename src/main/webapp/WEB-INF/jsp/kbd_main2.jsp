<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>키보드 렌탈샵 메인페이지</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<style type="text/css">
	body {
		text-align: center;
		width: 900px;
	}
	div#wapper {
		width: 100%;
		text-align: left;
		min-height: 300px;
		margin: 0 auto;
	}
	header {
		border: 1px solid #999;
		margin: 5px;
		padding: 10px;
	}
	header {
		height: 100px;
	}
	nav, section {
		float: left;
		height: 400px;
	}
	nav {
		text-align:left;
		width: 180px;
	}
	section {
		width: 656px; 
	}
	footer {
		height: 50px;
		background-color: blue;
		position: relatiev;
		clear: both;
	}
	li::marker{
		color: black;
	}
	img {
	height:150px; width:200px; object-fit: cover;
	}
	
	
</style>
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function logout(){
		$.ajax({
			url:'/kbdmem/logout',
			method:'get',
			dataType:'json',
			success:function(res){
				if(res.logout){
					alert('로그아웃 되었습니다');
					location.href='/kbdmain';
				}else{
					alert('로그아웃 실패');
					return;
				}
			},
			error(xhr, status, err){
				alert('에러: '+err);
			}
		});
	}
	function goCartPage(){
		$.ajax({
			url:'/kbdprod/showcart',
			dataType:'json',
			success:function(res){
				if(res.cart_confirm){
					location.href='/kbdprod/gocart';
				}else{
					alert('카트에 담긴 물품이 없습니다');
				}
				if(res.cart_login){
					alert('로그인 후에 사용해주세요')
					location.href='/kbdmem/login';
				}
			},
			error:function(xhr, status, err){
				alert('에러: '+err);
			}
		});
	}
	
</script>
</head>
<body>

<header>
	<h3>키보드 렌탈샵</h3>
	<c:if test="${id == null}">
		<div><a href="/kbdmem/login">[로그인]</a> <a href="/kbdmem/user/detail">[마이페이지]</a> <a href="/kbdmem/add">[회원가입]</a><a href="/kbdboard/list/1">[고객센터]</a></div>
	</c:if>
	<c:if test="${id != null}">
		<div>${id}님<button type="button" onclick="logout()">로그아웃</button><a href="/kbdmem/user/detail">[마이페이지]</a><a href="javascript:goCartPage()">[장바구니]</a><a href="/kbdboard/list/1">[고객센터]</a></div>
	</c:if>
</header>
	<nav>
		<ul>
			<li><a href="/kbdboard/list/2">[키보드 게시판]</a></li>
			<li><a href="/kbdboard/list/3">[스위치 게시판]</a></li>
			<li><a href="/kbdboard/list/4">[자유 게시판]</a></li>  
		</ul>
		<ul>
			<li><a href="/kbdprod/list/r">[Keyboard Rental]</a></li>
			<li><a href="/kbdprod/list/k">[Keyboard]</a></li>
			<li><a href="/kbdprod/list/s">[Switch]</a></li>
		</ul>
		<ul>
		<c:if test="${id == 'admin'}">
			<li><a href="/kbdmain/admin">[관리자 페이지]</a></li>
		</c:if>
		</ul>
	</nav>
	<section>
	
	
		<table>
			<tr><th>렌탈 키보드</th></tr>
			<tr>
				<c:forEach var="product" items="${r_main_product_list}">
					<td><a href="/kbdprod/detail/${product.pId}"><img src="/upload/${product.repImgName}" alt="${product.pName}" ></a><br>
					${product.pName}<br>
					${product.price}
					</td>
				</c:forEach>
			</tr>
		</table>
		<br>
		<table>
			<tr><th>키보드</th></tr>
			<tr>
				<c:forEach var="product" items="${k_main_product_list}">
					<td><a href="/kbdprod/detail/${product.pId}"><img src="/upload/${product.repImgName}" alt="${product.pName}"  ></a><br>
					${product.pName}<br>
					${product.price}
					</td>
				</c:forEach>
			</tr>
		</table>
		<br>
		<table>
			<tr><th>스위치</th></tr>
			<tr>
				<c:forEach var="product" items="${s_main_product_list}">
					<td><a href="/kbdprod/detail/${product.pId}"><img src="/upload/${product.repImgName}" alt="${product.pName}"  ></a><br>
					${product.pName}<br>
					${product.price}
					</td>
				</c:forEach>
			</tr>
		</table>
		
	</section>

</body>
</html>