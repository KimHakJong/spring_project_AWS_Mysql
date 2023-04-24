<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400&display=swap" rel="stylesheet">
    
    <link href="${pageContext.request.contextPath}/resources/css/request/style.css" rel="stylesheet"> 
     
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/note/fonts/icomoon/style.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/note/owl.carousel.min.css">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/note/bootstrap.min.css">
    
    <!-- Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/note/style.css">
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
    <title>보낸쪽지함</title>
    
<style>
    
 .content{
    padding:0px
}  

    .d-flex.justify-content-end.mb-3{
    width:400px;
    float:right;
   }
   
.rounded.h-100.p-4{
	    width:150% !important;
	    margin-left:20%;
	    margin-top:4%;
        text-align:center;
	}
	

.table.custom-table{
    margin-top:2% !important;
}



#home-tab{
    border:none;
    background-color: #009cffc4
}

.col-sm-12.col-xl-6{
  margin-top:2%;
}
.leftside.sidebar.pe-4.pb-3{
    padding-left:0;
     padding-top:0;
}



.read_img{
    padding-bottom:4px
}

.left{
   text-align:left;
}

#th1{width:4%}
#th2{width:10%}
#th3{width:25%}
#th4{width:57%}
#th5{width:0}


.pagination {
  display: inline-block;
}

.pagination a {
  color: black;
  float: left;
  padding: 8px 16px;
  text-decoration: none;
}
.pagination a.active {
  background-color: #03a9f470;
  color: white;
  border-radius: 20px;   
}

.pagination a:hover:not(.active) {
  background-color: #ddd;
  border-radius: 20px;
}
.pagination{
     justify-content : center; 
     padding-top:15px
}
.read_img{
  width:20px
}
    </style>

