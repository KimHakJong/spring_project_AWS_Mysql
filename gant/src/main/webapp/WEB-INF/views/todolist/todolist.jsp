<%@page import="org.apache.catalina.filters.ExpiresFilter.XServletOutputStream"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import = "java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<%
	int p_no = (Integer)request.getAttribute("p_no");

	String status = (String)request.getAttribute("status");
	
	
	
	String p_name[] = null;
	String p_id[] = null;
			
	
	
	if(request.getAttribute("p_id") != null) {
		p_id = (String [])request.getAttribute("p_id");
	}
	
	if(request.getAttribute("p_name") != null) {
		p_name = (String [])request.getAttribute("p_name");
		
	}

	
%>
<!DOCTYPE html>
<html>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/todolist/list.js"></script>

<head>
<script>
	const result = "${result}";
	
	if(result == 'deleteSuccess'){
		alert("삭제 성공입니다");
	}
</script>


<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<meta charset="utf-8">

<style>
thead{
		 background-color:#4da7ed;
		 color: white;
}
.btn-check:checked+.btn-outline-primary, .btn-check:active+.btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show {
    color: white !important;
}
.form-control me-2{
margin-rigth: 0px;
}
label.btn.btn-outline-primary:hover {
    color: white;
}
#loginid{
	display: none;
}

.btn-primary{
float: right;}

.col{
	flex: 0.8 0 0 !important;
}

#search{
	border-top-left-radius: 0px !important;
	border-bottom-left-radius: 0px !important;
}
#search_word{
	border-top-right-radius: 0px !important;
	border-bottom-right-radius: 0px !important;
}



</style>

<title>할 일 리스트</title>
</head>
<body>



<jsp:include page="../home/side.jsp" />

<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

var s = "${status}";


$(document).ready(function(){
	
	if(s == 'r'){
		$('#option1').prop('checked', true);
	}
	else if(s =='s'){
		$('#option2').prop('checked', true);
	}
});

</script>


