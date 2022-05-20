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
<title>글쓰기 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function formCheck(){
		if($('#title').val()==''){
			alert('제목은 필수 기입사항입니다');
			return false;
		}
		var serData = $('#formData').serialize();
		var deptNum = $('#deptNum').val();
		$.ajax({
			url:'/kbdboard/add',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				if(res.saved){
					alert('작성한 글이 성공적으로 업로드 되었습니다');
					location.href='/kbdboard/list/'+deptNum;
				}else{
					alert('업로드 실패');
				}
			},
			error(xhr, status, err){
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
			<c:if test="${deptNumber == 1}">
				<h4 class="text-center">고객센터 게시판 글쓰기</h4>
			</c:if>
			<c:if test="${deptNumber == 2}">
				<h4 class="text-center">키보드 게시판 글쓰기</h4>
			</c:if>
			<c:if test="${deptNumber == 3}">
				<h4 class="text-center">스위치 게시판 글쓰기</h4>
			</c:if>
			<c:if test="${deptNumber == 4}">
				<h4 class="text-center">자유 게시판 글쓰기</h4>
			</c:if>
			
			<form id="formData" onsubmit="return formCheck()">
				<div class="form-group">
					<input type="hidden" id="deptNum" name="deptNum" value="${deptNumber}">
				</div>
				<div class="form-group">
					<label for="id">글쓴이 </label>
					<input type="text" class="form-control" id="id" name="id" value="${id}" readonly>
				</div>
				<div class="form-group">
					<label for="title">글제목 </label>
					<input type="text" class="form-control" id="title" name="title">
				</div>
				<div class="form-group">
					<label for="content">글내용 </label>
					<textarea class="form-control" id="content" name="content" rows="5" cols="30"></textarea>
				</div>
				<div class="text-center">
					<button class="btn btn-primary" type="submit">저장</button>&nbsp;<button class="btn btn-primary" type="reset">취소</button>
				 </div>
			</form>
			
			<%-- <form id="formData" onsubmit="return formCheck()">
				<input type="hidden" id="deptNum" name="deptNum" value="${deptNumber}">
				<div>글쓴이: <input type="text" id="id" name="id" value="${id}" readonly></div>
				<div>글제목: <input type="text" id="title" name="title"></div>
				<div>글내용: </div>
				<div><textarea id="content" name="content" rows="5" cols="30"></textarea></div>
				<div><button type="submit">저장</button><button type="reset">취소</button></div> 
			</form> --%>
			
		</div>
	</section>
</body>
</html>