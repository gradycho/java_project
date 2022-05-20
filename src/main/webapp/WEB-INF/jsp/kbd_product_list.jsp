<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>제품 리스트 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<link href="https://fonts.googleapis.com/css?family=Playfair&#43;Display:700,900" rel="stylesheet">
<link href="/css/blog.css" rel="stylesheet">
<script src="/jquery/jquery-3.6.0.min.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>


<section class="py-2">
	<div class="container px-4 px-lg-5 mt-5">
		<c:if test="${productDivision=='r'}">
			<h4 class="text-center">Keyboard Rental List</h4>
		</c:if>
		<c:if test="${productDivision=='k'}">
			<h4 class="text-center">Keyboard Product List</h4>
		</c:if>
		<c:if test="${productDivision=='s'}">
			<h4 class="text-center">Switch Product List</h4>
		</c:if>

		<br>
	    <div class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center">
	        <c:forEach var="product" items="${pageInfoProd.list}">
	        <div class="col mb-5">
	        
	            <div class="card h-100">
	                <!-- Product image-->
	                <a href="/kbdprod/detail/${product.pId}"><img class="card-img-top" src="/upload/${product.repImgName}" alt="${product.pName}" /></a>
	                <!-- Product details-->
	                <div class="card-body p-4">
	                    <div class="text-center">
	                        <!-- Product name-->
	                        <h5 class="fw-bolder">${product.pName}</h5>
	                        <!-- Product price-->
	                        ${product.price}
	                    </div>
	                </div>
	                <%-- <!-- Product actions-->
	                <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
	                    <div class="text-center"><a class="btn btn-outline-dark mt-auto" href="/kbdprod/detail/${product.pId}">View details</a></div>
	                </div> --%>
	            </div>                     
	        </div>
	        </c:forEach>
	    </div>

<%-- <c:forEach var="product" items="${pageInfoProd.list}">
	<div><a href="/kbdprod/detail/${product.pId}"><img src="/upload/${product.repImgName}" alt="${product.pName}" width="200" height="250"></a></div>
	<div>상품명: ${product.pName}</div>
	<div>가격: ${product.price}</div>	
	<br>
</c:forEach> --%>

		<div id="pagination" class="text-center">
		   <c:forEach var="i" items="${pageInfoProd.navigatepageNums}">
		      <c:choose>
		         <c:when test="${i==pageInfoProd.pageNum}">
		            [${i}] 
		         </c:when>
		         <c:otherwise>
		            [<a href="/kbdprod/list/page/${i}">${i}</a>] 
		         </c:otherwise>
		      </c:choose> 
		   </c:forEach>
		</div>

	</div>
</section>

</body>
</html>