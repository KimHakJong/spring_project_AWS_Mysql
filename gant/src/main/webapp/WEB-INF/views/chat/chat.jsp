<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>실시간 채팅</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.6.3.js"></script>

<style>
* {font-family:"noto sans", sans-serif;
   box-sizing: border-box; font-size:15px}
   body{background-color:#FAFAFA; border-collapse:collapse;}
.out {
    padding: 10px;
    width: 100%;
    height: 100%;
}
#myinfo{padding:12px;height:70px; background:white; border:1px solid #C4C5C8;  border-radius:2px}
#onimg {
    width: 30px;
    height: 30px;
    right: 44px;
    top: 36px;
    opacity: 0.8;
    position: absolute;
}
#onimg:hover{cursor:pointer}
#onlinelist {
    height: auto;
    width: 110px;
    border: 2px solid #C4C5C8;
    position: absolute;
    z-index: 2;
    right: 83px;
    top: 47px;
    background: white;
    outline: none;
    border-radius: 20px;
    display:none
}
#onlinelist>div{text-align:center; font-weight:bold; position:relative; top:9px; font-size:16px}
#onlinelist>ul{width:100%;height:100%;list-style-type:none;padding:0; margin:16px 0px 16px 0px; text-align:center}
#onlinelist>ul+span{text-align:center}
#onlinelist>ul>li>img{width:15px;height:15px; top:3.2px; position:relative; margin-right:5px}
#onlinelist>ul>li{margin-top:7px;}
#myinfo>#myprofile{width:45px; height:45px; float:left;margin-right:20px; border-radius:50%;border:1px solid #C4C5C8}
#myinfo>#myname{width:400px;font-weight:bold; margin-bottom:5px}
#myinfo>#myname2{width:400px; margin-top:5px}
.main{border:1px solid #C4C5C8; border-radius:2px; background:white; height:85%; position:relative; z-index:1}
#messageWindow2{padding:12px; height:78%; overflow:auto; margin-top:10px}
#messageWindow2::-webkit-scrollbar {
           width: 3px; /*스크롤바의 너비*/
}
#messageWindow2::-webkit-scrollbar-thumb {
    height: 30%; /* 스크롤바의 길이 */
    background: #26abff; /* 스크롤바의 색상 */
    
    border-radius: 10px;
}

#messageWindow2::-webkit-scrollbar-track {
    background-color: transparent;  /*스크롤바 뒷 배경 색상*/
} 
.receive{position:relative; height:65px}
.profile{width:35px;height:35px; border-radius:50%;position:absolute; left:8.3px; top:9%;border:1px solid #C4C5C8}
.username {
    padding: 3px;
    position: absolute;
    top: 62%;
    left: 1px;
}

.alertMessage{text-align:center; margin:0px 0px 6px 0px}
.receivemessage{width:auto; word-wrap:break-word; 
		 display:inline-block; background:white; border:1px solid #C4C5C8;
		 border-radius:20px; padding:10px; top:2.5px; left: 56px; position: relative;}
		 
.receiveRemessage{width:auto; word-wrap:break-word; float:left;
			 display:inline-block; background:white; border:1px solid #C4C5C8;
			 border-radius:20px; padding:10px;  top:-5px; left: 56px; position: relative;margin:5px 0px 5px 0px}
.username + .clear + .receiveRemessage {margin-top:17px}
.username + .clear + .receiveRemessage + .receiveRetime{top:30px}

.receiveRetime{width:100px; position:relative; margin-left:65px; top:18px; font-size:14px}		 
.receivetime{width:100px; position:relative; margin-left:65px; top:9px; font-size:14px}		 
.sendtime {
    position: relative;
    float: right;
    margin-right: 9px;
    top: 21px;
    font-size:14px
}
.sendmessage{width:auto; word-wrap:break-word; float:right;
			 display:inline-block; background-color:#26abff;
			 color:white; border-radius:20px; padding:10px; margin:5px 5px 5px 0px}

#bottombox{position:relative; height:23%; padding: 12px 12px 4px 12px; margin-top:4px}
#inputMessage {width: 94%;  display:inline-block;
			   border:1px solid #C4C5C8; border-radius:25px; margin:0 auto;
			   height:45px; padding:10px 20px; font-size:14px; position:absolute; left:3%; bottom:33.7%}	
