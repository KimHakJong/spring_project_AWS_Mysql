<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>GANT</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="../resources/js/member/findid.js"></script>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box}
body > div {margin:0 auto; width:600px; position:relative; top:150px}
a { font-size:18px;
   display:inline-block; height:50px; width:50%; text-align:center;
   line-height:50px; border:1px solid #ced4da;
   text-decoration-line: none; color:black;}
   
form{padding:100px 60px 20px 60px; border-radius: 4px; border:1px solid #ced4da}
a:nth-child(1) {float:left; border-bottom:none; font-weight:bold; cursor:default}
a:nth-child(2) {float:right; border-bottom:1px solid black; font-size:14px}
a:focus{border:none; outline:none}
label{font-size:16px; width:26%; float:left; height:50px; line-height:50px;margin-top:10px; margin-bottom:10px}

input{padding:15px 12px}
button,input{height:50px; margin-top:10px; margin-bottom:10px; border:1px solid #ced4da; border-radius: 4px}
input:focus ,button:focus{border:2px solid #009CFF; outline:none}
#email {width:45%; position:relative; left:5px}
#name, #certnum {width:73%; float:right}
#sendcert{width:28%; float:right; color:white;background:#009CFF; opacity:0.9}
#sendcert:disabled {background:#C3C3C3; color:white; opacity:1}
#sendcert:hover{opacity:1}

button[type=submit]{margin-top:20px; width:100%; background:#009CFF; border:1px solid #009CFF; color:white; font-size:16px;}
button[type=submit]:hover{background:#26abff;border:1px solid #26abff;cursor:pointer}
</style>
<script>
$(document).ready(function(){
	if('${noname}'=='noname'){
		alert('등록된 이름이 없습니다.');
	}
	if('${noemail}'=='noemail'){
		alert('등록된 이메일이 존재하지 않습니다.');
	}
});
</script>
</head>
<body>
<div>
<div>
  	<a href="findid">아이디 찾기</a>
  	<a href="findpass">비밀번호 찾기</a>
</div>

  <form action="findidok" method="post">
	
    <label for="name">이름</label>
    <input type="text" name="name" id="name">
    
    <label for="email">이메일 주소</label>
    <input type="text" name="email" id="email">
    <button type="button" id="sendcert">인증번호 발송</button>
	
    <label for="certnum">인증번호</label>
    <input type="text" maxlength="6" name="certnum" id="certnum">
    
    <button type="submit">인증확인</button>
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
  </form>
</div>
</body>
</html>