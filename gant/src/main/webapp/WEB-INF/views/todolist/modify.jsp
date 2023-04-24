<%@ page language="java" contentType="text/html; charset=utf-8"%>
<!DOCTYPE html>
<html>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>

<head>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<script src = "${pageContext.request.contextPath}/resources/js/todolist/modify.js"></script>
<style>
h1{
font-size:1.5rem; text-align:center; color:#1a92b9
}

table{
border-spacing: 5px !important;
width: 80%;

}
.table{
	border-color: black !important;
}

th{
	border-color: black !important;
	font-weight:bold;
}
td{
color: black;
}

label{
font-weight:bold;
margin-top: 10px;
}

.container-fluid.pt-4.px-4{
  
  height : 80%;
  width : 55%;
}
.container{
margin-bottom : 40px;
}

</style>

<script>

var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

$(document).on('click', '.dropdown-item', function() {
	
	  var selectedValue = $(this).data('state');
	  var selectedText = $(this).text();
	  
	  $('#state').val(selectedValue);
	  $('#stateDropdown').text(selectedText);  
	  

	  
});



</script>

</head>
<body>
<%--보낸사람, 프로젝트생성자, admin이 수정가능
받는사람은 상태만 변경가능
--%>
<jsp:include page="../home/side.jsp" />
<div class="content">


<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">

   <input type="hidden" id="p_no" value="${p_no}">
   <input type="hidden" id="board_id" value="${id}"> 
   
   <%-- s가 1이면 send, 0이면 receive --%>
   <%-- 0일때는 상태빼고 readOnly 속성 --%>
	<div class="container" id="container">
	      <form action="modifyAction?p_no=${p_no}&s=${s}" method="post" name="modifyform" enctype="multipart/form-data">
	   
	      <input type="hidden" name="board_num" value="${todolist.board_num }">
	      <h1>ToDo-List 수정</h1>
	      
	      <div class="form-group">
	         <label for="board_name">보낸사람</label>
	         <input type="text" name="board_name" class="form-control" 
	         value="${todolist.board_id }" readOnly>
	      </div>
	      
	     <div class="form-group">
        		<label for="deadline">기한</label> 
				<input type="date" class="form-control" id="deadline" 
				name="deadline" value="${todolist.deadline }" ${s == 0 ? 'readonly' : ''}>   
         </div>
	      
	      <div class="form-group">
	      <label for="board_subject">제목</label>
	      <textarea name="board_subject" id="board_subject" rows="1" 
	      class="form-control" maxlength="100" ${s == 0 ? 'readonly' : ''}>${todolist.board_subject }</textarea>
	      </div>
	      
	      <div class="form-group">
	      <label for="board_content">내용</label>
	      <textarea name="board_content" id="board_content" rows="10" 
	      class="form-control" ${s == 0 ? 'readonly' : ''}>${todolist.board_content }</textarea>
	      </div>
	      

		<div class="form-group">
		  <label for="state">상태</label>
		  <div class="dropdown">
		    <button class="btn btn-primary dropdown-toggle" type="button" id="stateDropdown" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
		      ${todolist.state == 'true' ? '진행중' : '완료'}
		    </button>
		    <div class="dropdown-menu" aria-labelledby="stateDropdown">
		      <button class="dropdown-item" type="button" data-state="true">진행중</button>
		      <button class="dropdown-item" type="button" data-state="false">완료</button>
		    </div>
		    <input type="hidden" name="state" id="state" value="${todolist.state}">
		  </div>
		</div>
		<br>
	      
	      <div class="form-group">
	         <button type=submit class="btn btn-success">수정</button>
	         <button type=reset class="btn btn-danger" onClick="history.go(-1)">취소</button>
	      </div>
	      
	   <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	      </form>
	   
	   </div><%-- class="container end --%>
	   </div>
	   </div>
</body>
</html>
	