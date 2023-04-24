<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="../resources/css/home/home.css" rel="stylesheet">
<meta charset="UTF-8">
<title>GANT</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Lato&display=swap');
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}

aside {
    width: 30%;
    height: 42.8%;
    display: inline-block;
    position: absolute;
    left: 5%;
    top: 22.8%;
}

#searchdiv{ margin-bottom:80px; height:44px; position:relative; top:30px; float:right;
			vertical-align:middle;  }
#searchfield{height:40px; padding:0px 30px 0px 15px;
			 position:relative; left:7px; width:120px;
			 border:1px solid #C4C5C8; background-color:white;
			 top:-0.35px;
		-webkit-appearance:none; /* for chrome */
   		 -moz-appearance:none; /*for firefox*/
   		 appearance:none;
    		background:url('../resources/image/member/arrow.png') no-repeat 85% 50%/15px auto;
			}
option{background:white;}
#searchfield::-ms-expand{
   display:none;/*for IE10,11*/
}			
#searchword{height:40px; padding:0px 10px; width:300px;
			 position:relative; left:7px;
			 border:1px solid #C4C5C8;
			 top:0px;
			 }
#searchfield:focus, #searchword:focus {border:2px solid #26abff; outline:none }
#searchbtn{width:40px;height:40px; background:#26abff; border:1px solid #26abff; outline:none; 
margin:0; padding:0; position:relative; top:1.5px; color:white; font-size:21px; border-radius:0px .3em .3em 0px;}

