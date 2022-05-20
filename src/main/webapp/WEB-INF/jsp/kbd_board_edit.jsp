<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 수정 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function formCheck(){
		if($('#title').val()==''){
			alert('제목을 입력해주세요');
			return false;
		}
		var serData = $('#formData').serialize();
		var num = $('#deptNum').val()
		$.ajax({
			url:'/kbdboard/update',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				if(res.updated){
					alert('수정되었습니다');
					location.href='/kbdboard/'+num;
				}else{
					alert('수정 실패');
					location.href='/kbdmain';
				}
			},
			error:function(xhr, status, err){
				alert('err: '+err);
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
		<c:if test="${edit_content.deptNum == 1}">
			<h4 class="text-center">고객센터 게시판</h4>
		</c:if>
		<c:if test="${edit_content.deptNum == 2}">
			<h4 class="text-center">키보드 게시판</h4>
		</c:if>
		<c:if test="${edit_content.deptNum == 3}">
			<h4 class="text-center">스위치 게시판</h4>
		</c:if>
		<c:if test="${edit_content.deptNum == 4}">
			<h4 class="text-center">자유 게시판</h4>
		</c:if>
		
		<form id="formData" onsubmit="formCheck()">
			<div class="form-group">
				<input type="hidden" id="boardNum" name="boardNum" value="${edit_content.boardNum} ">
				<input type="hidden" id="deptNum" name="deptNum" value="${edit_content.deptNum} ">
			</div>
			<div class="text-center">
				글번호: ${edit_content.boardNum} &nbsp;&nbsp;&nbsp;글쓴이: ${edit_content.id} &nbsp;&nbsp;&nbsp;작성일: ${edit_content.wdate} &nbsp;&nbsp;&nbsp;조회수: ${edit_content.hitcount} &nbsp;&nbsp;&nbsp;추천수: ${edit_content.recommend}
			</div>
			<div class="form-group">
				<label for="title">글제목</label>
				<input type="text" class="form-control"  id="title" name="title" value="${edit_content.title}">
			</div>
			<div class="form-group">
				<label for="content">글내용</label>
				<textarea class="form-control" id="content" name="content" rows="5" cols="30">${edit_content.content}</textarea>
			</div>
			<div class="text-center">
					<button class="btn btn-primary" type="submit">수정</button>&nbsp;<button class="btn btn-primary" type="reset">취소</button>
			</div>	
				
		</form>
		
		<%-- <form id="formData" onsubmit="formCheck()">
				<input type="hidden" id="boardNum" name="boardNum" value="${edit_content.boardNum} ">
				<input type="hidden" id="deptNum" name="deptNum" value="${edit_content.deptNum} ">
				<div>글번호: ${edit_content.boardNum} 글쓴이: ${edit_content.id} 작성일: ${edit_content.wdate} 조회수: ${edit_content.hitcount} 추천수: ${edit_content.recommend}</div>	
				<div>글제목: <input type="text" id="title" name="title" value="${edit_content.title}"></div>
				<div>글내용:</div>
				<div><textarea id="content" id="content" name="content" rows="5" cols="30">${edit_content.content}</textarea></div>
				<div><button type="submit">수정</button><button type="reset">취소</button></div>
		</form> --%>
	</div>
</section>
</body>
</html>