<script>
$(function(){
    $('#write').click(function() { 
    	location.href = 'write';
    })
	
	
	$('.js-check-all').on('click', function() {

	  	if ( $(this).prop('checked') ) {
		  	$('th input[type="checkbox"]').each(function() {
		  		$(this).prop('checked', true);
	        $(this).closest('tr').addClass('active');
	       
		  	})
	  	} else {
	  		$('th input[type="checkbox"]').each(function() {
		  		$(this).prop('checked', false);
	        $(this).closest('tr').removeClass('active');
	       
		  	})
	  	}

	  });

	  $('th[scope="row"] input[type="checkbox"]').on('click', function() {
	    if ( $(this).closest('tr').hasClass('active') ) {
	      $(this).closest('tr').removeClass('active');
	     
	    } else {
	      $(this).closest('tr').addClass('active');	     
	    }
	  });
	  
	  //삭제버튼 숨기기
	  $('#delete').hide();
	  
	  //체크박스를 하나라도 체크한다면 삭제버튼을 보여준다.
	  $('input[type=checkbox]').change(function() {
	    if ($('input[type=checkbox]:checked').length > 0) {
	      $('#delete').show();
	    } else {
	      $('#delete').hide();
	    }
	  });
	  
	  
	  $('#delete').click(function() {
	  
		  if(confirm("휴지통으로 이동합니다. 일주일 뒤 자동으로 삭제됩니다.")){
			  $('#basketfrom').submit();
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
        
      <button type="button" class="btn btn-outline-primary  m-2 float-left" id="write">쪽지쓰기</button>
      
      <div class="col-sm-12 col-xl-6">
      <div class="rounded h-100 p-4">
      
   
                        
                <ul class="nav nav-pills mb-3 nav-tabs-bordered"  id="pills-tab" role="tablist">
                <li class="nav-item" role="presentation">
                <button class="nav-link active" id="home-tab" data-bs-toggle="tab" data-bs-target="#bordered-home" type="button" role="tab" aria-controls="home" aria-selected="true" onclick="location.href='getMian'">받은쪽지함</button>
                </li>
                <li class="nav-item " role="presentation">
                  <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false" onclick="location.href='sendMian'">보낸쪽지함</button>
                </li>
                <li class="nav-item" role="presentation">
                  <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false" onclick="location.href='getBasketMian'">휴지통</button>
                </li>
             
              </ul>           
      
       <form action="getMian" method="get" accept-charset="UTF-8">       
                          <div class="d-flex justify-content-end mb-3">                          
						      <div class="input-group" id="Search-group">
						         <input type="text" class="form-control" placeholder="제목을 입력하세요" name="search_subject" id="Search">
						         <button class="btn btn-outline-primary " type="submit">검색</button>
						      </div>
						   </div>
                 </form>
      
   
    <form action="getBasket" method="get" id="basketfrom">
    <input type="hidden" name="type" value="get">
    <button type="button" class="btn btn-outline-danger float-left" id="delete">삭제</button>
        <table class="table custom-table">
          <thead>
            <tr>
              <th scope="col" id="th1">
                <label class="control control--checkbox">
                  <input type="checkbox" class="js-check-all"/>
                  <div class="control__indicator"></div>
                </label>
              </th>
              <th scope="col" id="th2" class="left"></th>
              <th scope="col" id="th3" class="left">보낸사람</th>          
              <th scope="col" id="th4" class="left" >제목</th>
              <th scope="col" id="th5" ></th>
            </tr>
          </thead>
          <tbody>
       
           <c:if test="${not empty note_list}">
	          <c:forEach var="b" items="${note_list}" >
	            <tr>
	              <th scope="row">
	                <label class="control control--checkbox">
	                  <input type="checkbox" name="note_nums" value="${b.note_num}"/>
	                  <div class="control__indicator"></div>
	                </label>
	              </th>
	              <td class="left">
	                <c:if test="${b.read_check == 'true'}">
	                <img src="${pageContext.request.contextPath}/resources/image/note/read.png" class="read_img">
	                </c:if>
                    <c:if test="${b.read_check == 'false'}">
	                <img src="${pageContext.request.contextPath}/resources/image/note/notRead.png" class="read_img">
	                </c:if>
	              </td>
	              <td class="left">
	              <c:out value="${b.from_name}"/>
	              </td>
	              <td class="left" >
	              <c:url var="detail" value="getDetail">
				  <c:param name="note_num" value="${b.note_num}"/>
				  <c:param name="read_check" value="${b.read_check}"/>
				  <c:param name="type" value="normal"/>
				  <c:param name="file_num" value="${b.file_num}"/>
				  </c:url>
	              <a href="${detail}" ><c:out value="${b.subject}"/></a>
	              </td>
	   
	              <td>
	              <c:out value="${b.write_date}"/>
	              </td>             
	            </tr>
	            </c:forEach>
	        </c:if>    
	        <c:if test="${empty note_list}">
	        <tr>
	           <td colspan="5">받은쪽지가 없습니다.</td>
	        <tr>
	        </c:if>
          </tbody>
        </table>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"> 
        </form>
       
       <%-- 페이징처리 --%>
       
       <div class="pagination">
		         <%-- 1페이지이전: 이동 x  --%>
				  <c:if test="${page<=1}">
				      <a>&laquo;</a>
				  </c:if>
				  
				  <%-- 1페이지보다 크면: 이전버튼 누르면 page값 ,board/getMian으로 보냄 --%>
				  <c:if test="${page>1}">	
				    
				   	<c:url var="back" value="getMian">
				        <c:param name="page" value="${page-1}"/>
				       <c:if test="${search_subject != ''}">
					    <c:param name="search_subject" value="${search_subject}"/>
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
			       
				    <%--다른 페이지는 누르면 검색필드,검색어,페이지들고 getMian.bo갔다온다 --%>
				    <c:if test="${i != page}">
				      <c:url var="move" value="getMian">
				        <c:param name="page" value="${i}"/>
				        <c:if test="${search_subject != ''}">
					      	<c:param name="search_subject" value="${search_subject}"/>
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
					      
					      <c:url var="next" value="getMian">
					        <c:param name="page" value="${page+1}"/>
					        <c:if test="${search_subject != ''}">
					      	<c:param name="search_subject" value="${search_subject}"/>
					      	</c:if>
					      </c:url>					      
					        <a href="${next}">&raquo;</a>
			         </c:if>
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