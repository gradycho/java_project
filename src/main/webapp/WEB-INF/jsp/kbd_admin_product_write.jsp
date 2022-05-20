<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>상품정보 저장 페이지</title>
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function formCheck(){
		var pId = $('#pId').val();
		var pDiv = $('#pDiv').val();
		var pName = $('#pName').val();
		var pDate = $('#pDate').val();
		var price = $('#price').val();
		var img1 = $('#img1').val();
		var files = $('files').val();
		if(pId=='' || pDiv=='' || pName=='' || pDate=='' || price=='' || img1=='' || files==''){
			alert('필수 항목들을 모두 기입해주세요');
			return false;
		}
		
		var form = $('#formData')[0];
		var formData = new FormData(form);
		
		$.ajax({
			url:'/kbdmain/upload',
			method:'post',
			cache:false,
			enctype:'multipart/form-data',
			data:formData,
			dataType:'json',
			processData:false,
			contentType:false,
			success:function(res){
				if(res.uploaded){
					alert('성공적으로 업로드 되었습니다');
					location.href='/kbdmain/admin';
				}else{
					alert('업로드 실패');
				}
			},
			error:function(xhr, status, err){
				alert('에러: '+err);
			}
		});
		return false;
	}

</script>
</head>
<body>
<h3>상품정보 저장</h3>
<form id="formData" onsubmit="return formCheck()">
<table>
	<tr><td>상품 ID</td><td> <input type="text" id="pId" name="pId" value="R_sample_001" ></td></tr>
	<tr><td>상품구분</td><td> <input type="text" id="pDiv" name="pDiv" value="r" ></td></tr>
	<tr><td>상품명</td><td> <input type="text" id="pName" name="pName" value="렌탈 샘플 키보드"></td></tr>
	<tr><td>모델명</td><td> <input type="text" id="modelNo" name="modelNo" value="sea-stranard-001"></td></tr>
	<tr><td>제조사</td><td> <input type="text" id="pCompany" name="pCompany" value="sea"></td></tr>
	<tr><td>입고일</td><td> <input type="text" id="pDate" name="pDate" value="2022-02-05"></td></tr>
	<tr><td>가 격</td><td> <input type="text" id="price" name="price" value="10000"></td></tr>
	<tr><td>재 고</td><td> <input type="text" id="stock" name="stock" value="10"></td></tr>

	<tr><td>파일 업로드 </td><td><input type="file" id='files' name="files" multiple="multiple"></td></tr>
	<tr align="center"><td colspan="2" ><button type="submit">등록</button><button type="reset">취소</button></td></tr>
</table>
</form>
<!-- 상품 업로드 에러잡고, 데이터 업로드, 파일업로드, 뷰, 상품수정, 삭제기능 -->
<!-- 결제페이지 -->
</body>
</html>