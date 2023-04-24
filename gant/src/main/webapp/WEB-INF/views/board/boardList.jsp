<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="${pageContext.request.contextPath}/resources/css/home/home.css" rel="stylesheet" type="text/css">
<link href="${pageContext.request.contextPath}/resources/css/board_css/main_bo.css" rel="stylesheet" type="text/css">
<script>
$(function(){
	
	$("#board_write").click(function(){
		location.href="write"; 
		 })
	 
});	

</script>
<title>자유/공지 게시판</title>
</head>
<body>

<jsp:include page="../home/side.jsp" />


<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">
<div class="container">

<style>
#th1{
border-top-left-radius:10px !important;
}
#th6{
border-top-right-radius:10px !important;
}
.table thead th {
    vertical-align: bottom;
    border-bottom: 0px ; 
}

tr{
   height:45px !important;  
}

.table td, .table th {
     border-top: 0px;
}

.center{
text-align: center;}

table{
text-align:left;
}
.table>:not(caption)>*>* {
 padding: 0; 
}

.table td, .table th {
    padding: 0.75rem;
}

#like{
width: 20px;
vertical-align: middle;
}

</style>
		        
<%-- 게시글이 있는경우 --%>
<c:if test="${listcount > 0 }">
 <div class="table-responsive">
  <table class="table">
  <thead>
    <tr>
     <th colspan="6" class="th1">
     
     <form action="main" method="get" id="search">
		   <div class="input-group mb-3">
		  <input type="text" class="form-control" name="search_name" placeholder="제목을 검색하세요">
		  <div class="input-group-append">
		   <button class="btn btn-dark" type="submit" id="search_btn">🔍︎</button> 
		  </div>
		</div>
		</form>
     </th>
   </tr>
   <tr>
     <th id="th1" class="th2 " ><div>&nbsp;번호</div></th>
     <th id="th2" class="th2"><div>&nbsp;&nbsp;제목</div></th>    
     <th id="th3" class="th2"><div>작성자</div></th>  
     <th id="th4" class="th2 center"><div>작성일</div></th>  
     <th id="th5" class="th2 center"><div>조회수</div></th>
     <th id="th6" class="th2 center"><div>좋아요</div></th>  
   </tr>
   </thead>
   <tbody>
    <%-- num은 번호를 나타낸다. 총갯수부터 글이 내려갈수록 1씩 내려간다. --%>
    <c:set var="num" value="${listcount-(page-1)*limit}" />
 
	   <%-- 게시물 --%>
	   <c:forEach var="b" items="${boardlist}"  varStatus="vs">     			      
		      <tr>
		       <td><%-- 번호 --%>
		         <%-- 공지게시글은 번호가 아닌 [공지] 표시를 한다. --%>
		         <c:if test="${b.board_notice == 'true'}">&nbsp;
		            <img src="${pageContext.request.contextPath}/resources/image/board_image/megaphone.png"  width="23px">  
		             <c:set var="num" value="${num-1}" /> <%-- num = num-1 의미 --%>
		         </c:if>
		         <%-- 일반게시물은 번호로 표시한다. --%>
		          <c:if test="${b.board_notice == 'false'}">
		            &nbsp;&nbsp;&nbsp;<c:out value="${num}" /> <%-- num 출력 --%>
		            <c:set var="num" value="${num-1}" /> <%-- num = num-1 의미 --%>
		         </c:if> 
		       </td>
		       <td><%--제목 --%>
		        <div>
		          <%-- 답변글 제목 앞에 여백처리부분 --%>
		         <c:if test="${b.board_re_lev != 0}"> <%-- 답글인경우 --%>
			           <c:forEach var="a" begin="0" end="${b.board_re_lev*2}" step="1">
			           &nbsp;
			           </c:forEach>
		           <img src="${pageContext.request.contextPath}/resources/image/board_image/arrows.png" width="15px"> 
		         </c:if>
		         
		         <c:if test="${b.board_re_lev == 0}"><%-- 원문인경우 --%>
		         &nbsp;		         
		         </c:if>
		       <%-- 비밀글 설정을 안하면 pass는 1이다. --%>
			         <c:if test="${b.board_pass == '1'}">
			         <a href="detail?board_num=${b.board_num}&board_pass=${b.board_pass}">
			          <c:if test="${b.board_subject.length()>= 18}">
			            <c:out value="${b.board_subject.substring(0,18)}..." />
			          </c:if>
			          <c:if test="${b.board_subject.length() < 18}">
			            <c:out value="${b.board_subject}" />
			          </c:if>
			         </a>[${b.cnt}]
			         </c:if>
			         <%-- 비밀글 설정을 하면 pass는 1이아니다. 이때는 모달을 이용하여 비밀번호를 확인한다. --%>
			         <c:if test="${b.board_pass != '1'}">
			         <a data-toggle="modal" data-target="#myModal${vs.index}"  style="cursor:pointer;">
			          <c:if test="${b.board_subject.length()>= 18}">
			            <c:out value="🔒${b.board_subject.substring(0,18)}..." />
			          </c:if>
			          <c:if test="${b.board_subject.length() < 18}">
			            <c:out value="🔒${b.board_subject}" />
			          </c:if>
			         </a>[${b.cnt}]		         
			         	<%-- modal 시작 --%>
			<div class="modal" id="myModal${vs.index}">
			   <div class="modal-dialog">
			      <div class="modal-content">
			         <%-- Modal body --%>
			         <div class="modal-body">
			            <form name="deleteForm" action="detail?board_num=${b.board_num}" method="post">
			               <input type="hidden" name="board_pass" value="${b.board_pass}">
			               <div class="form-group">
			                   <label for="pwd">비밀번호</label>
			                   <input type="password"
			                           class="form-control" placeholder=""
			                           name="input_pass">
			               </div>
			               <button type="submit" class="btn btn-primary">전송</button>
			               <button type="button" class="btn btn-primary"  data-dismiss="modal">닫기</button>
			               <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
			            </form>
			         </div>
			      </div>
			   </div>
			</div>
			<%-- id="myModal" end --%>	

			         </c:if>
		        </div>  
		       </td>
		       <td>${b.board_name}</td>
		       <td class="center">${b.board_date}</td>
		       <td class="center">${b.board_readcount}</td>
		       <td class="center img"><img src="${pageContext.request.contextPath}/resources/image/board_image/like.png" id="like">&nbsp;${b.board_like}</td>
		      </tr>
    </c:forEach>
    <%-- 시물  끝--%>
   </tbody>  
 </table>
