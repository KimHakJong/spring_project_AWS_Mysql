<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">
<title>게시판 - 상세</title>

<link href="${pageContext.request.contextPath}/resources/css/home/home.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@400;700&display=swap" rel="stylesheet">
	<script src="${pageContext.request.contextPath}/resources/js/board_js/view.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/board_css/view.css" type="text/css"> 
<style>
.form-control:disabled, .form-control:read-only {
    background-color:  #e9ecef75 !important;
}

</style>

</head>
<body>

<jsp:include page="../home/side.jsp" />


<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">
		<%-- view.js 에서 사용하기 위해 추가--%>
		<input type="hidden" id="loginid" value="${id}" name="loginid"> 
		<input type="hidden" name="num" value="${boarddata.board_num}" id="comment_board_num">
		<input type="hidden" name="fontWeight" value=${boarddata.fontWeight} id="fontWeight">
		<input type="hidden" name="fontSize" value="${boarddata.fontSize}" id="fontSize">
		<input type="hidden" name="fontColor" value="${boarddata.fontColor}" id="fontColor">
		<input type="hidden" name="like_check" value="${like_check}" id="like_check">
		<input type="hidden" name="admin" value="${admin}" id="admin">
		<%-- view.js 에서 사용하기 위해 추가 끝--%>
		<div class="container">
		  <table class="table">
		  <thead>
		     <tr>
		        <th colspan="2">공지/자유게시판</th>
		        <th id="date"><div id="board_date">${boarddata.board_date}</div></th>
		    </tr>
		    </thead>
		    <tr>
		       <td id="member" colspan="2">
		       <img src="${pageContext.request.contextPath}/resources/image/memberupload/${boarddata.id_profileimg}" id="memberfile" alt="memberfile">  		             
		       <div id="board_name">${boarddata.board_name}</div>
		       </td>
               <td></td>
	    </tr>
	    <tr>
	        <td><div>제목</div></td>
	        <td><c:out value="${boarddata.board_subject}"/></td>
	        <td></td>
	    </tr> 
	    <tr>
	        <td><div>내용</div></td>
	        <td style="padding-right: 0px" colspan="2">
	            <textarea class="form-control" 
	                      rows="5" id="content" readOnly>${boarddata.board_content}</textarea>
	        </td>
	    </tr>
	    
	    <c:if test="${boarddata.board_re_lev == 0}">
	    <%-- 원문글인 경우만 첨부파일을  추가 할 수 있습니다. --%>
	    <tr>
	       <td><div id="File">첨부파일</div></td>
	       <%-- 파일을 첨부한 경우 --%>
	          <c:if test="${!empty boarddata.board_file}">
          <td id="Filename">
	          <form method="post" action="down" style="height:0px">
	             <input type="hidden" value="${boarddata.board_file}" name="filename">
	             <input type="hidden" value="${boarddata.board_original}" name="original">
	             <div id ="submitname">
	             <input type="image" src="${pageContext.request.contextPath}/resources/image/board_image/download.png" id="imgsub">
	               <span id="originalname">
	               ${boarddata.board_original}
	               </span>
	              </div>
	              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	          </form>
           </td>
        </c:if>
       <%-- 파일을 첨부하지 않은경우 --%>
        <c:if test="${empty boarddata.board_file}">  
         <td></td>
	        </c:if>
	         <td> <%-- 좋아요버튼 --%>
				         <div class="contain">
					<div class="heartAnim">
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
					</div>
					<button id="like"><span class="ti ti-thumb-up"></span>&nbsp;Like</button>
				</div>
	         </td><%-- 좋아요버튼 끝 --%>

	      </tr>
	    </c:if>
	    
	     <c:if test="${boarddata.board_re_lev != 0}">
	    <%-- 답글인경우 --%>
	    <tr>
	         <td colspan="2"></td>
	         <td> <%-- 좋아요버튼 --%>
				         <div class="contain">
					<div class="heartAnim">
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
						<span class="fas fa-heart"></span>
					</div>
					<button id="like"><span class="ti ti-thumb-up"></span>&nbsp;Like</button>
				</div>
	         </td><%-- 좋아요버튼 끝 --%>

	     </tr>
	    </c:if>
	    <tr>
	    <td colspan="2"></td>
	    <td>
	    <div id="button">
		        <%-- 수정버튼과 삭제버튼은 글쓴이와 admin권한을 가진 사람만 보이게 한다. --%>
		           <c:if test="${boarddata.board_name == id || admin == 'true' }">
		             <a href="modify?num=${boarddata.board_num}">
		               <button class="btn btn-warning">수정</button>
		             </a>
		           <%--삭제는 confirm으로 확인하고 이동 js 에서 처리 --%>
		           <button class="btn btn-danger" id="bodelete">삭제</button>		            
		          </c:if>
		         <a href="main">
		           <button class="btn btn-outline-primary">목록</button>
		         </a>
		         <c:if test="${boarddata.board_notice == 'false'}">
		         <a href="reply?num=${boarddata.board_num}">
		           <button class="btn btn-outline-primary">답글쓰기</button>
		         </a>
		         </c:if>
		      </div>
	    
	    </td>
	    </tr>
	    
	    </table>
	     
	     <%-- 댓글 영역 --%>
	    <div class="comment-area">
				<div class="comment-head">
					<h3 class="comment-count">
						댓글 <sup id="count"></sup><%--superscript(윗첨자) --%>
					</h3>
					<div class="comment-order">
						<ul class="comment-order-list">
						</ul>
					</div>
				</div><%-- comment-head end--%>
				<ul class="comment-list">
				</ul>
				<div class="comment-write">
					<div class="comment-write-area">
						<b class="comment-write-area-name" >${id}</b> <span
							class="comment-write-area-count">0/200</span>
						<textarea placeholder="댓글을 남겨보세요" rows="1"
							class="comment-write-area-text" maxLength="200"></textarea>
						
					</div>
					<div class="register-box" >
						<div class="button btn-cancel" >취소</div><%-- 댓글의 취소는 display:none, 등록만 보이도록 합니다.--%>
						<div class="button btn-register" >등록</div>
					</div>
				</div><%--comment-write end--%>
			</div><%-- comment-area end--%>
			
	  
		</div> <%-- class="container" end --%>
	</div> <%-- class main end --%>
</div> <%-- class row end --%>

 

	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>

</body>
</html>