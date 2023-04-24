<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%



%>

<!DOCTYPE html>
<html>
<head>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src = "${pageContext.request.contextPath}/resources/js/todolist/writeform.js"></script>

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
</head>

<script>
$(document).ready(function() {
	
	
    $('#addMembersBtn').click(function() {
        
        event.preventDefault();
        
       
        
        $.ajax({
            //url: '${pageContext.request.contextPath}/todolist/search-member',
            //type: 'get',
            data: $('#memberSearchForm').serialize(),
            success: function(data) {

               
            	   var selectedMembers = $('input[name="selectedMembers"]:checked');
            	    var memberIds = [];
            	    
            	    selectedMembers.each(function() {
            	        memberIds.push($(this).val());
            	    });
            	    
            	    var memberIdsString = memberIds.join(',');
            	    $('#r_name').val(memberIdsString);
            	    
            	    $('#memberSearchModal').modal('hide');
            	    
            	    
            },
            error: function() {
            }
  
        });
    });
});

</script>

<body>

<jsp:include page="../home/side.jsp" />
<div class="content">


<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4"> 
	<div class="container" id="container">
	
   <form action = "add?p_no=${p_no}" method="post" enctype="multipart/form-data" name="boardform">
      <h1>To-Do List 작성</h1>
         <div class="form-group">
            <label for="board_name">보내는 사람</label>
            <input name="board_id" id="board_id" value="${id}" readOnly
                  type="text" class="form-control" placeholder="아이디">
         </div>
         <input type="hidden" id="p_no" value="${p_no}">
         <input type="hidden" id="board_id" value="${id}">
         
         
         
         <div class="form-group">
            <label for="receiver_name">받는 사람</label>
            <button type="button" style="margin-bottom: 3px;" class="btn btn-sm btn-primary m-2" data-bs-toggle="modal" data-bs-target="#memberSearchModal">명단 검색</button>
            <input type="text" name="r_name" id="r_name" class="form-control" readOnly>
         </div>
         
         <div class="form-group">
        		<label for="deadline">기한</label> 
				<input type="date" class="form-control" id="deadline" name="deadline">   
         </div>
             
         <div class="form-group">
            <label for="board_subject">제목</label>
            <input name="board_subject" id="board_subject" maxlength="100"
                  class="form-control" placeholder="제목을 입력해 주세요.">
         </div>
         
         <div class="form-group">
            <label for="board_content">내용</label>
            <textarea name="board_content" id="board_content" rows="10" class="form-control"></textarea>
         </div>

         <br>

         <div class="form-group" id="submitBtn">
            <button type="submit" class="btn btn-success" id="add">등록</button>
            <button type="reset" class="btn btn-danger" id="cancel">취소</button>
         </div>
         <br>
         <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
   </form>
   </div>
   </div>
</div>

	<!-- Member search modal -->
	<div class="modal" id="memberSearchModal" tabindex="-1" aria-labelledby="memberSearchModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="memberSearchModalLabel">받는 사람 선택</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				</div>
				<div class="modal-body">
				<table class="table">
				    <thead>
				        <tr>
				        	<th style="color:skyblue;">&nbsp;</th>
				            <th style="color:skyblue;">아이디</th>
				            <th style="color:skyblue;">이름</th>
				            
				        </tr>
				    </thead>
				    <tbody>
				        <c:forEach var="memberId" items="${p_id}" varStatus="status">
				            <tr>
				            <td>
				            <div class="form-check">
				            	<input class="form-check-input" type="checkbox" name="selectedMembers" value="${memberId}"/>
				            </div>
				            </td>
				            <td>${memberId}</td>
				            <td>${p_name[status.index]}</td>
				            
				            </tr>
				        </c:forEach>
				    </tbody>
				</table>



				</div>
					<div class="modal-footer" style="border-top:none;">		
						
							<button type="button" id="addMembersBtn" class="btn btn-sm btn-primary m-2">명단 추가</button>
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						
					
						<button type="button" class="btn btn-sm btn-secondary m-2" data-bs-dismiss="modal">닫기</button>	
					</div>
			</div>
		</div>
	</div>
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer> 
	
</body>
</html>