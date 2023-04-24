<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>Insert title here</title>
<style>
*{font-family:"noto sans", sans-serif;}
.memo {
		background-size: 100% 100%;
		width: 450px;
		height: 480px;
		position:fixed;
		z-index:2000;
		left: 320px;
  		top: 140px;
}

.memolist{
	background-size: 100% 100%;
		width: 450px;
		height: 480px;
		position:fixed;
		z-index:2000;
		left: 320px;
  		top: 140px;
}
.select_del {
    width: 25px;
    height: 25px;
    position: absolute;
    right: 2px;
    top: -2px;
    display:none;
}
.btnChange {
    width: 200px;
    height: 30px;
    float: left;
    margin-left:23px;
    margin-top:21px;
    
}

.btnChange > img {
	width: 35px;
	height: 35px;
	cursor: pointer;
}
.back_colors {
	margin-left:10px;
	display:none;
}

.back_colors > img {
	width:18px;
	height:18px;
	border: 1px solid black;
	cursor:pointer;
}

.pen_colors {
    position: relative;
    top: 20px;
    left: 9px;
}

.pen_colors > img {
    width: 30px;
    height: 30px;
    cursor: pointer;
}

.backtolist {
	position: relative;
	top: 21px;
	left: 21px;
}
.backtolist > img {
	width: 25px;
	height: 25px;
	cursor: pointer;
}
.memo_store {
    width: 50px;
    float: right;
    margin-right: 20px;
    margin-top: 19px;
    outline: none;
    background: black;
    height: 33px;
    color: white;
    border-radius:3px;
}
.memo .btnClose {
    width: 10px;
    cursor: pointer;
    float: right;
    margin-right: 40px;
    font-size: 40px;
    color: black;
}
.memo_top {
    width: 100%;
    height: 75px;
}

	.memo_subject{
		width:360px;
		margin-left:35px;
		height:29px;
		resize: none;
  	 	 border: 0;
    	outline: none;
   		 background-color: transparent;
   		 font-weight: bold;
    	font-size: 16px;
	}

	.memo .txtMemo {
		margin-left: 35px;
		margin-top: 4px;
		width: 360px;
		height: 320px;
		resize: none;
		border: 0;
		outline: none;
		background-color: transparent;
		font-weight:bold;
		font-size:16px;
	}
.memo_subject::placeholder {color:black; font-weight:normal}
.txtMemo::placeholder { color:black;font-weight:normal}
	
	.memo .txtMemo::-webkit-scrollbar {
    	width: 5px;
  	}
  	.memo .txtMemo::-webkit-scrollbar-thumb {
 	 }
  	..memo .txtMemo::-webkit-scrollbar-track {
  	}
  	
  	.memo{display:none}
  	
.memolist{font-family:"noto sans", sans-serif;}
.memohead{width:100%;height:60px;}

.memolist{
	background-size: 100% 100%;
	width: 590px !important;
	height: 480px !important;
	position:fixed;
	z-index:2000;
	left: 320px;
  	top: 140px;
  	background:#fbfbfb;
  	border-radius: 30px;
  	color:black;
  	border:3px solid #009CFF;
}

.postmain {
    width: 100%;
    height: 430px;
    padding: 10px 30px 20px 30px;
    box-sizing: border-box;
}
.postitlist {
    width: 100%;
    height: 290px;
    background: white !important;
}
	
	.postitlist{
	overflow-y:scroll
	}
	
	.postitlist::-webkit-scrollbar {
    	width: 2px !important;
  	}
  	
 .postitlist::-webkit-scrollbar-thumb {
    height: 30% !important; /* 스크롤바의 길이 */
    background: transparent !important; /* 스크롤바의 색상 */
    
    border-radius: 10px !important;
}	 

  	
  	
.postits{
	float:left;
	background-size:100% 100%;
	width:150px;
	height:80px;
	margin:11px;
	line-height:80px;
	text-align:center;
	position:relative;
	cursor:pointer;
	
}

.memolist_subject{
	font-size:14px;
	font-weight:bold;
}
.memolist .closebtn {
    width: 10px;
    cursor: pointer;
    float: right;
    margin-right: 35px;
    font-size: 35px;
    color: black;
    
}