#inputMessage:focus {border:2px solid #26abff; outline:none}		 
button{background:transparent; border:none; outline:none; position:absolute; right:5%; bottom:39.7%}
button>img{width:30px;height:30px;}

</style>
</head>
<body>
<div class="out">
	<div id="myinfo">
	<img id="onimg" src="${pageContext.request.contextPath}/resources/image/chat/onlinelist.png">
	<div id="onlinelist">
	<div></div>
		<ul>
		</ul>
	</div>
	<c:if test="${member.profileimg==null}" > <%--프로필사진 없는 경우: 기본이미지 --%>
	  <img id="myprofile" src="${pageContext.request.contextPath}/resources/image/member/defaultprofile.png"><div id="myname">나</div><div id="myname2">${member.name}</div>
	</c:if>
	<c:if test="${member.profileimg!=null}" > <%--프로필사진 등록한 경우: 그 이미지 --%>
	  <img id="myprofile" src="${pageContext.request.contextPath}/resources/image/memberupload/${member.profileimg}"><div id="myname">나</div><div id="myname2">${member.name}</div>
	</c:if>
	</div>
<!-- onkeydown을 통해서 엔터키로도 입력되도록 설정. -->

<div class="main">
	<div id="messageWindow2"></div>
	
	<div id="bottombox">
	<input id="inputMessage" type="text" placeholder="메시지를 입력하세요"
			onkeydown="if(event.keyCode==13){send();}">
	<button type="button" value="send"><img src="${pageContext.request.contextPath}/resources/image/chat/sendicon.png"></button>
	</div>
	
</div>

</div><%-- end class="out" --%>

