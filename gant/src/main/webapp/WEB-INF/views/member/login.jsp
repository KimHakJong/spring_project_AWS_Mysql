<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box}
   body > div{
   	margin-top:6%;
   }
    .logo{margin-top:60px; margin-bottom:30px; text-align:center}
    img{width:250px}
	h1{font-family:"Lora"; text-align:center; margin-bottom:20px; font-weight:bold; font-size:40px; color:#006CFF}
	
	form{width:500px; margin:0 auto; border:1px solid #ced4da; padding:20px 40px; border-radius: 4px;
		margin-bottom:50px;}
		
	#log{margin: 20px 0px 10px 0px; font-size:28px;}	
	#id, #password {width:100%; height:50px; margin:15px 0px; border:1px solid #ced4da; padding:15px 12px; border-radius: 4px;
	}
	
	#password + img {
    width: 28px;
    height: 28px;
    position: relative;
    top: -55px;
    left: 372px;
	}
	
	#log + div + div {height:80px}
	#id:focus, #password:focus{border:2px solid #009CFF; outline:none}
	label{cursor:pointer}
	#check1, #check2 {margin:5px 0px;}
	span {position:relative; margin-left:6px}
	#store + span {
    position: relative;
    top: -1.6px;
	}
	input[type=checkbox], input[type=radio] {
    box-sizing: border-box;
    padding: 0;
    width: 14px;
    height: 14px;
	}
	a{float:right;  text-decoration: none; color:black; }
	a:hover{color:black}
	button{width:100%; height:50px; margin:10px 0px; 
	border-radius: 4px; color:white;
	padding: 10px;
	border:none;
	}
	 
	#submitbtn {background-color: #009CFF; color: white; border: 1px solid #009CFF;}
	#submitbtn:hover {background-color:#26abff; border:1px solid #26abff;}
	#submitbtn:hover, #joinbtn:hover {cursor:pointer}
	#joinbtn{background-color:white; color:black; border:1px solid #ced4da;}
	#joinbtn:hover {background-color:#33C43C; color:white; opacity:0.9}
</style>
<script>
$(document).ready(function(){
	
  var id = '${id_store}';
  if(id){
	  $('#store').attr('checked',true);
	  $('#id').val(id);
  }
  
  if("${result}" == 'joinSuccess'){
		alert("회원 가입을 축하합니다.")
	}else if("${loginfail}" == 'loginFailMsg'){
		alert("아이디 또는 비밀번호가 일치하지 않습니다.");
	}else if("${update}" == 'success'){
		alert("정상적으로 비밀번호가 변경되었습니다.");
	}
  
  $('#joinbtn').click(function(){
	location.href="${pageContext.request.contextPath}/member/join";
  });
  
  $('#password + img').click(function(){
	  if($('#password').attr('type')=='password'){
		  $('#password').attr('type','text');
		  $(this).attr('src','${pageContext.request.contextPath}/resources/image/member/hidepass.png');
	  }else if($('#password').attr('type')=='text'){
		  $('#password').attr('type','password');
		  $(this).attr('src','${pageContext.request.contextPath}/resources/image/member/showpass.png');
	  }
  });
  
  	$('#store').click(function(){
		 if($('#store').is(':checked')==true && $('#autologin').is(':checked')==true ) {
			 $('#autologin').prop('checked',false);
		 }
  	})
  	
  	$('#autologin').click(function(){
		 if($('#store').is(':checked')==true && $('#autologin').is(':checked')==true ){
			 $('#store').prop('checked',false);
		 }
 	})
 	
 	$("form").submit(function(){
 		
 		$("#store").val($("#id").val());
 	});
});
</script>
</head>
<body>
<div>
	<div class="logo"><img src="${pageContext.request.contextPath}/resources/image/member/logo.png"></div>
	<form action="${pageContext.request.contextPath}/member/loginProcess" method="post">
		<div id="log">LOGIN</div>
		<div>
			<input type="text" id="id" name="id" placeholder="아이디를 입력하세요">
		</div>
		<div>
			<input type="password" id="password" name="password" autocomplete="off" placeholder="비밀번호를 입력하세요"><img src="${pageContext.request.contextPath}/resources/image/member/showpass.png">
		</div>	
		<div id="check1">
			<label for="store">
				<input type="checkbox" name="store" id="store"><span>ID</span> 저장</label>
			<a href="${pageContext.request.contextPath}/member/findid">아이디/비밀번호 찾기</a>
		</div>
		<div id="check2">
			<label for="autologin">
				<input type="checkbox" name="remember-me" id="autologin"><span>자동 로그인</span></label>
		</div>
		<button type="submit" id="submitbtn">로그인</button>
		<button type="button" id="joinbtn">회원가입</button>
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>
</div>
</body>
</html>