</div> 
 <%--테이블 끝 --%>

<style>
.pagination{font-family: 'Lato', sans-serif; margin-top:40px}

.page-link {border:none; color:#777777; margin:0px 12px 0px 12px; padding:0px; 
height:25px; font-size:16px}
.page-link:focus{box-shadow: none;}
.page-link:hover{background-color:white;color:#777777;}
.page-item.active .page-link {
    color: #000;
    background-color: white;
     border-bottom:2px solid #000;
}
.first {margin:0px 12px 0px 0px;}
.back {margin:0px 22px 0px 0px;}
.next {margin:0px 0px 0px 22px;}
.last {margin:0px 0px 0px 12px;}
</style>
 
 <div>
	<ul class="pagination justify-content-center">
	  <%-- 1페이지이전: 작동X, 안보임 --%>
	  <c:if test="${page<=1}">
	    <li class="paga-item" style="display:none">
	      <a class="page-link">&lt;&lt;&nbsp;</a>
	    </li>
	    <li class="paga-item" style="display:none">
	      <a class="page-link">&lt;&nbsp;</a>
	    </li>
	  </c:if>
	  
	  <%-- 1페이지보다 크면: 이전버튼 누르면 page값 ,board/main으로 보냄 --%>
	  <c:if test="${page>1}">
	    <c:url var="first" value="main">
	    	<c:param name="page" value="${1}"/>
	    </c:url>
	    
	   	<c:url var="back" value="main">
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
	    
	    <%--다른 페이지는 누르면 검색필드,검색어,페이지들고 Main.bo갔다온다 --%>
	    <c:if test="${i != page}">
	      <c:url var="move" value="main">
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
	    
		    <%--최대페이지미만: 다음 버튼누르면 page+1값, 검색필드, 검색어 들고 Main.bo 갔다옴 --%>
		    <c:if test="${page < maxpage}">
		      <c:url var="last" value="main">
		      	<c:param name="page" value="${maxpage}"/>
		      </c:url>
		      
		      <c:url var="next" value="main">
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
</c:if> <%--  <c:if test="${listcount > 0}"> end --%>

<%-- 게시글이 없는경우 --%>
<c:if test="${listcount == 0}">
 <h3 style="text-align: center">등록된 글이 없습니다.</h3>
</c:if> 

		
          <div>
		<button type="button" class="btn btn-primary m-2 float-right" id="board_write">글쓰기</button>
		</div>
         
           </div><%--  class container end --%>
	</div> <%-- class row end --%>
  </div>  <!-- class content -->
  
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>




</body>
</html>