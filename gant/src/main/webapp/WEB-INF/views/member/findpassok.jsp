<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.js"></script>

<title>GANT</title>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box}
   
#frame{width:520px; margin:0 auto; margin-top:150px;
	 border-radius:4px; border:1px solid #C4C5C8; padding:20px 40px 40px 40px}
hr{color:#ced4da}
#text{text-align:center;margin-top:-15px}
span{font-weight:bold;color:#009CFF}
span:nth-child(2){color:red}
#password, #re_password{padding:15px 12px}
#password, #re_password{height:50px; width:80%; margin-top:10px; margin-bottom:10px; border:1px solid #ced4da; border-radius: 4px}
#inputs{position:relative; top:30px}
#password:focus, #re_password:focus {border:2px solid #009CFF; outline:none}

#logbtn{height:50px; width:180px; 
       border-radius:4px; border:1px solid #009CFF; 
	   outline:none; font-size:16px; cursor:pointer;
	   color:white;display:block; margin:0 auto; background:#009CFF}
	   
#logbtn:hover{background:#26abff; border:1px solid #26abff; }

</style>
<script>
$(document).ready(function(){
	$("form").submit(function(){
		if($("#password").val()!=$("#re_password").val()) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
	});
	
});
</script>
</head>
<body>
   <div id="frame">
  	<h3>비밀번호 변경</h3>
  	<hr>
  	<br>
  	<br>
  	<form action="findpassokProcess" method="post">
  	<div id="text">
  	<span>${id}</span> 님의 새로운 비밀번호를 입력해주세요.
  	<div id="inputs">
  	<input type="hidden" name="id" value="${id}">
    <input type="password" name="password" placeholder="새 비밀번호 입력" id="password">
    <input type="password" name="re_password" placeholder="새 비밀번호 확인" id="re_password">
  	</div>
  	</div>
  	<br>
  	<br>
  	<br>
  	<input type="submit" id="logbtn" value="비밀번호 변경">
  	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  	</form>
  </div>
</body>
</html>