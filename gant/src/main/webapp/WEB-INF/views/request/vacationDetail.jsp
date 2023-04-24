<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<title>게시판 - 상세</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<style>
#subject{
  background-color: #03a9f4eb;
  color: white;
  opacity: 0.8;
}
.main_td{
  width: 80%;
}
#subject{
font-size: x-large;
}
.btn.btn-primary{
 opacity: 0.8;
 margin-bottom:1%
    
}
.container{
margin-left:9%;
margin-top:1%;  
}

.modal-header{
background-color: #009CFF;
color: white;
opacity: 0.8;    
}

#memberListModalLabel{
 color: white;   
}

table td{
  padding: 12px !important;
}

.container{
    height:100%
}

#modal_table{
text-align :center
}

.condition{
font-weight: bold;
}

.modal-body-scrollable {
  max-height: 300px; /* Change this value to the appropriate height */
  overflow-y: scroll;
}

/* Customize the scrollbar */
.modal-body::-webkit-scrollbar {
  width: 10px;
}

/* Track */
.modal-body::-webkit-scrollbar-track {
  background: #f1f1f1;
}

/* Handle */
.modal-body::-webkit-scrollbar-thumb {
  background: #b8d3e4;
  border-radius: 10px;
}

/* Handle on hover */
.modal-body::-webkit-scrollbar-thumb:hover {
  background: #b8d3e4;
}


</style>
<script>
$(document).ready(function () {   
 
	 $('.condition').each(function() {
		    
  		  // 결재상태에따라 결재상태 글자색을 변경한다.
  		  var condition = $(this).text();

  		    if (condition == '대기') {    		      
  		      $(this).html('<span class="badge bg-info">대기</span>');
  		    } else if (condition == '거절') {
  		      $(this).html('<span class="badge bg-danger">거절</span>');
  		    } else if (condition == '승인') {
  		      $(this).html('<span class="badge bg-success">승인</span>');
  		    }
  		  });
	  
  var $tableRows = $('#modal_table tbody tr');
  if ($tableRows.length > 5) {
    $('.modal-body').addClass('modal-body-scrollable');
  }
  
  //승인버튼 클릭시
  $('#approval').click(function() {
	  if(confirm("결재를 승인하시겠습니까?")){
		  if(confirm("승인 후에는 다시 결재가 불가능합니다. 그래도 승인하시겠습니까?")){
			  location.href='approval?paper_num=${vacation.paper_num}&classification=휴가신청서&condition=approval&writer_id=${vacation.id}&division=${vacation.division}&vacation_date=${vacation.vacation_date}'
		  }			  
	  }
  });  
	  
 //거절버튼 클릭시
  $('#refusal').click(function() {
		if(confirm("결재를 거절하시겠습니까?")){
		 if(confirm("거절 후에는 다시 결재가 불가능합니다. 그래도 거절하시겠습니까?")){
			 location.href='approval?paper_num=${vacation.paper_num}&classification=휴가신청서&condition=refusal'	  
			 }			  
		 }
	  
	  
  });
 
 
  //삭제버튼 클릭시
  $('#delete').click(function() {
		if(confirm("해당 문서를 삭제하겠습니까?")){
		 if(confirm("삭제 후 다시 복구가 불가능 합니다. 그래도 삭제하시겠습니까?")){
			 location.href='delete?paper_num=${vacation.paper_num}&classification=휴가신청서'	  
			 }			  
		 }
  });
      
 }); 
</script>
</head>
<body>

<jsp:include page="../home/side.jsp" />


<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">


<style>
.bg-info {
    background-color: #2196f3d4 !important;
}

.bg-success {
    background-color: #34c23a !important;
}

.bg-danger {
    background-color: #f44336cf !important;
}

.modal-footer {
   border-top: 0;
}



.table thead th {
 border-bottom: 0; 
}

.close {
    color: #fff;
    opacity: 1;
}

.form-control:disabled, .form-control:read-only {
    background-color: #e9ecef52;
    opacity: 1;
}

