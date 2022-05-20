<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>키보드 게시판</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="/jquery/jquery-3.6.0.min.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

<section class="py-2">
	<div class="container px-4 px-lg-5 mt-5">
		<c:if test="${deptNumber == 1}">
			<h4 class="text-center">Service Center</h4>
		</c:if>
		<c:if test="${deptNumber == 2}">
			<h4 class="text-center">Keyboard Board</h4>
		</c:if>
		<c:if test="${deptNumber == 3}">
			<h4 class="text-center">Switch Board</h4>
		</c:if>
		<c:if test="${deptNumber == 4}">
			<h4 class="text-center">Free Board</h4>
		</c:if>
		
		<div><a class="btn btn-primary" href="/kbdboard/add/${deptNumber}" type="button">글쓰기</a></div>
		<br>
		<table class="table table-bordered">
			<thead>
				<tr align="center"><th scope="col">글번호</th><th scope="col">글쓴이</th><th scope="col">글제목</th><th scope="col">작성일</th><th scope="col">조회수</th><th scope="col">추천수</th></tr>
			</thead>
			<c:forEach var="board" items="${pageInfoBoard.list}">
				<tbody>
					<tr align="center">
						<th scope="row">${board.boardNum}</th>
						<td>${board.id}</td>
						<td><a href="/kbdboard/read/${board.boardNum}">${board.title}</a></td>
						<td>${board.wdate}</td>
						<td>${board.hitcount}</td>
						<td>${board.recommend}</td>
					</tr>												
				</tbody>
			</c:forEach>
		</table>
		<br>
		<div id="pagination" class="text-center">
		   <c:forEach var="i" items="${pageInfoBoard.navigatepageNums}">
		      <c:choose>
		         <c:when test="${i==pageInfoBoard.pageNum}">
		            [${i}] 
		         </c:when>
		         <c:otherwise>
		            [<a href="/kbdboard/list/page/${i}">${i}</a>] 
		         </c:otherwise>
		      </c:choose> 
		   </c:forEach>
		</div>
	</div>
</section>


</body>
</html>