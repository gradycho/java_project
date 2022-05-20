<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
<title>회원 가입 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	var isPwdChecked = false;
	var isIdChecked = false;
	
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
		
		if(isIdChecked==false){
			alert('아이디 중복을 확인해주세요');
			return false;
		}
		
		if(isPwdChecked==false){
			alert('비밀번호체크를 확인해주세요');
			return false;
		}
		
		var serData = $('#formData').serialize();
		$.ajax({
			url:'/kbdmem/add',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				if(res.sign){
					alert('회원 가입되었습니다');
					location.href="/kbdmem/login";
				}else{
					alert('회원 가입 양식을 확인후 다시 작성해주세요');
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
	
	function idCheck1(){
		var idCheck = $('#id').val();
		var obj = {};
		obj.idCheck = idCheck;
		
		if(idCheck==''){
			alert('아이디를 입력해주세요');
			return;
		}
		
		$.ajax({
			url:'/kbdmem/add/idCheck',
			method:'post',
			cache:false,
			data:obj,
			dataType:'json',
			success:function(res){
				if(res.idChecked){
					alert('사용가능한 아이디 입니다');
					isIdChecked=true;
				}else{
					alert('이미 존재하는 아이디 입니다. 다른아이디를 입력해주세요');
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

<section class="py-2">
	<div class="container px-4 px-lg-5 mt-5">
		<h4 class="text-center">회원 가입 양식</h4>
			<form id="formData" onsubmit="return formCheck()">
				<div class="form-group">
					<label for="id">ID (*)</label>
					<input type="text" class="form-control" id="id" name="id"><button type="button" class="btn btn-primary mb-2" onclick="idCheck1()">id중복체크</button>
				</div>
				<div class="form-group">
					<label for="pwd">PW (*)</label>
					<input type="password" class="form-control" id="pwd" name="pwd">
				</div>
				<div class="form-group">
					<label for="pwdCheck">PW 확인 (*)</label>
					<input type="password" class="form-control" id="pwdCheck" name="pwdCheck"><button type="button" class="btn btn-primary mb-2" onclick="pwdCheck1()">비밀번호체크</button>&nbsp;&nbsp;<span id="afterPwd">&nbsp;</span>
				</div>
				<div class="form-group">
					<label for="name">이름 (*)</label>
					<input type="text" class="form-control" id="name" name="name">
				</div>
				<div class="form-group">
					<label for="phone">전화 (*)</label>
					<input type="text" class="form-control" id="phone" name="phone">
				</div>
				<div class="form-group">
					<label for="email">메일 (*)</label>
					<input type="text" class="form-control" id="email" name="email">
				</div>
				<div class="form-group">
					<label for="email">주소</label>
					<input type="text" class="form-control" id="address" name="address">
				</div>
				<div class="text-left">
					(*) 는 필수항목 입니다
				</div>
				<div class="text-center">
					<button type="submit" class="btn btn-primary">가입</button>&nbsp;<button type="reset" class="btn btn-primary">취소</button>
				</div>
				
			</form>
			
			<!-- <form id="formData" onsubmit="return formCheck()">
				<table>
					<tr><td>*</td><td>ID</td><td> <input type="text" id="id" name="id"></td><td> <button type="button" onclick="idCheck1()">id중복체크</button></td></tr>
					<tr><td>*</td><td>PW </td><td><input type="password"	id="pwd" name="pwd"></td></tr>
					<tr><td>*</td><td>PW 확인 </td><td><input type="password" id="pwdCheck" name="pwdCheck"></td>
								<td><button type="button" onclick="pwdCheck1()">비밀번호체크</button></td><td id="afterPwd"> </td></tr>
					<tr><td>*</td><td>이름 </td><td><input type="text" id="name" name="name"></td></tr>
					<tr><td>*</td><td>전화 </td><td><input type="text" id="phone" name="phone"></td></tr>
					<tr><td>*</td><td>메일 </td><td><input type="text" id="email" name="email"></td></tr>
					<tr><td></td><td> 주소 </td><td><input type="text" id="address" name="address"></td></tr>
					<tr><td colspan="4" align="center"><button type="submit">가입</button><button type="reset">취소</button></td></tr>
				</table>	
				<div>* 는 필수항목 입니다</div>
			</form> -->
	</div>
</section>
</body>
</html>