<div class="content">

	<jsp:include page="../home/header2.jsp" />

	<div class="container-fluid pt-4 px-4">		
    <div class="container">
    
    	<div class="btn-group" role="group">
	        <input type="radio" class="btn-check" name="btnradio" id="btnradio1">
	        <label class="btn btn-outline-primary" for="btnradio1" onclick="window.location.href='${pageContext.request.contextPath}/filebox/home?p_no=<%=p_no %>';" >파일 보관함</label>
	
	        <input type="radio" class="btn-check" name="btnradio" id="btnradio2" checked="checked">
	        <label class="btn btn-outline-primary" for="btnradio2">할일 리스트</label>
	
	        <input type="radio" class="btn-check" name="btnradio" id="btnradio3" >
	        <label class="btn btn-outline-primary" for="btnradio3" onclick="window.location.href='${pageContext.request.contextPath}/pcalendar/cal?p_no=<%=p_no %>';" >캘린더</label>
		</div>
		
    	<br><br>
    	
        <h1>To-Do List</h1>
        
        <div class="row mb-3">
		<div class="col">
			<div class="btn-group" role="group">
			
		        <input type="radio" class="btn-check" name="options" id="option1" autocomplete="off">
		        <label class="btn btn-outline-success" for="option1" onclick="window.location.href='${pageContext.request.contextPath}/todolist/receive?p_no=<%=p_no %>';">받은 할일</label>
		    
		    
		        <input type="radio" class="btn-check" name="options" id="option2" autocomplete="off" >
		        <label class="btn btn-outline-danger" for="option2" onclick="window.location.href='${pageContext.request.contextPath}/todolist/send?p_no=<%=p_no %>';">보낸 할일</label>
		    </div>
		  </div>
		

            <div class="col-auto">
            	<% if(status.equals("s")) {%>
	                <form class="d-flex" action="send" method="get">
	                	<input type="hidden" name="p_no" value="${p_no}">
	                	<input class="form-control" type="text" placeholder="검색 할 제목 입력" name="search_word" id="search_word" >
	                    <button class="btn btn-outline-success" type="submit" style="width: 75px;" id="search">검색</button>     
	                </form>
	            
	            
	            <% } else {%>
	            
	            	<form class="d-flex" action="receive" method="get">
	                	<input type="hidden" name="p_no" value="${p_no}">
	                	<input class="form-control" type="text" placeholder="검색 할 제목 입력" name="search_word" id="search_word" >
	                    <button class="btn btn-outline-success" type="submit" style="width: 75px;" id="search">검색</button>     
	                </form>
	            
	            <%} %>

            </div>
            <div class="col-auto">
				<button type="button"   class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/todolist/write?p_no=<%=p_no %>';" >할일 추가</button>
			</div>

        </div>
        
     	<c:if test="${listcount > 0}">
	
		<table class="table table-striped">
			<thead>
				<tr>
					<th colspan="3">할 일 리스트</th>
					<th colspan="2">
						<span>할 일 개수 : ${listcount }</span>
					</th>
				</tr>
				<tr>
					<th><div>번호</div></th>
					<th><div>제목</div></th>
					<th><div>보낸 사람</div></th>
					<th><div>기한</div></th>
					<th><div>상태</div></th>
	
				</tr>
			</thead>
			<tbody>
      <c:set var="num" value="${listcount-(page-1) * limit }"/>
      <c:forEach var="b" items="${todolist }">
      <tr>	
      <td><%--번호 --%>
         <c:out value="${num }"/><%-- num 출력 --%>
         <c:set var="num" value="${num-1 }"/> <%-- num= num-1의 의미 --%>
      </td>
      <td><%--제목 --%>
      <div>

         <%-- 1이면 send, 0이면 receive --%>
         <% if(status.equals("s")) {%>
         <a href="detail?num=${b.board_num }&s=1&p_no=<%=p_no %>">
         <% } else {%>
         	<a href="detail?num=${b.board_num }&s=0&p_no=<%=p_no %>">
		<% }%>
               <c:out value="${b.board_subject}" escapeXml="true"/> <!--  html태그를 화면에서 출력 -->
				
            </a>
         </div>
      </td>
      
      <td><div>${b.board_id }</div></td>
      <td><div>~${b.deadline }</div></td>

	<c:choose>
		<c:when test="${b.state eq 'false'}">
	 		<td>
		      완료 <i class="bi bi-stop-circle" style="color:#DC3545"></i>				
			</td>
		</c:when>
		<c:otherwise>
			<td>
		      진행중 <i class="bi bi-check-circle" style="color:#198754"></i>
			</td>
		</c:otherwise>
	 </c:choose>

      </tr>
      </c:forEach>
      </tbody>
		</table>
		
		<div class="center-block">
				
			<ul class="pagination justify-content-center">
				<c:if test="${page<=1}">
					<li class="page-item">
						<a class="page-link gray">이전&nbsp;</a>
					</li>
				</c:if>
				<c:if test="${page>1}">

					<% if(status.equals("s")) {%>
						<li class="page-item">
							<a href="send?p_no=${p_no}&page=${page-1}" class="page-link">이전&nbsp;</a>
						</li>
					<% } else {%>
					
					
						<li class="page-item">
							<a href="receive?p_no=${p_no}&page=${page-1}" class="page-link">이전&nbsp;</a>
						</li>
					<% }%>

				</c:if>
				
				<c:forEach var="a" begin="${startpage}" end="${endpage}">
					<c:if test="${a==page }">
						<li class="page-item active">
							<a class="page-link">${a}</a>
						</li>
					</c:if>
					<c:if test="${a!=page }">
					
						<% if(status.equals("s")) {%>
							<li class="page-item">
								<a href="send?p_no=${p_no}&page=${a}" class="page-link">${a}</a>
							</li>
						<% } else {%>

							<li class="page-item">
								<a href="receive?p_no=${p_no}&page=${a}" class="page-link">${a}</a>
							</li>
						<% }%>

					</c:if>
				</c:forEach>
				
				<c:if test="${page >= maxpage }">
						<li class="page-item">
							<a class="page-link gray">&nbsp;다음</a>
						</li>
				</c:if>
				<c:if test="${page < maxpage }">
					
						<% if(status.equals("s")) {%>
							
							<li class="page-item">
								<a href="send?p_no=${p_no}&page=${page+1}" class="page-link">&nbsp;다음</a>
							</li>
						<% } else {%>

							<li class="page-item">
								<a href="receive?p_no=${p_no}&page=${page+1}" class="page-link">&nbsp;다음</a>
							</li>
						<% }%>

				</c:if>
		
			</ul>			
		</div>
	</c:if>
	
	<%-- 게시글이 없는 경우 --%>
	
	<c:if test="${listcount==0 }">
		<h3 style = "text-align:center">등록된 글이 없습니다.</h3>
	</c:if>
	
	
	</div>
    </div>

</div>
</body>
</html>