.closebtn + img {
    width: 30px;
    float: right;
    margin-right: 35px;
    margin-top: 15px;
    outline: none;
    height: 30px;
    cursor:pointer;
}
#memotitle{
	margin-top:21px; margin-left:35px;
	display:inline-block;
	font-size:19px;
	font-weight:bold
}

#creatememo {
    width: 60px;
    height: 60px;
    margin-left: 88%;
    margin-top: 5%;
    cursor:pointer;
}
.memolist{display:none; z-index:10000}

#mask {
position:absolute;
z-index:9000;
 display:none;
 left:0;
 top:0;
}

</style>
<script>
$(document).ready(function(){
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
		
	$('.closebtn').click(function(){ //메모장목록 닫기 클릭
		$('.memolist').css('display','none');
		$("#mask").css('display','none');
	});
	
	$('.openmemo').click(function(e){ //메모장 열기 클릭
	    e.preventDefault();
		
	  	if($(".memo").css('display')=='none'){ //메모장작성화면도 닫힌상태여야함
	  		
	  	//열려있는 상태에서 또 열면 입력된 데이터가 삭제되고 다시 저장되어 있던 데이터가 불러와짐 방지
		if($('.memolist').css('display')=='none'){
			//열려지면서 ajax로 데이터 받아옴
			$('.postitlist').empty();
			$('.memolist').css('display','block');
			let id = $(".side_userid").text();
			loadAjax(id);
		}//if
	  	}//if
	});//메모장열기끝
	
	function loadAjax(id){
		focusMemolist();
		$.ajax({
			url : "${pageContext.request.contextPath}/small/memolist",
			type : "post",
			data : { "id" : id},
			dataType : "json",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(Ldata){
    			$(Ldata).each(function(){ //list안에 각각 Memo객체를 뽑아내는 과정
    				console.log("메모장리스트:"+this.num + this.subject + this.background);
    				let output = '<div class="postits" style="';
    				   output += "background-image:url('"
    						   + "${pageContext.request.contextPath}/resources/image/memo/postit-"
    						   + this.background.substring(5)//뒤에 yellow,blue 등 색상만 뽑아내는 과정
    						   + "')"
    						   + '"><img src="${pageContext.request.contextPath}/resources/image/memo/memo_closeicon.png" class="select_del"><span class="memolist_subject">'
    						   + this.subject
    						   + "</span><input type='hidden' value='"+ this.num +"'></div>";
    				$('.postitlist').append(output);
    			});
    		}//success
		});//ajax*/
	}//function
	
		$("body").on('click','.postits',function() { //클릭한 메모장 내용 불러오는 코드
		console.log("클릭");
		let num = $(this).find('input[type=hidden]').val();
		$("#mask").css('display','none');
		$.ajax({
			url : "${pageContext.request.contextPath}/small/loadmemo",
			type : "post",
			dataType : "json",
			data : { "num" : num},
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(Ldata){
    			console.log("Ldata:"+Ldata+"Ldata.num:"+Ldata.num);
    			$(".memolist").css('display','none');
    			$("#memo_num").val(Ldata.num);
    			$(".memo_subject").val(Ldata.subject);
    			$(".txtMemo").val(Ldata.content);
    			$('.memo').css('background-image',"url('${pageContext.request.contextPath}/resources/image/memo/"+ Ldata.background +"')");
    			$('.txtMemo').css('color',Ldata.color);
    			$('.memo_subject').css('color',Ldata.color);
    			if(Ldata.color=='rgb(0, 0, 0)'){ //글자가 검은색이면 이미지는 흰색
    				$('.pen_colors > img').attr('src','${pageContext.request.contextPath}/image/memo/color-white.png');
    			}else if(Ldata.color=='rgb(255, 255, 255)'){//글자가 흰색이면 이미지는 검은색
    				$('.pen_colors > img').attr('src','${pageContext.request.contextPath}/image/memo/color-black.png');
    			}
    			storedSubject=Ldata.subject;
    			storedText=Ldata.content;
    			storedBack =Ldata.background;
    			storedColor = Ldata.color;
    			
    			$(".memo").css('display','block');
    		}
			
		});//ajax
		});//click
		
	$("#creatememo").click(function(){ //생성클릭했을 때 기본 노란배경,검은색글자, 내용,제목 없음 글번호 : -1
		$(".memolist").css('display','none');
		$("#mask").css('display','none');
		$("#memo_num").val('-1');
		$(".memo_subject").val('');
		$(".txtMemo").val('');
		$('.memo').css('background-image',"url('${pageContext.request.contextPath}/resources/image/memo/memo-yellow.png')");
		$('.txtMemo').css('color','black');
		$('.memo_subject').css('color','black');
		$('.pen_colors > img').attr('src','${pageContext.request.contextPath}/image/memo/color-white.png');
		storedSubject="";
		storedText="";
		storedBack = "memo-yellow.png";
		storedColor = 'rgb(0, 0, 0)';
		$(".memo").css('display','block');
	});
	
	
	$("#memo_deleteicon").click(function(){ //삭제아이콘 클릭 시 각 메모장 사이드에 삭제버튼 생성
		$(".select_del").toggle();
	});//click 휴지통아이콘
	
	$("body").on('click','.select_del',function(event){
		event.stopPropagation();
		console.log($(this).next().next().val());
		let num = $(this).next().next().val();
		let id = $(".side_userid").text();
			
		if(confirm("정말로 삭제하시겠습니까?")){
			
		$.ajax({
			url : "${pageContext.request.contextPath}/small/deletememo",
			type : "post",
			dataType : "json",
			data : { "num" : num},
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(Ddata){
    			if(Ddata==1){
    				alert("삭제를 완료했습니다.");
    				$('.postitlist').empty();
    				loadAjax(id);
    			}else{
    				alert("삭제를 실패하였습니다.");
    			}
    		}
			
		});//ajax
		}
	});//click X아이콘
		
	$('.btnChange > img').click(function(){ //배경색 이미지목록을 열고 닫음
		$('.back_colors').toggle();
	});
	
	$('.back_colors>img').click(function(){ //배경색 클릭하면 그색으로 바뀜
		memoBackground = $(this).attr('src');
		$('.memo').css('background-image',"url('"+ memoBackground + "')");
		$('.back_colors').css('display','none');
	});
	
	$('.pen_colors > img').click(function(){  //연필모양클릭하면 그색으로 바뀜
		console.log($('.txtMemo').css('color'));
		if($('.txtMemo').css('color')=='rgb(0, 0, 0)'){ //검은색일때 클릭하면, 흰색으로 바뀌고->겅믄색그림색그림
			$('.txtMemo').css('color','white');
			$('.memo_subject').css('color','white');
			$(this).attr('src','${pageContext.request.contextPath}/image/memo/color-black.png');
		}else if($('.txtMemo').css('color')=='rgb(255, 255, 255)'){//흰색일 때 클릭하면, 검은색으로 바뀌고->흰색 그림
			$('.txtMemo').css('color','black');
			$('.memo_subject').css('color','black');
			$(this).attr('src','${pageContext.request.contextPath}/image/memo/color-white.png');
		}
	});
	
		$('.btnClose').click(function(){ //메모장 종료
			let length = $('.memo').css('background-image').length;
			var s_back = $('.memo').css('background-image').split("/");
			var back = s_back[s_back.length-1].slice(0,-2);
			if(storedSubject!=$('.memo_subject').val() || storedText!=$('.txtMemo').val() || storedBack!=back || storedColor!=$('.txtMemo').css('color')){
				var close = confirm("데이터 변경 후 저장되지 않았습니다.\n정말 종료하시겠습니까?");
				
				if(close) { //확인
					$('.memo').css('display','none');
				}
			}else{
				$('.memo').css('display','none');
			}
		});
		
		$(".backtolist > img").click(function(){
			let length = $('.memo').css('background-image').length;
			var s_back = $('.memo').css('background-image').split("/");
			var back = s_back[s_back.length-1].slice(0,-2);
			if(storedSubject!=$('.memo_subject').val() || storedText!=$('.txtMemo').val() || storedBack!=back || storedColor!=$('.txtMemo').css('color')){
				var close = confirm("아직 저장되지 않았습니다. \n 정말 뒤로 가시겠습니까?");
				
				if(close) { //확인
					$('.memo').css('display','none');
					$('.postitlist').empty();
					$('.memolist').css('display','block');
					let id = $(".side_userid").text();
					loadAjax(id);
					
				}
			}else{
				$('.memo').css('display','none');
				$('.postitlist').empty();
				$('.memolist').css('display','block');
				let id = $(".side_userid").text();
				loadAjax(id);
			}	
		});
		
		$('.memo_store').click(function(){ //메모장 저장
			let num = $("#memo_num").val();
			let id = $(".side_userid").text();
			let length = $('.memo').css('background-image').length;
			console.log($('.memo').css('background-image'));
			var s_back = $('.memo').css('background-image').split("/");
			var back = s_back[s_back.length-1].slice(0,-2);
			
			let background = back; //배경색이미지값만 추출
			let	color = $('.txtMemo').css('color');
			let subject = $('.memo_subject').val();
			let content = $('.txtMemo').val();
			if(subject=="" || content==""){ //값이 비어있을 때
				alert("제목 또는 내용을 입력 후 저장하세요");
			}else{
				
			
			$.ajax({
				url : '${pageContext.request.contextPath}/small/update_insertmemo',
				type : "post",
				data : {"num" : num, "id" : id, "background" : background, "color":color, "subject" : subject, "content":content},
				dataType : "json",
				beforeSend : function(xhr)
				{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},
				success : function(rdata){
					if(rdata.insert_num!=null){ //
						console.log(rdata.insert_num);
						$("#memo_num").val(rdata.insert_num);
					}
					if(rdata.result == 1){
						alert("저장되었습니다.");
						//메모장 종료할 때 값변경되었는지 확인하기 위해
						storedSubject = subject;
						storedText = content; 
						storedBack = background;
						storedColor = color;
						console.log("저장할때="+storedBack+storedColor)
					}else{
						alert("저장 실패입니다.");
					}
				}
			})//ajax	
			}//값이 있을 때 else문
			
		})//저장클릭
		
		function focusMemolist(){
			var height = $(window).height();
			var width = $(window).width();
			
			$("#mask").css({'width':width,'height':height});
			$("#mask").css('display','block');
			$("#mask").css('background','linear-gradient( rgba(0, 0, 0, 0.3), rgba(0, 0, 0, 0.3) ),url("'+window.location.href+'")');
		}
});
</script>
</head>
<body>
<div id="mask"></div>
<div class="memolist">
	<div class="memohead">
	<span id="memotitle">메모장</span>
	<div class="closebtn">&times;</div>
	<img id="memo_deleteicon" src="${pageContext.request.contextPath}/resources/image/memo/deleteicon.png">
	</div>

	<div class="postmain">
	
	<div class="postitlist">
	</div>
	
	<img id="creatememo" src="${pageContext.request.contextPath}/resources/image/memo/creatememo7.png">
	</div>