</body>
<script>
$("#onimg").click(function(){
	$("#onlinelist").slideToggle();
});

	//웹소켓 설정
	var webSocket = new WebSocket("ws://localhost:9696/gant/ChatServer");
	
	//같은 이가 여러번 보낼때 이름 판별할 변수
	re_send = "";
	let list = new Array();
	// OnOpen은 서버 측에서 클라이언트와 웹 소켓 연결이 되었을 때 호출되는 함수
	webSocket.onopen = function(event) {
		onOpen(event)
	};
	
	function onOpen(event) {
		//접속했을 때 접속자들에게 알릴 내용
		webSocket.send("${member.name} 님이 채팅방에 들어왔습니다.");
		//list.add()
	}
	
	// OnError는 웹 소켓이 에러가 나면 발생을 하는 함수.
	webSocket.onerror = function(event) {
		onError(event)
	};
	
	function onError(event) {
		alert("채팅 연결에 실패하였습니다. " + event.data);
	}
	
	// OnClose는 웹 소켓이 끊겼을 때 동작하는 함수.
	function onClose(event){
		webSocket.close();
	}
	
	// OnMessage는 클라이언트에서 서버 측으로 메시지를 보내면 호출되는 함수
	webSocket.onmessage = function(event) {
		onMessage(event)
	};
	//자기가 보낸 메시지는 자기한테 안옴(들어왔습니다.나갔습니다 제외)
	function onMessage(event) {
		
		//input을 통해 전달한 메시지가 아님(구분자 |\| 사용X)		
		if(event.data.split("|\|").length==1){
			$("#onlinelist>ul").empty();
			console.log(event.data);
			var alertDiv = event.data.split("[");
			console.log(alertDiv[0]+"/접속자명단:"+alertDiv[1]);
			let alertMessage = "<div class='alertMessage'>"+ alertDiv[0] + "</div>";
			$("#messageWindow2").append(alertMessage);
			re_send = "";
			let names = alertDiv[1].substring(0,alertDiv[1].length-1) //접속자 명단을 ,로 구분
			
			var namelist = names.split(", ");
			console.log(namelist[0]+"두번쨰:"+namelist[1]);
			if(namelist.length>0){
				
				$('#onlinelist > div').text(namelist.length +" 명");
				for(var i=0;i<namelist.length;i++){
					let plusli = "<li><img src='${pageContext.request.contextPath}/resources/image/member/people.png'>"+namelist[i]+"</li>";
					$("#onlinelist>ul").append(plusli);
				}
			}else{
				$('#onlinelist > div').text(namelist.length +" 명");
			}
			
		}else{ //입력한 메시지가 온 경우
			//클라이언트에서 날아온 메시지를 (구분) 단위로 분리한다
			var rmessage = event.data.split("|\|");
			//[0]은 프로필사진, [1]은 이름, [2]는 내용, [3]은 시간
			let receiveDiv = "";
		if(re_send==rmessage[1]){ //방금 메시지보낸사람이 또 보낸 경우
			receiveReDiv = "<div class='clear' style='clear:both'></div>"
						 + "<div class='receiveRemessage'>"+rmessage[2]+"</div>" //메시지 내용
					     + "<span class='receiveRetime'>" + rmessage[3] + "</span>"; //시간
			$('.receive:eq(-1)').append(receiveReDiv);
		}else{
			
		receiveDiv += "<div class='receive'>"
					+		"<img src=";
					if(rmessage[0]==''){
						receiveDiv += "'${pageContext.request.contextPath}/resources/image/member/defaultprofile.png'";
					}else{
						receiveDiv += "'${pageContext.request.contextPath}/resources/image/memberupload/"+rmessage[0]+"''";
					}
		receiveDiv += 			" class='profile'>" //프로필 사진(없으면 기본사진,있으면 그사진)
					+ 		"<div class='receivemessage'>"+rmessage[2]+"</div>" //메시지 내용
					+       "<span class='receivetime'>" + rmessage[3] + "</span>" //시간
					+ 		"<span class='username'>"+ rmessage[1] + "</span>" //이름
					+ "</div>"; //receive end
		
		//receive div는 받는 메시지 출력할 공간
		$('#messageWindow2').append(receiveDiv);
		
		//clear div 추가. 줄바꿈용.		
		let clear = "<div class='clear' style='clear:both'></div>";
		$('#messageWindow2').append(clear);
		}
		
		re_send = rmessage[1];	
		}
		//div 스크롤 아래로
		$("#messageWindow2").scrollTop($("#messageWindow2")[0].scrollHeight);
		
		$('.receive').each(function(){ //또 보내는 메시지: 똑같은날짜일 경우 맨아래 메시지만 날짜출력
			if($(this).find('.receivetime').text()==$(this).find('.receiveRetime:eq(0)').text()){
				$(this).find('.receivetime').text('');
			}
			$(this).find('.receiveRetime').each(function(index,item){
				if($(this).text()==$(this).next().next().next().text()){
					$(this).text('');
				}
			});
		});
		
	}//onMessage end


	function send() {
		
		//inputMessage가 있을때만 전송가능
		if($('#inputMessage').val()!=""){
			var now = new Date();	// 현재 날짜 및 시간
			var hour = ('0' + now.getHours()).slice(-2);
		    var minutes = ('0' + now.getMinutes()).slice(-2);
		    var time = hour+":"+minutes;

		    //	서버에 보낼때 날아가는 값.
			webSocket.send("${member.profileimg}|\|${member.name}|\|" + $('#inputMessage').val() + "|\|" + time);
			console.log("send:${member.profileimg}|\|${member.name}|\|" + $('#inputMessage').val());
			// 채팅화면 div에 붙일 내용
			let sendmessage = "<div class='sendmessage'>"+$("#inputMessage").val()+"</div>"
						    + "<span class='sendtime'>"+time+"</span>" ;
			$('#messageWindow2').append(sendmessage);

			let clear = "<div class='clear' style='clear:both'></div>";
			$('#messageWindow2').append(clear);
			
			//	inputMessage의 value값을 지운다.
			$("#inputMessage").val('');

			//	textarea의 스크롤을 맨 밑으로 내린다.
			//messageWindow2.scrollTop = messageWindow2.scrollHeight;
			$('#messageWindow2').scrollTop($('#messageWindow2')[0].scrollHeight);
			
			re_send = "${member.name}"
			
			$('.sendmessage').each(function(){ //연속으로 보낸 경우 3번 옆은 똑같이 .message임.
				if($(this).attr('class')==$(this).next().next().next().attr('class')){
					$(this).parent().find('.sendtime').each(function(index,item){
						if($(this).text()==$(this).next().next().next().text()){
							$(this).text('');
						}
					});
				}
			});//sendmessage.each end
		}//inputMessage가 있을때만 전송가능 끝.

	}
		// send 함수를 통해 웹소켓으로 메시지를 보낸다.
		$('button').click(function(){
			send();
		});
		
</script>
</html>