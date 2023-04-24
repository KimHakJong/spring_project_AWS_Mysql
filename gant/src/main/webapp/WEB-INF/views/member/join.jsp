<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>GANT</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="../resources/js/member/join.js"></script>
<script>

</script>
<style>
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}
body>div{margin-top:4em; margin-bottom:4em}
form>div {font-size:32px; font-weight:bold; text-align:center; margin:0px 0px 40px 0px}

form{width:600px; margin:0 auto; border:1px solid #ced4da; border-radius:4px;
	 padding: 60px 90px 30px 90px}
	 
span { font-size: 13px;}

label{font-size:14px; font-weight:bold; display:block;margin-top:20px}
select, input, button { height:50px; margin:10px 0px 0px 0px; 
						border-radius:4px; cursor:pointer;
						border:1px solid #ced4da; background-color:white}
select:focus{border:3px solid #009CFF}
select:active{border:3px solid #009CFF}
input:focus {border:3px solid #009CFF; outline:none}
input, button {width:100%;  padding:15px 12px}
select {background:white;}

button:disabled{background:#C3C3C3; border:none}
button:enabled {opacity:0.9}
button:enabled:hover{opacity:1}

#password {margin-bottom:0px;}
#password2 {margin-top:7px}
#jumin1, #jumin2 {width:48%}
#jumin2{float:right}

#phone1, #phone2, #phone3 {width:30%}
#phone2 {float: center;}
#phone3 { float:right;}
#email, #domain {width:35%}
#domain {width:28%}
#certsend{float:right; width:30%;}

#certnum {width:63%}
#certcheck{float:right; width:35%}

#post{width:68%}
#spost{width:30%; float:right}

#address + div, #address + div + div {display:inline-block; width:49%}
#address + div > label {float:left}
#address + div + div > label{float:left}

#address + div + div {float:right}
#address + div + div > label {float:left}
#department, #position{width:100%}
select option[value=""]:disabled{
	display: none;
}

button{background-color:#009CFF; color:white; border:1px solid #009CFF}
button[type=submit]{font-weight:bold; height:60px; font-size:16px; background-color:#009CFF; color:white; outline:none}
</style>
</head>
<body>
<div>
	<form action="joinProcess" method="post">
		<div>회원가입</div>
		<label for="id">아이디</label>
			<input type="text" name="id" id="id" placeholder="아이디 입력">
			<span id="id_message"></span>
			
		<label for="password">비밀번호</label>
			<input type="password" name="password" id="password" placeholder="비밀번호 입력">
			<span id="pass_message"></span>
			
			<input type="password" name="password2" id="password2" placeholder="비밀번호 확인">
			<span id="pass2_message"></span>
			
		<label for="name">이름</label>
			<input type="text" name="name" id="name" placeholder="이름 입력">
			<span id="name_message"></span>
			
		<label for="jumin1">주민번호</label>
			<input type="text" name="jumin1" id="jumin1" placeholder="주민번호 앞자리" maxlength="6">
		<b> - </b>
			<input type="password" name="jumin2" id="jumin2" placeholder="주민번호 뒷자리" maxLength="7">
		<span id="jumin_message"></span>
		<label for="phone1">휴대폰 번호</label>
			<input type="text" name="phone1" id="phone1" maxLength="3">
			<b> - </b>
			<input type="text" name="phone2" id="phone2" maxLength="4">
			<b> - </b>
			<input type="text" name="phone3" id="phone3" maxLength="4">
			<span id="phone_message"></span>
			
		<label for="email">이메일</label>
			<input type="text" name="email" id="email"> @ 
			<input type="text" name="domain" id="domain">
			<button type="button" id="certsend">인증번호 발송</button>
			<span id="email_message"></span>
			
		<label for="certnum">인증번호</label>	
			<input type="text" name="certnum" id="certnum" maxlength="6">
			<button type="button" id="certcheck">인증번호 확인</button>
			<span id="cert_message"></span>
			
		<label for="post">우편번호</label>
			<input type="text" name="post" id="post" readOnly maxlength="5">
			<button type="button" id="spost">주소 검색</button>
			
		<label for="address">주소</label>
			<input type="text" name="address" id="address">
		
		<div>
		<label>부서명</label>
			<select name="department" id="department" >
				<option value="" disabled selected>부서명 선택</option>
				<option value="대표">대표</option>
				<option value="기획부">기획부</option>
				<option value="영업부">영업부</option>
				<option value="인사부">인사부</option>
				<option value="전산부">전산부</option>
				<option value="총무부">총무부</option>
				<option value="회계부">회계부</option>
			</select>
		</div>
		
		<div>
		<label>직급</label>
			<select name="position" id="position" >
				<option value="" disabled selected>직급 선택</option>
				<option value="대표">대표</option>
				<option value="부장">부장</option>
				<option value="차장">차장</option>
				<option value="과장">과장</option>
				<option value="대리">대리</option>
				<option value="사원">사원</option>
			</select>
		</div>
		
		<button type="submit">가입하기</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</div>
</body>
</html>