<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>  
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="${pageContext.request.contextPath}/resources/css/att_css/jquery-ui.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
#Date_Search{
	margin-left:60%;
	border-radius: 4px 0px 0px 4px;
}

#th1{width:20%;}
#th2{width:27%;}
#th3{width:27%;}
#th4{width:26%;}

th,td{
text-align: center;
}

.mb-0,.card-header.bg-primary.text-white{
	background-color:009CFF !important;
	border-color : 009CFF
}


#submit{
	border-radius: 0px 4px 4px 0px;
}



.btn-primary{
	opacity:0.8
}


</style>
<script>
    $(document).ready(function () {
            $.datepicker.setDefaults($.datepicker.regional['ko']);
            
            $( "#Date_Search" ).datepicker({
                 nextText: '다음 달',
                 prevText: '이전 달', 
                 dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
                 dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
                 monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
                 dateFormat: "yymmdd",
                 maxDate: 0,           // 선택할수있는 최대날짜, (오늘 기준으로 전날까지 가능)
                 minDate:new Date('2023-01-01') //선택할수있는 최소 날짜 (2023.01.01일 부터 선택가능)
               
            });  
            
            //submit click 이벤트 
            $("#submit").click(function(){
		    	//공백 검사
            	
            	if($("#Date_Search").val() == ""){
		    		alert('날짜를 선택하세요.');
		    		$("#Date_Search").focus();
					return false;
		    	}
            	
         	
  		  });
  
            // 휴가 종료날짜 입력시 유효성 검사
            $('#Date_Search').keyup(function(){
            	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
        		const docommute_record = $(this).val();
        		if(!pattern.test(docommute_record)){
        			alert('날짜 형식에 맞게 입력하여 주세요');
        			$(this).val("").focus();
        		}
            	}
        	});

    });
</script>
</head>
<body>
	<div class="container mt-3">
		<div class="row justify-content-center mb-3">
			<div class="col-md-4">
				<div id="calendar"></div>
			</div>
		</div>
		
		
		
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card">
					<div class="card-header bg-primary text-white">
						<h5 class="mb-0">근태기록</h5>
					</div>
					<div class="card-body">
						<form action="commute_record" method="get">
							<div class="form-group">
							<div class="input-group mb-3">
						    <input type="text" class="form-control" name="Date_Search" id="Date_Search" placeholder="날짜를 선택하세요">
						    <button type="submit" class="btn btn-outline-primary" id="submit">검색</button>
						   </div>
						   
							</div>
						</form>
						
						<%-- 출퇴근 기록이 있는경우 --%>
                       <c:if test="${recordcount > 0 }">
						
						<table id="commuteTable" class="table">
							<thead>
								<tr id="tr">
									<th id="th1">날짜</th>
									<th id="th2">출근 시간</th>
									<th id="th3">퇴근 시간</th>
									<th id="th4">총 근무 시간</th>
								</tr>
							</thead>
							<tbody>
			
			   <%-- 출근 기록 --%>
		<c:forEach var="b" items="${recordlist}" varStatus="vs">
		    <tr>
		        <td><div>
		        <fmt:parseDate value="${b.work_date}" var="date" pattern="yyyyMMdd" scope="page"/>
		        <fmt:formatDate value="${date}" pattern="yyyy-MM-dd"/>
		        </div></td>
		        <td><div>${b.startTime}</div></td>
		        <td><div>${b.endTime}</div></td>
		        <td><div>${b.work_today}</div></td>
		    </tr>
		</c:forEach>
		    <%-- 시물  끝--%>	
		</tbody>
	</table>
					
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
				      <a class="page-link">&lt;&lt;</a>
				    </li>
				    <li class="paga-item" style="display:none">
				      <a class="page-link">&lt;</a>
				    </li>
				  </c:if>
				  
				  <%-- 1페이지보다 크면: 이전버튼 누르면 page값 ,board/commute_record으로 보냄 --%>
				  <c:if test="${page>1}">
				    <c:url var="first" value="commute_record">
				    	<c:param name="page" value="${1}"/>
				    </c:url>
				    
				   	<c:url var="back" value="commute_record">
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
			   
				    <%--다른 페이지는 누르면 검색필드,검색어,페이지들고 commute_record.bo갔다온다 --%>
				    <c:if test="${i != page}">
				      <c:url var="move" value="commute_record">
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
				      	<a class="page-link">&gt;</a>
				      </li>
				      <li class="page-item" style="display:none">
				      	<a class="page-link">&gt;</a>
				      </li>
				    </c:if>
				    
					    <%--최대페이지미만: 다음 버튼누르면 page+1값, 검색필드, 검색어 들고 commute_record.bo 갔다옴 --%>
					    <c:if test="${page < maxpage}">
					      <c:url var="last" value="commute_record">
					      	<c:param name="page" value="${maxpage}"/>
					      </c:url>
					      
					      <c:url var="next" value="commute_record">
					        <c:param name="page" value="${page+1}"/>
					      </c:url>
					      <li class="page-item">
					        <a href="${next}" class="page-link next">&gt;</a>
					      </li>
					      <li class="page-item">
					        <a href="${last}" class="page-link last">&gt;&gt;</a>
					      </li>
			         </c:if>
			        </ul>
			     </div>
          </c:if> <%--  <c:if test="${recordcount > 0}"> end --%> 
		          <%-- 출퇴근 기록이 없는경우 --%>
				<c:if test="${recordcount == 0}">
				 <h3 style="text-align: center">출퇴근 기록이 없습니다.</h3>
				</c:if>    
					</div>
				</div>
			</div>
		</div>
		
		
		
		
		
	</div>
	</body>
	
