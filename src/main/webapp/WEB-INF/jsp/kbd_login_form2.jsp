<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
<meta name="generator" content="Hugo 0.88.1">
<title>로그인 페이지</title>
<!-- <link rel="canonical" href="https://getbootstrap.com/docs/4.6/examples/sign-in/">
Bootstrap core CSS
<link href="../assets/dist/css/bootstrap.min.css" rel="stylesheet"> -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">

<!-- <style>
	h3 {text-align:center;}
	#container{width:250px; margin:0 auto;}
	form {border:1px solid black; border-radius: 5px; width:240px; padding:10px; }
	label{position:relative; } 
	input{position:absolute; left:70px;}
	div:nth-child(3){text-align:center;}
	input{width:140px;}
	button{margin-top:10px; }
</style> -->
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
<link href="/css/signin.css" rel="stylesheet">

<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function checkForm(){
		if($('#inputID').val()=='' || $('#inputPassword').val()==''){
			alert('아이디와 패스워드를 모두 입력해주세요');
			return false;
		}
		var serData = $('#formData').serialize();
		$.ajax({
			url:'/kbdmem/login',
			method:'post',
			cache:false,
			data:serData,
			dataType:'json',
			success:function(res){
				if(res.login){
					alert('환영합니다');
					location.href="/kbdmain";
				}else{
					alert('아이디와 비밀번호를 다시 확인해주세요');
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
<!-- <body>
<h3>로그인</h3>
<div id="container">
<form id="formData" onsubmit="return checkForm()">
	<div><label>아이디 <input type="text" id="id" name="id"></label></div>
	<div><label>패스워드 <input type="password" id="pwd" name="pwd"></label></div>
	<div><button type="submit">확인</button><button type="reset">취소</button></div>
	<div align="center"><a href="/kbdmem/add" >회원가입</a></div>
</form>
</div>
</body> -->

<body class="text-center">
    
<form class="form-signin" id="formData" onsubmit="return checkForm()">
  <h1 class="h2 mb-3 font-weight-normal">Keyboard Shop</h1>
  <p></p>
  <h2 class="h3 mb-3 font-weight-normal">Please sign in</h2>
  <label for="inputEmail" class="sr-only">ID</label>
  <input type="text" id="inputID" class="form-control" placeholder="ID" required autofocus>
  <label for="inputPassword" class="sr-only">Password</label>
  <input type="password" id="inputPassword" class="form-control" placeholder="Password" required>
  <!-- <div class="checkbox mb-3">
    <label>
      <input type="checkbox" value="remember-me"> Remember me
    </label>
  </div> -->
  <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
  <h4 class="h5 mb-3 font-weight-normal"><a href="/kbdmem/add" >Sign up</a></h4>
  <p class="mt-5 mb-3 text-muted">&copy; 2021-2022</p>
</form>
   
</body>
</html>