<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>장바구니 페이지</title>
<style>
	table{border:1px solid black; padding:0.5em; 
		border-spacing: 0; border-collapse: collapse;
	}
	th {border:1px solid black; background-color: #eee;}
	th:nth-child(2){width:20em;}
	td {border:1px solid black;}
	td {padding:0.2em 0.5em; text-align:center;}
	tr#footer>td { border-top:3px double black; 
		font-weight:bolder; background-color:#eee;
	}
	tr#footer>td:nth-child(1){ text-align:right;}
	tr#footer>td:nth-child(2){ text-align:left;}
	input#qty { width:3em;}
</style>
<script src="/jquery/jquery-3.6.0.min.js"></script>
<script>
	function editQty(pNum){
		var newQty = $('#'+pNum).val()
		var obj = {};
		obj.pNum = pNum;
		obj.qty = newQty;
		$.ajax({
			url:'/kbdprod/editcart',
			method:'post',
			cache:false,
			data:obj,
			dataType:'json',
			success:function(res){
				alert(res.edited? '수량변경 하였습니다': '수량변경 실패..');
				$('#editSum').text(res.edited_cart_sumPrice);
			},
			error:function(xhr, status, err){
				alert("에러: "+err);
			}
		});
		return;
	}
	function del(pNum){
		if(!confirm('정말로 삭제하시겠어요?')){
			return;
		}
		location.href = '/kbdprod/del/'+pNum;
		
	}
	function delAll(){
		if(!confirm('정말로 모두 삭제하시겠어요?')){
			return;
		}
		location.href = '/kbdprod/delcart';
	}
	function orderCart(){
		if(!confirm('장바구니 품목들을 결제하시겠어요?')){
			return;
		}
		$.ajax({
			url:"/kbdprod/order",
			cache:false,
			dataType:'json',
			success:function(res){
				if(res.paid){
					alert('결제하였습니다');
					location.href='/kbdmain';
				}else{
					alert('결제 실패..');
				}
			},
			error:function(xhr, status, err){
				alert("에러: "+err);
			}
		});
	}
	var useCouponCnt = 0;
	
	function applyCoupon(){
		let coupon = ${user_coupon};
		if(coupon>0 && useCouponCnt==0){
			$.ajax({
				url:'/kbdprod/applycoupon',
				dataType:'json',
				success:function(res){
					if(res.applied){
						alert('할인 적용되었습니다');
						$('#editSum').text(res.apply_coupon_sumPrice);
						useCouponCnt = 1; 
					}else{
						alert('적용 실패..');
					}
				},
				error:function(xhr, status, err){
					alert('에러: '+err);
				}
			});
			
		}else{
			alert('보유쿠폰이 없거나 이미 사용하였습니다');
		}
	}
	
	function cancelCoupon(){
		useCouponCnt = 0;
		$.ajax({
			url:'/kbdprod/cancelcoupon',
			dataType:'json',
			success:function(res){
				if(res.canceled){
					alert('취소되었습니다');
					$('#editSum').text(res.cancel_coupon_sumPrice);
				}else{
					alert('적용 실패..');
				}
			},
			error(xhr, status, err){
				alert('에러: '+err);
			}
		});
	}
</script>
</head>
<body>
<h3>장바구니 목록</h3>
<table>
<tr><th>상품번호</th><th></th><th>상품명</th><th>가 격</th><th>제조사</th><th>수량</th></tr>
<c:forEach var="product" items="${cart_list}">
<input type="hidden" id="price" name="price" value="${product.price}">
	<tr><td>${product.pNum}</td>
		<td><img src="/upload/${product.repImgName}" width="150" height="100">
		<td>${product.pName}</td>
		<td>${product.price}</td>
		<td>${product.pCompany}</td>
		<td> <input type="number" id="${product.pNum}" name="qty" value="${product.qty}"> 
			<button type="button" onclick="editQty(${product.pNum})">수정</button><button type="button" onclick="del(${product.pNum})">삭제</button>
		</td>
	</tr>
</c:forEach>
<tr><td colspan="3">*보유 쿠폰수:${user_coupon}장&nbsp;<button type="button" onclick="applyCoupon();">적용</button><button type="button" onclick="cancelCoupon();">취소</button></td></tr>
<fmt:formatNumber type="number" maxFractionDigits="3"  value="${cart_sumPrice}" var="sum" />
	<tr id="footer"><td colspan="3">총 계<td colspan="3"><span id="editSum">${sum}</span>원</td></tr>
</table>
<br>
<div><a href="/kbdmain">[메인 페이지]</a><a href="javascript:delAll();">[장바구니 비우기]</a></div>
<br>
<div><button type="button" onclick="orderCart()">결제하기</button></div>
<div>* 쿠폰은 한장만 사용 가능하며 1장 사용시 전체금액의 10%를 할인해 줍니다</div>
</body>
</html>