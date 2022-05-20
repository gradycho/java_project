<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <style>
        .bd-placeholder-img {
            font-size: 1.125rem;
            text-anchor: middle;
            -webkit-user-select: none;
            -moz-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }

        @media (min-width: 768px) {
            .bd-placeholder-img-lg {
                font-size: 3.5rem;
            }
        }
    </style>
    <!-- Custom styles for this template -->
    <link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="/css/blog.css" rel="stylesheet">
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>
<div class="container">
    <header class="blog-header py-3">
        <div class="row flex-nowrap justify-content-between align-items-center">
            <c:if test="${id == null}">
                <div class="col-4 d-flex justify-content-start">
                    <a class="btn btn-sm btn-outline-secondary" href="/kbdmem/login">Login</a>
                    <a class="btn btn-sm btn-outline-secondary" href="/kbdmem/user/detail">MyPage</a>
                </div>
                <div class="col-4 text-center">
                    <a class="blog-header-logo text-dark" href="/kbdmain">KeyBoard Shop</a>
                </div>
                <div class="col-4 pt-1 d-flex justify-content-end align-items-center">
                    <a class="btn btn-sm btn-outline-secondary" href="/kbdmem/add">Sign up</a>
                    <a class="btn btn-sm btn-outline-secondary" href="/kbdboard/list/1">Service Center</a>
                </div>
            </c:if>
            <c:if test="${id != null}">
                <div class="col-4 d-flex justify-content-start"> 
                    <a class="btn btn-sm btn-outline-secondary" href="javascript:logout()">Logout</a>
                    <a class="btn btn-sm btn-outline-secondary" href="/kbdmem/user/detail">MyPage</a>
                    <a class="btn btn-sm btn-outline-body">${id}님 환영합니다</a>
                </div>
                <div class="col-4 text-center">
                    <a class="blog-header-logo text-dark" href="#">KeyBoard Shop</a>
                </div>
                <div class="col-4 d-flex justify-content-end align-items-center">
                	<c:if test="${id == 'admin'}">
						<a class="btn btn-sm btn-outline-body" href="/kbdmain/admin">관리자 페이지</a>
					</c:if>
                    <a class="btn btn-sm btn btn-dark" href="javascript:goCartPage()">Cart</a>
                    <a class="btn btn-sm btn-outline-secondary" href="/kbdboard/list/1">Service center</a>
                </div>
            </c:if>
        </div>
    </header>
</div>

<div class="container">
	<div class="nav-scroller py-1 mb-2">
	    <nav class="nav d-flex justify-content-between">	      
	      <a class="p-2 text-body" href="/kbdprod/list/r">[Keyboard Rental]</a>
	      <a class="p-2 text-body" href="/kbdprod/list/k">[Keyboard 구매]</a>
	      <a class="p-2 text-body" href="/kbdprod/list/s">[Switch 구매]</a>
	      <a class="p-2 text-body" href="/kbdboard/list/2">[키보드 게시판]</a>
	      <a class="p-2 text-body" href="/kbdboard/list/3">[스위치 게시판]</a>
	      <a class="p-2 text-body" href="/kbdboard/list/4">[자유 게시판]</a>
    	</nav>
    </div>
</div>
</body>
</html>