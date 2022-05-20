<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>글 내용</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function del(num){
		if(!confirm('정말로 삭제하시겠어요?')){
			return;
		}
		var deptNum = $('#deptNum').val();
		$.ajax({
			url:'/kbdboard/del/'+num,
			dataType:'json',
			success:function(res){
				if(res.deleted){
					alert('게시글이 삭제되었습니다');
					location.href='/kbdboard/'+deptNum;
				}else{
					alert('삭제 실패');
				}
			},
			error:function(xhr, status, err){
				alert('err: ' +err);
			}
		});
	}
	
</script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-fQybjgWLrvvRgtW6bFlB7jaZrFsaBXjsOMm/tB9LTS58ONXgqbR9W8oWht/amnpF" crossorigin="anonymous"></script>

<section class="py-2">
	<div class="container px-4 px-lg-5 mt-5">
		<h4 class="text-center">글내용</h4>
		<br>
		
		<c:set var="detail" value="${read_content}"/>
			<input type="hidden" id="deptNum" name="deptNum" value="${detail.deptNum}">
			
			<table class="table table-bordered">
				<thead>
					<tr align="left">
						<th scope="col">글번호: ${detail.boardNum}</th>
						<th scope="col">글쓴이: ${detail.id}</th>
						<th scope="col">작성일: ${detail.wdate}</th>
						<th scope="col">조회수: ${detail.hitcount}</th>
						<th scope="col">추천수: ${detail.recommend}</th>
					</tr>
				</thead>
				<tbody>
					<tr align="left">
						<td colspan="5">글제목: ${detail.title}</td>
					</tr>
					<tr align="left">
						<td colspan="5">글내용:<br>
						${detail.content}
						</td>
					</tr>
					
				</tbody>	
			</table>
			<c:if test="${id==detail.id}">
				<div class="text-center"><a class="btn btn-primary" href="/kbdboard/edit/${detail.boardNum}">수정하기</a>&nbsp;&nbsp;&nbsp;
					 <a class="btn btn-primary" href="javascript:del(${detail.boardNum})">삭제하기</a></div>
			</c:if>
	</div>
</section>
</body>
</html>