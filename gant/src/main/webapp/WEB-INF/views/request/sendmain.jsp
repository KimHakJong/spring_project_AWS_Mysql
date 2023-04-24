<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>    
<head>
 <meta charset="utf-8">

    <link href="${pageContext.request.contextPath}/resources/css/home/bootstrap.min.css" rel="stylesheet"> 
    <link href="${pageContext.request.contextPath}/resources/css/request/style.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
    <style>
    .d-flex.justify-content-end.mb-3{
    width:400px;
    float:right
   }
   
  .rounded.h-100.p-4{
	    width:150% !important;
	    margin-left:20%;
	    margin-top:4%;
        text-align:center;
	}
	

.table{
    margin-top:5%;   
}

.dropdown{
    float:left
}	

.leftside.sidebar.pe-4.pb-3{
    padding-left:0;
     padding-top:0;
}
.navbar.bg-light.navbar-light{
    padding-left:16px;
    padding-right:16px;
}

    </style>
<script>
      $(document).ready(function () {   
    	 console.log('${only}');
    	 if('${only}' == "" ){
    		 $('#filterDropdown').text('전체');
    	 }else if('${only}' == '휴가신청서'){
    		 $('#filterDropdown').text('휴가신청서');
    	 }else if('${only}' == '초과근무신청서'){
    		 $('#filterDropdown').text('초과근무신청서');
    	 }
    	 
    	 
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
    	  
      });
  </script>    
</head>

<body>
<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">



			             <div class="col-sm-12 col-xl-6">
                        <div class="rounded h-100 p-4">
                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false" onclick="location.href='getMian'">받은결재함</button>
                                
                                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home"
                                        aria-selected="true" onclick="location.href='sendMain'">보낸결재함</button>
                                                                                                         
                                    <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-contact" type="button" role="tab"
                                        aria-controls="nav-contact" aria-selected="false"  onclick="location.href='writeOvertime'">작성하기</button>
                                    
                                    <c:if test="${department == '인사부' || admin == 'true' }">
                                     <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-contact" type="button" role="tab"
                                        aria-controls="nav-contact" aria-selected="false"  onclick="location.href='getAdmin'">관리자</button>
                                    </c:if> 
                                           
                                </div>
                            </nav>
                            <div class="tab-content pt-3" id="nav-tabContent">
                             
                             	<div class="dropdown">
						         <button class="btn btn-primary dropdown-toggle" type="button" id="filterDropdown" data-bs-toggle="dropdown"
						            aria-expanded="false"></button>
						         <ul class="dropdown-menu" aria-labelledby="filterDropdown">
						            <li><a class="dropdown-item" href="sendMain">전체</a></li>
						            <li><a class="dropdown-item" href="sendMain?only=휴가신청서">휴가신청서</a></li>
						            <li><a class="dropdown-item" href="sendMain?only=초과근무신청서">초과근무신청서</a></li>
						         </ul>
						      </div>
  
  <style>


tr{
   height:30px !important;  
    line-height: 30px  !important;  ;
}

.table td, .table th {
     border-top: 0px;
}


.table>:not(:last-child)>:last-child>* {
    border-bottom-color: #00000021;
}

.left{
text-align:left;
}

h5{
margin: 0;
}



.bg-info {
    background-color: #2196f3d4 !important;
}

.bg-success {
    background-color: #34c23a !important;
}

.bg-danger {
    background-color: #f44336cf !important;
}

#th1{width:7% }
#th5{width:12% }



.pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 4px 10px;
  text-decoration: none;
}
.pagination a.active {
  background-color: #03a9f4b0;
  color: white;
  border-radius: 5px;   
}

.pagination a:hover:not(.active) {
  background-color: #ddd;
  border-radius: 5px;
}
.pagination{
     justify-content : center; 
     padding-top:15px;
     display: flex;
}



th{
color: #fff;
background-color: #03a9f4d4 !important; 
}
#th1{
border-radius: 10px 0px 0px 0px;
} 
#th5{
border-radius: 0px 10px 0px 0px;
} 

