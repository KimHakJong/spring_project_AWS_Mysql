<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>

<title>에러페이지</title>
<style>
b{color:orange}
body{text-align:center}
</style>
</head>
<body>
에러페이지<br>
<img src="${pageContext.request.contextPath}/resources/image/error/error.png" width="100px"><br>
<p> 죄송합니다. <br>
	  	  ${message}</p>
	  <span>서비스 이용에 불편을 드려 죄송합니다.</span>
</body>
</html>