#subject{
border-radius : 10px 10px 0px 0px;
}

.border-top{
border-top: 0 !important; 
}

.btn-primary{
background-color: #03a9f4d4 !important; 
border: none;
}

.modal-header {
    background-color: #03a9f4d4;
    color: white;
    opacity: 0.8;
}
</style>
	     
	<div class="container">
	
  <button type="button" class="btn btn-primary float-right " data-toggle="modal" data-target="#memberListModal">참조자</button>
  <table class="table" id="maintable">
    <thead>
      <tr>
        <th colspan="2" id="subject" class="border-top">품의서</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <th>분류</th>        
        <td class="main_td">휴가신청서</td>
      </tr>
      <tr>
        <th>문서번호</th>
        <td><c:out value="${vacation.paper_num}"/>번</td>
      </tr>
      <tr>
        <th>기안자</th>
        <td><c:out value="${vacation.name}"/></td>
      </tr>
      <tr>
        <th>부서/직급</th>
        <td>
        <c:out value="${vacation.department}"/>/
        <c:out value="${vacation.position}"/>
        </td>
      </tr>
      <tr>
        <th>결재현황</th>
        <td class="condition"><c:out value="${vacation.condition}"/></td>
      </tr>
      <tr>
        <th>작성일</th>
        <td><c:out value="${vacation.write_date}"/></td>
      </tr>
      <tr>
        <th>휴가종류</th>
        <td><c:out value="${vacation.division}"/></td>
      </tr>
      <tr>
        <th>휴가기간</th>
        <td>
        <c:out value="${vacation.start_date}"/> &nbsp;~&nbsp; <c:out value="${vacation.end_date}"/> 
        (총<c:out value="${vacation.vacation_date}"/>일)
        </td>
      </tr>      
      <tr>
        <th>비상연락망</th>
        <td><c:out value="${vacation.emergency}"/></td>
      </tr>
      <tr>
        <th>세부사항</th>
        <td>
        <textarea class="form-control" readonly="readonly" rows="5"><c:out value="${vacation.details}"/></textarea>
        </td> 
    </tbody>
  </table>
   <button type="button" class="btn btn-outline-primary  float-left m-2" onclick="history.back(-1)">목록</button>
   
   <!-- 결재를 했다면 승인 / 거부 버튼은 더이상 보이지 않는다.  -->
   <c:if test="${condition_check == '대기' }">
   <button type="button" class="btn btn-primary  float-right m-2" id="approval">승인</button>
   <button type="button" class="btn btn-danger  float-right m-2" id="refusal">거절</button>
   </c:if>
   
   <!-- 관리자페이지에서만 볼 수 있다. 인사과와 관리자만 볼 수 있다.  -->
   <c:if test="${admin_delete == 'admin_delete' }">
   <button type="button" class="btn btn-danger  float-right m-2" id="delete">삭제</button>
   </c:if>
   
</div>


<div class="modal fade" id="memberListModal" tabindex="-1" role="dialog" aria-labelledby="memberListModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="memberListModalLabel">참조자 명단</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <table class="table" id="modal_table">
          <thead id="modal_thead">
            <tr>
              <th>참조자 이름</th>
              <th>부서/직급</th>
              <th>결재현황</th>
            </tr>
          </thead>
          <tbody>
           <c:if test="${not empty reference_person_list}">						         
		   <c:forEach var="b" items="${reference_person_list}" >
		    <tr>
		     <td><c:out value="${b.NAME}"/></td>
		     <td>
		     <c:out value="${b.DEPARTMENT}"/>/
             <c:out value="${b.POSITION}"/>
             </td>
		     <td class="condition"><c:out value="${b.CONDITION}"/></td>
		     </tr>
		   </c:forEach>
		   		   
		   </c:if>
          </tbody>
        </table>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">닫기</button>
      </div>
    </div>
  </div>
</div>

			
	  
		</div> <%-- class="container" end --%>
	</div> <%-- class main end --%>
</div> <%-- class row end --%>


	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>

</body>
</html>