#searchicon{width:23px; height:23px}
.list{width: 54.5%; position:absolute; right: 5%; top: 13%; display:inline-block}
.explain img {width:17px; height:17px;margin-bottom:4px}
.explain {position: absolute; top: 14.2%; padding: 10px 10px 0px 0px;}
.addbook{
    width: 100%; border-collapse: collapse; 
    text-align:left; 
    margin-bottom:20px;
    border-collapse: collapse;
}
.addbook>thead>tr{ border-bottom: 1px solid #26abff;}
.addbook>tbody>tr:nth-child(1){border-top:1px solid #26abff}
.addbook>tbody>tr{border-bottom: 1px solid #ced4da;}
.addbook>tbody>tr>td{padding:10px 10px 10px 20px; color:black}
.addbook>thead>tr>th{background: #26abff; color: #fff;padding:10px 10px 10px 20px}
.addbook>thead>tr>th:nth-child(1){width:30%; border-radius:.4em 0px 0px 0px}
.addbook>thead>tr>th:nth-child(2){width:28%}
.addbook>thead>tr>th:nth-child(3){width:42%; border-right:none;}
.addbook>thead>tr>th:last-child{border-radius:0px .4em 0px 0px}

.addbook>thead>tr>th:nth-child(4){padding:0px; text-align:center;border-left:none}
.delete{outline:none; border:none; background:#dc3545; 
		color:white; font-weight:bold; 
		border-radius:4px}
		
.delete:hover{background:#BD2130}
.addbook>tbody>tr>td:nth-child(4){text-align:center;padding:5px 10px 5px 5px; border-left:none}
.addbook>tbody>tr>td:nth-child(3){border-right:none}

.addbook tr {height:55px}
.addbook>tbody>tr>td:first-child>img{width:17px; height:17px; margin-right:3px; position:relative; bottom:2px;}
.godetail{color:black}
.godetail:hover{color:black; text-docoration:underline}
.godetail:focus{outline:none}
#detailForm{padding:20px 15px 0px 15px; height:400px}



h1 {
  font-size: 2rem;
  text-align:center;
  margin-top:150px;
}
.noresult{width:100%; height:384px; margin-top:125px; border:1px solid #ced4da}
.noresult > h2 {margin-top:19%; font-weight:normal; text-align:center}
</style>
<script>

$(document).ready(function(){
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	if(!'${id}'){
		alert('로그인 후 이용해주세요'); 
		location.href='login';
		
	}
	let selval = '${searchfield}';
	if(selval != ""){
		$("#searchfield").val(selval);
	}else{
		selval=0; //선택된 필드X
	}
	if($('.noresult').length==1){
		$('.explain').css('display','none');	
	}
	
	$('.addbook>tbody>tr').each(function(index,item){
		let id = $(this).find('input[type=hidden]').val(); //출퇴근 체크할 아이디
		ajax(id, $(this).find('a'));
		
		function ajax(id, where){
			
		  $.ajax({
			url : "commuteCheck",
			type : "post",
			data : { "id" : id},
			dataType : "json",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
			success : function(rdata){
				let check = rdata.check;
				if(check=="true"){
					where.before("<img src='${pageContext.request.contextPath}/resources/image/member/greencircle.png' title='출근상태'>"); //where은 이미지삽입되는 뒤 형제요소
				}else{
					where.before("<img src='${pageContext.request.contextPath}/resources/image/member/redcircle.png' title='퇴근상태'>");
				}
			}
		  });
		}
	});
	
	//모달
	$('.godetail').click(function(){
		let clickid = $(this).find('input[type=hidden]').val();
		$.ajax({
			url : "detail",
			type : "post",
			data : {"clickid" : clickid },
			dataType : "json",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
			success : function(data){
				if(data.profileimg==null){
					$("#profileimg").attr('src','${pageContext.request.contextPath}/resources/image/member/defaultprofile.png');
				}else{
					$("#profileimg").attr('src','${pageContext.request.contextPath}/resources/image/memberupload/'+data.profileimg);
				}

				$("#name").text(data.name);
				$("#department").text(data.department);
				
				$("#position").text(data.position);
				$("#birth").text(data.birth);
				$("#phone").text(data.phone_num);
				$('#email').text(data.email);
				$("#address").text(data.address);
			}
			
		});
	});
	
	$('.delete').click(function(){
		let del = prompt("정말로 해당 회원을 삭제하려면\n'삭제' 를 입력하세요.");
		if(del=='삭제'){
			let id = $(this).parent().parent().find('input[type=hidden]').val();
			location.href="delete?listid="+id;
		}
	});
	
	let dresult = "${message}";
	if(dresult){
		alert(dresult);
	}
});


</script>
</head>
<body>
<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">

<aside>
<jsp:include page="orgchart.jsp"/>
</aside>

<div class="list">
<form action="list" method="post">

<div id="searchdiv">
<select id="searchfield" name="searchfield">
	<option value="name" selected>이름</option>
	<option value="department">부서명</option>
	<option value="phone_num">휴대폰</option>
</select>
<input type="text" name="searchword" id="searchword" value="${searchword}">
<button type="submit" id="searchbtn">🔍︎</button>
<!-- <img id="searchicon" src="member/image/searchicon.png"> -->
</div>
<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>

<div class='explain'>
	<img src='${pageContext.request.contextPath}/resources/image/member/greencircle.png'> 출근
	<img src='${pageContext.request.contextPath}/resources/image/member/redcircle.png'> 퇴근
</div>

<c:if test="${membercount > 0}">
<table class="addbook">
	<thead>
		<tr>
			<th>이름</th>
			<th>부서명</th>
			<th>휴대폰</th>
			<c:if test="${isadminhuman=='true'}">
			  <th></th>
			</c:if>
		</tr>
	</thead>
	<tbody>
	   <c:forEach var="m" items="${memberlist}">
		<tr>
			<td><a class="godetail" data-toggle="modal" href="#detailmodal" data-backdrop="static"><input type="hidden" name="listid" value="${m.id}">
				${m.name}</a></td>
			<td>${m.department}</td>
			<td>${m.phone_num}</td>
			<c:if test="${isadminhuman==true}">
			  <td><button class="delete" type="button">X</button></td>
			</c:if>
		</tr>
		</c:forEach>
	</tbody>
</table>

<style>
#detailmodal{margin-top:90px}
.modal-body{height:425px}
#profileimg {width:100px; height:100px; float:left; border-radius:50%;
		 border:1px solid #C4C5C8;margin:0px 20px 20px 5px}
.infodiv {padding: 0px 5px 0px 5px; text-align:left; line-height:25px; height:25px}
#profileimg + div {width:400px; margin-top:13px}
b{margin:0px 10px 0px 5px; color:black}
#profileimg + div + div{margin-top:5px}
hr{margin:10px;}
#line1,#line2 {width:300px; position:relative; left:120px}
#line1 + div > b:last-child{position:relative; left:190px}
#line2 + div {clear:both}
.infodiv span{color:black}
#name {margin-left:30px;}
#department {margin-left:14px; margin-right:28px}
#position{margin-left:25px}
#birth{margin-left:30px}
#phone{margin-left:46px}
#email{margin-left:46px}
#address{margin-left:60px}
#close{height:50px; width:100px;display:block; 
	  font-weight:bold; margin:0 auto; opacity:1;
      border-radius:4px;height:50px; font-size:16px;
      background-color:#009CFF; color:white; border:none;
      outline:none; margin-top:23px}
#close:hover{background:#26abff;}
</style>

<%--모달 창 --%>
<div class="modal" id="detailmodal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		  		<form name="detailForm" id="detailForm">
		  		<img src="" id="profileimg">
		  		<div class="infodiv">
		  		<b>이름</b><span id="name"></span>
		  		</div><hr id="line1">
		  		
		  		<div class="infodiv">
		  		<b>부서명</b><span id="department"></span>
		  		<b>직급</b><span id="position"></span>
		  		</div><hr id="line2">
		  		
		  		<div class="infodiv">
		  		<b>생년월일</b><span id="birth"></span>
		  		</div><hr>
		  		
		  		<div class="infodiv">
		  		<b>휴대폰</b><span id="phone"></span>
		  		</div><hr>
		  		
		  		<div class="infodiv">
		  		<b>이메일</b><span id="email"></span>
		  		</div><hr>
		  		
		  		<div class="infodiv">
		  		<b>주소</b><span id="address"></span>
		  		</div><hr>
		  		
		  		<button type="button" id="close" data-dismiss="modal">창 닫기</button>
		  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  		</form>
		  	</div>
		  </div>
		</div>
	</div>
	<%--모달 끝 --%>
<style>
a.page-link{font-family: 'Lato', sans-serif}
.pagination{ margin-top:40px}
.page-link {border:none; color:#26abff; margin:0px 12px 0px 12px !important; padding:0px; 
height:25px; font-size:16px}
.page-link:focus{box-shadow: none; color:#009CFF}
.page-link:hover{background-color:white;color:#009CFF !important;}
.page-item.active .page-link {
    color: #009CFF;
    background-color: white;
  	border-bottom:2px solid #009CFF;
}
.page-item:hover
.first {margin:0px 12px 0px 0px !important;}
.back {margin:0px 22px 0px 0px !important;}
.next {margin:0px 0px 0px 22px !important;}
.last {margin:0px 0px 0px 12px !important;}
</style>
<div>
	<ul class="listpage pagination justify-content-center">
	  <%-- 1페이지이전: 작동X, 안보임 --%>
	  <c:if test="${page<=1}">
	    <li class="paga-item" style="display:none">
	      <a class="page-link">&lt;&lt;&nbsp;</a>
	    </li>
	    <li class="paga-item" style="display:none">
	      <a class="page-link">&lt;&nbsp;</a>
	    </li>
	  </c:if>
	  
	  <%-- 1페이지이상: 이전버튼 누르면 page-1값, 검색필드, 검색어 list.net으로 보냈다 다시옴 --%>
	  <c:if test="${page>1}">
	    <c:url var="first" value="list">
	    	<c:param name="searchfield" value="${searchfield}"/>
	    	<c:param name="searchword" value="${searchword}"/>
	    	<c:param name="page" value="${1}"/>
	    </c:url>
	    
	   	<c:url var="back" value="list">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${page-1}"/>
	    </c:url>
	    <li class="paga-item">
	    	 <a href="${first}" class="page-link first">&lt;&lt;</a>&nbsp;
	    </li>
	    
	    <li class="paga-item">
	         <a href="${back}" class="page-link back">&lt;</a>&nbsp;
	    </li>
	  </c:if>
	  
	  <%-- 1번부터 끝번호까지 페이지번호 매김--%>
	  <c:forEach var="i" begin="${startpage}" end="${endpage}" step="1">
	    <%--현재 페이지는 색깔다르고, 이동없음 --%>
	    <c:if test="${i == page}">
	      <li class="page-item active">
	        <a class="page-link">${i}</a>
	      </li>
	    </c:if>
	    <%--다른 페이지는 누르면 검색필드,검색어,페이지들고 list.net갔다온다 --%>
	    <c:if test="${i != page}">
	      <c:url var="move" value="list">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${i}"/>
	      </c:url>
	      <li class="paga-item">
	        <a href="${move}" class="page-link">${i}</a>
	      </li> 
	      </c:if>
	  </c:forEach>
	    
	    <%--현재 페이지가 최대페이지거나 이상 : 작동X, 안보임 --%>  
	    <c:if test="${page >= maxpage}">
	      <li class="page-item" style="display:none">
	      	<a class="page-link">&nbsp;&gt;</a>
	      </li>
	      <li class="page-item" style="display:none">
	      	<a class="page-link">&nbsp;&gt;</a>
	      </li>
	    </c:if>
	    
	    <%--최대페이지미만: 다음 버튼누르면 page+1값, 검색필드, 검색어 들고 list.net 갔다옴 --%>
	    <c:if test="${page < maxpage}">
	      <c:url var="last" value="list">
	      	<c:param name="searchfield" value="${searchfield}"/>
	      	<c:param name="searchword" value="${searchword}"/>
	      	<c:param name="page" value="${maxpage}"/>
	      </c:url>
	      
	      <c:url var="next" value="list">
	        <c:param name="searchfield" value="${searchfield}"/>
	        <c:param name="searchword" value="${searchword}"/>
	        <c:param name="page" value="${page+1}"/>
	      </c:url>
	      <li class="page-item">
	        <a href="${next}" class="page-link next">&nbsp;&gt;</a>
	      </li>
	      <li class="page-item">
	        <a href="${last}" class="page-link last">&nbsp;&gt;&gt;</a>
	      </li>
	    </c:if> <%--회원있는경우 끝 --%>
	   </ul>
    </div>
    </c:if>
    
    <c:if test="${membercount==0 && empty searchword}">
    <script>
    $('.explain').attr('display','none');
    </script>
    <div class="noresult">
      <h1>회원이 존재하지 않습니다.</h1>
    </div>
    </c:if>
    
    <c:if test="${membercount==0 && !empty searchword}">
    <script>
    $('.explain').attr('display','none');
    </script>
	<div class="noresult">
      <h2>검색된 회원은 존재하지 않습니다.</h2>
	</div>
    </c:if>  
	</div><%--list end --%>
</div>
</div> <!-- class content -->

<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>

</body>
</html>