.btn-primary{
background-color: #03a9f4d4  !important; 
border: none;
}
</style>                           
                                <!--테이블  시작 -->
						   <table class="table">
						      <thead>
						         <tr>
						           <th scope="col"  id="th1">번호</th>
						            <th scope="col" id="th2">작성자</th>
						            <th scope="col"  id="th3">분류</th>
						            <th scope="col" id="th4">작성일</th>
						            <th scope="col" id="th5">결재상태</th>
						            
						         </tr>
						      </thead>
						      <tbody>
						       <%-- 받은 결제서류가 있을 때 --%>
						      <c:if test="${not empty paper_list}">						         
								    <c:forEach var="b" items="${paper_list}" >
								    <tr>
								     <td><c:out value="${b.RNUM}" /></td>
								     
								   							     
								    <td><c:out value="${b.NAME}" /></td>
								    
										  <c:url var="detail" value="getDetail">
									        <c:param name="paper_num" value="${b.PAPER_NUM}"/>
									        <c:param name="classification" value="${b.CLASSIFICATION}"/>
									        <c:param name="send" value="send"/>
									      </c:url>								  
								     <td>
								     <a href="${detail}" ><c:out value="${b.CLASSIFICATION}"/></a> 
								     </td>
								     
								     <td><c:out value="${b.WRITE_DATE}"/></td>
								     <td class="condition"><c:out value="${b.CONDITION}"/></td>
								    </tr>    
								    </c:forEach>
							  </c:if>
						      
						      <%-- 받은 결제서류가 없을 때 --%>
						      <c:if test="${empty paper_list}">
							         <tr>
							            <td colspan="5">받은 결제서류가 없습니다.</td>
							         </tr>
                              </c:if>
						      </tbody>
						   </table>

<!--  페이징 처리  시작-->

       
       <div class="pagination">
		         <%-- 1페이지이전: 이동 x  --%>
				  <c:if test="${page<=1}">
				      <a>&laquo;</a>
				  </c:if>
				  
				  <%-- 1페이지보다 크면: 이전버튼 누르면 page값 ,board/getMian으로 보냄 --%>
				  <c:if test="${page>1}">	
				    
			 	   <c:url var="back" value="sendMain">
				        <c:param name="page" value="${page-1}"/>				        
					     <c:if test="${only != ''}">
					      	<c:param name="only" value="${only}"/>
					    </c:if>
				    </c:url>				  				    
				    <a href="${back}">&laquo;</a>
				  </c:if>
				  
				  <%-- 1번부터 끝번호까지 페이지번호 매김--%>
				  <c:forEach var="i" begin="${startpage}" end="${endpage}" step="1">
				    <%--현재 페이지는 색깔다르고, 이동없음 --%>
				    <c:if test="${i == page}">
				        <a class="active">${i}</a>
				    </c:if>
			       
				  
				    <c:if test="${i != page}">
				     <c:url var="move" value="sendMain">
				        <c:param name="page" value="${i}"/>				        
					    <c:if test="${only != ''}">
					      	<c:param name="only" value="${only}"/>
					    </c:if>
				      </c:url>
				      <li class="paga-item">
				        <a href="${move}">${i}</a>
				      </li> 
				    </c:if>
				  </c:forEach>
				    
				    <%--현재 페이지가 최대페이지거나 이상 : 작동X, --%>  
				    <c:if test="${page >= maxpage}">				    
				      	<a>&raquo;</a>				    
				    </c:if>
				    
					    <c:if test="${page < maxpage}">
					      
					       <c:url var="next" value="sendMain">
					        <c:param name="page" value="${page+1}"/>					       
					      	<c:if test="${only != ''}">
					      	<c:param name="only" value="${only}"/>
					        </c:if>
					      </c:url>					      
					        <a href="${next}">&raquo;</a>
			         </c:if>
		</div>


<!-- 페이징처리끝 -->                                   
 <!-- 테이블  끝  -->                                   

                    
                          
                            
                            </div>
                        </div>
                    </div>
		
		
		</div> 
	</div>

   
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>

</body>
</html>