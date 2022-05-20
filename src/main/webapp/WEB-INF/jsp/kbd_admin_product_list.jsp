<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>상품 리스트</title>

</head>
<body>
<h3>전체 상품 리스트</h3>
<table>
	<tr align="center">
		<th>no</th><th>product_ID</th><th>product_Div</th><th>product_Name</th><th>model_Number</th><th>product_Company</th>
	    <th>product_date</th><th>Price</th><th>Stock</th><th>edit</th>
	</tr>
	<c:forEach var="product" items="${admin_product_list}" varStatus="status">
		<tr align="center">
			<td>${status.index+1}</td><td>${product.pId}</td><td>${product.pDiv}</td><td>${product.pName}</td>
			<td>${product.modelNo}</td><td>${product.pCompany}</td><td>${product.pDate}</td><td>${product.price}</td><td>${product.stock}</td>
			<td><a href="/kbdmain/product/detail/${product.pId}">[수정]</a></td>
		</tr>
	
	</c:forEach>	
	</table>

</body>
</html>