</div>

<!-- 메모작성 -->
<div class="memo" style="background-image:url('${pageContext.request.contextPath}/resources/image/memo/memo-yellow.png')">
	<div class="memo_top">
	<div class="btnChange"><img src='${pageContext.request.contextPath}/image/memo/change.png'>
		<span class='back_colors'>
		<img src="${pageContext.request.contextPath}/resources/image/memo/memo-red.png">
		<img src="${pageContext.request.contextPath}/resources/image/memo/memo-pink.png">
		<img src="${pageContext.request.contextPath}/resources/image/memo/memo-orange.png">
		<img src="${pageContext.request.contextPath}/resources/image/memo/memo-yellow.png">
		<img src="${pageContext.request.contextPath}/resources/image/memo/memo-green.png">
		<img src="${pageContext.request.contextPath}/resources/image/memo/memo-blue.png">
		</span>
	</div><input type="hidden" id="memo_num" value="">
	<span class="pen_colors">
		<img src="${pageContext.request.contextPath}/image/memo/color-white.png">
	</span>
	<span class="backtolist">
		<img src="${pageContext.request.contextPath}/image/memo/back.png">
	</span>
	<div class="btnClose">&times;</div>
	<button class="memo_store" type="button">저장</button>
	</div>
	<textarea class="memo_subject" placeholder="제목" maxlength="15"></textarea>
	<textarea class="txtMemo" placeholder="내용을 입력하세요 . . ."></textarea>
</div>
</body>
</html>