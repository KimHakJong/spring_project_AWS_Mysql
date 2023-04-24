<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>GANT</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<link rel="stylesheet" 
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<link href="css/home.css" rel="stylesheet" type="text/css">

<script src="js/update.js"></script>
<script>

</script>
<style>
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}
form>div {font-size:32px; font-weight:bold; text-align:center; margin:0px 0px 40px 0px}

form{width:600px; margin:0 auto; border:1px solid #ced4da; border-radius:4px;
	 padding: 60px 90px 30px 90px}
#showImage > img {border-radius:50%}
span { font-size: 13px;}
#menuOutline{padding-bottom:50px !important}
#menuOutline div {color:black}
#menuOutline label {color:black}
#menuOutline input {color:black}
.check{margin-top:10px}
label{font-size:14px; font-weight:bold; display:block !important;margin-top:20px !important; cursor:pointer; }
select, input, button { height:50px; margin:10px 0px 0px 0px; 
						border-radius:4px; cursor:pointer;
						border:1px solid #ced4da; background-color:white}
input:focus {border:3px solid #009CFF; outline:none}
input, button {width:100%;  padding:15px 12px}
select {background:white;}

button:disabled{background:#AEAEAE; border:none}
button:enabled {background:#009CFF; border:1px solid #009CFF; opacity:0.9}
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
#certsend{float:right; width:30%; font-size:13.3px}

#certnum {width:63%; float:left}
#certcheck{float:right; width:35%; font-size: 13.3px;}
#post{width:68%}
#spost{width:30%; float:right; font-size:13.3px}

#address + div, #address + div + div {display:inline-block; width:49%}
#address + div > label {float:left}
#address + div + div > label{float:left}

#address + div + div {float:right}
#address + div + div > label {float:left}
#department, #position{width:100%; font-size: 18px;}
/* select option[value=""]:disabled{ */
/* display: none; */
/* } */

button{background-color:black; color:white}
button[type=submit],[type=reset]{
	display:inline-block;
	font-weight:bold; font-size:18px; color:white;
	background-color:black; 
	height:55px; width:150px;
	border:none; outline:none
	}
button[type=reset]{
	background-color:white; color:black; border:1px solid #ced4da; 
	}
button[type=submit]{
	background-color:#009CFF; 
	}
button[type=reset]:hover{
	background-color:
}

.mymenu > a {
	border: 1px solid black;
    border-radius: 0px 0px 12px 12px;
    background-color: black;
    color: white;
    padding: 7px;
    padding-bottom: 0px;
    margin-right: -3px;
    font-size: x-large;
    position: relative;
    left: -20px;
    top: -15px;
}

input[type=file] {
		display : none;
	}
.clearfix {
    margin-bottom: 15px;
    margin-top: 15px;
}

</style>
</head>
<body>

<script>
	$(function() {
// 		$(".mymenu > a").click(function() {
			
// 			$(this).attr("class", "change");
		
// 		})
		
		
// 		$(".good").click(function() {
			
// 		$(this).toggleClass("change");
		
// 		})
		
});
</script>

<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">

		  <div id="menuOutline">
			<form action="updateProcess.home" method="post" enctype="multipart/form-data">
				<div>개인정보</div>
				
<%--    				<span id="filename">${info.profileimg }</span> --%>
   			<label>
   				<span id="showImage">
   					<c:if test='${empty info.profileimg }'>
						<c:set var='src' value='image/defaultprofile.png'/>   				
   					</c:if>
   					
   					<c:if test='${!empty info.profileimg }'>
   						<c:set var='src' value='${"memberupload/"}${info.profileimg }'/>
   						<input type="hidden" name="check" value="${info.profileimg }">
   					</c:if>
					<img src="${src}" width="100px" alt="profile" >   					
   				</span>
				<input type="file" name="profileimg" accept="image/*">   				
   			</label>
				
				
				
				<label for="id">아이디</label>
					<input type="text" name="id" id="id" value="${info.id }" readOnly>
					<span id="id_message"></span>
					
				<label for="password">비밀번호</label>
					<input type="password" name="password" id="password" placeholder="비밀번호 입력"
							value="${info.password }">
					<span id="pass_message"></span>
					
					<input type="password" name="password2" id="password2" placeholder="비밀번호 확인"
							value="${info.password }">
					<span id="pass2_message"></span>
					
				<label for="name">이름</label>
					<input type="text" name="name" id="name" 
							value="${info.name }" readOnly>
					<span id="name_message"></span>
					
				<label for="jumin1">주민번호</label>
					<input type="text" name="jumin1" id="jumin1" 
							value="${info.jumin.substring(0,6)}" placeholder="주민번호 앞자리" readOnly>
				<b> - </b>
					<input type="text" name="jumin2" id="jumin2" 
							value="${info.jumin.substring(7)}" placeholder="주민번호 뒷자리" readOnly>
				<span id="jumin_message"></span>
				<label for="phone1">휴대폰 번호</label>
					<input type="text" name="phone1" id="phone1" maxLength="3"
						value="${info.phone_num.substring(0,3) }">
					<b> - </b>
					<input type="text" name="phone2" id="phone2" maxLength="4"
						value="${info.phone_num.substring(4,8) }">
					<b> - </b>
					<input type="text" name="phone3" id="phone3" maxLength="4"
						value="${info.phone_num.substring(9,13) }">
					<span id="phone_message"></span>
					<b></b>
				<label for="email">이메일</label>
					<input type="text" name="email" id="email" 
							value='${info.email.split("@")[0]}'> @ 
					<input type="text" name="domain" id="domain"
							value='${info.email.split("@")[1] }'>
					<button type="button" id="certsend">인증번호 발송</button>
					<span id="email_message"></span>
					
				<div class="check">
						<input type="text" name="certnum" id="certnum" maxlength="6">
						<button type="button" id="certcheck">인증번호 확인</button>
					<span id="cert_message"></span>
				</div>
					
				<label for="post">우편번호</label>
					<input type="text" name="post" id="post" 
							value="${info.post }" readOnly maxlength="5">
					<button type="button" id="spost">주소 검색</button>
					
				<label for="address">주소</label>
					<input type="text" name="address" id="address"
							value="${info.address }">
				
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
				
				<div class="clearfix">
			      <button type=submit class="signupbtn">수정</button>
			      <button type=reset class="cancelbtn">취소</button>
				</div>
			</form>
		  </div> <!-- end menuOutline  -->
		</div> <!-- end main -->
	</div>

  <footer>
	<jsp:include page="bottom.jsp"/>
  </footer>
  
  <script>
	$('input[type=file]').change(function(event) {
		const inputfile = $(this).val().split('\\');
		const filename = inputfile[inputfile.length-1];
		
		const pattern = /(gif|jpg|jpeg|png)$/i;
		if(pattern.test(filename)) {
// 			$('#filename').text(filename);
			
			const reader = new FileReader();
			
			reader.readAsDataURL(event.target.files[0]);
			
			reader.onload = function() {
				$('#showImage > img').attr('src', this.result);
			};
		} else {
			alert('이미지 파일(gif,jpg,jpeg,png)이 아닌 경우는 무시됩니다.');
			$('#filename').text('');
			$('#showImage > img').attr('src', 'image/profile.png');
			$(this).val('')
			$('input[name=check]').val('');
		}
	})
  
  </script>


</body>
</html>