<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>    
<head>
 <meta charset="utf-8">
<title>초과근무 신청서</title>


<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
      $(document).ready(function () {
    	  
    	  
    	  //분류를 변경시 신청서가 변경된다.
    	  $("#floatingSelect").on("change", function(){
		    //selected value
		    if($(this).val() == "휴가신청서"){
		    	 location.href="writeVacation"
		    }
		   
         });
    	  
    	  
    	  
    	  
    	  
    	  $.datepicker.setDefaults($.datepicker.regional['ko']);
          
          $( "#overtime_date" ).datepicker({
        	  showMonthAfterYear: true,
  	          showOtherMonths: true,
  	          yearSuffix: '년',
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
            	if($("#overtime_date").val() == ""){
		    		alert('근무일자를 선택하세요.');
		    		$("#overtime_date").focus();
					return false;
		    	}
		    	
            	if($("#start_time").val() == ""){
		    		alert('초과근무 시작시간을 선택하세요.');
		    		$("#start_time").focus();
					return false;
		    	}
            	
            	if($("#end_time").val() == ""){
		    		alert('초과근무 끝난시간을 선택하세요.');
		    		$("#end_time").focus();
					return false;
		    	}
		    	
            	if($("#overtime_content").val() == ""){
		    		alert('작업내용을 입력하세요.');
		    		$("#overtime_content").focus();
					return false;
		    	}
            	
            	if($("#overtime_reason").val() == ""){
		    		alert('사유를 입력하세요.');
		    		$("#overtime_reason").focus();
					return false;
		    	}
            	
            	if($("#reference_person").val() == ""){
    	    		alert('참조자를 선택하세요');
    				return false;
    	    	}
            	
  		  });
            
            // 근무일자 입력시 유효성 검사
            $('#overtime_date').keyup(function(){
            	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
            	// 년도4자리 월2자리 일 자리	
        		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
        		const domain = $(this).val();
        		if(!pattern.test(domain)){
        			alert('형식에 맞게 입력하여 주세요');
        			$(this).val("").focus();
        		}
            	}
        	});  
            
           
            let check_id = ''; //체크아이디저장
            
            //참조자 체크박스 이벤트
            //이미 체크를 클릭했던 체크박스를 유지하기 위해 체크 여부를 change_id 변수에 저장한다.
        	$("table").on('change','input[type="checkbox"]',function(){
        		var member_val = $(this).val().split(",");  //  member_val[0] = 이름 ,member_val[1] = id  	
        		let change_id = member_val[1]; //체크된 아이디
        		
        		if($(this).is(":checked")){//새로 체크되었을 때
        			if(!check_id.includes(change_id)){ //기존 체크 id에 방금 체크한 아이디가 없는 경우
        				if(check_id.substr(-1)==',' || check_id.length==0){ //맨마지막이 ,인 경우
        					check_id += change_id + ",";
        				}else{
        					check_id += "," + change_id + ",";
        				}
        			}
        		}else {//체크해제된 경우
        			if(check_id.includes(change_id)){//기존 체크id에 방금 체크해제된 아이디가 포함된 경우
        					check_id = check_id.replace(change_id+",","");
        			}
        		}
        		
        	});
           
            //명단 검색 ajax
        	$("#search_name").keyup(function(){
        		name = $(this).val();        		
        		$.ajax({
        			url : "searchMemberList",
        			type : "get",
        			data : { "name" : name},
        			dataType : "json",
        			async: false,
            		success : function(rdata){
      				
        				let output ='';
        				if(rdata!=null){
        					$(rdata).each(function(){
        						if(check_id.includes(this.id)){ //check_id에 값이 있다면 자동으로 체크되도록!
        						output += '<tr><td><input type="checkbox" name="memberlist" value="'+this.name+','+this.id+'" checked></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
        						}else{
        						output += '<tr><td><input type="checkbox" name="memberlist" value="'+this.name+','+this.id+'"></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
        						}
        					});
        				}else{
        					output += "<tr><td colspan='3'>검색된 명단이 없습니다.</td></tr>";
        				}
        				$("#tbody").empty();
        				$("#tbody").append(output); 	
            		}
        		});
        	});
            
      
            $('#modalSubmit').click(function(){
            	
            	$.ajax({
        			url : "../request/searchMemberList",
        			type : "get",
        			data : { "name" : ''},
        			dataType : "json",
        			async: false,
            		success : function(rdata){
      				
        				let output ='';
        				if(rdata!=null){
        					$(rdata).each(function(){
        						if(check_id.includes(this.id)){ //check_id에 값이 있다면 자동으로 체크되도록!
        						output += '<tr><td><input type="checkbox" name="memberlist" value="'+this.name+','+this.id+'" checked></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
        						}else{
        						output += '<tr><td><input type="checkbox" name="memberlist" value="'+this.name+','+this.id+'"></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
        						}
        					});
        				}else{
        					output += "<tr><td colspan='3'>검색된 명단이 없습니다.</td></tr>";
        				}
        				$("#tbody").empty();
        				$("#tbody").append(output); 	
            		}
        		});
            	selectWorkers();
        	});  
            
           
            $(document).ready(function() {
            	  if ($("#myModal .modal-body table tbody tr").length > 5) {
            	    $("#myModal .modal-body").animate({ scrollTop: $("#myModal .modal-body table tbody tr:last-child").position().top }, 1000);
            	  }
            	});
    
    });
      
      //명단검색에서 체크한 사람을 #reference_person에 넣는다.
      //실제로 보내는 데이터는 이름이 아닌 id을 보낸다.
      function selectWorkers() {
    	  var checked_member_name = [];
    	  var checked_member_id = [];
    	  $("input[name='memberlist']").each(function () {
    	    if ($(this).prop("checked")) {
    	    	var member = $(this).val().split(",");  //  member[0] = 이름 ,member[1] = id  	    	
    	    	checked_member_name.push(member[0]);    
    	    	checked_member_id.push(member[1]);   
    	    }
    	    $('#search_name').val('');
    	  });
    	  $("#reference_person").val(checked_member_name.join(","));
    	  $("#reference_person_id").val(checked_member_id.join(","));
    	  console.log("참조자 회원아이디 =" + $("#reference_person_id").val()  ) 
    	  }

</script>

<style>
*{
font-family:"noto sans", sans-serif;
}

h1{
font-size: 1.5rem ;
text-align: center;
margin-bottom: 15px;
margin-top: 15px;
}
.container{
width: 60%
}
label{
font-weight: bold;
display: block;
 }
img{
width: 20px
}
.rounded.h-100.p-4{
	    width:150% !important;
	    margin-left:20%;
	    margin-top:4%;
	}
#memberlist{
    margin-bottom:40px;
}


.ui-datepicker-inline.ui-datepicker.ui-widget.ui-widget-content.ui-helper-clearfix.ui-corner-all {
  padding: 10px 20px 10px 20px;
}
.ui-widget-header { border: none !important; background-color: transparent !important; }

.ui-state-default, .ui-widget-content .ui-state-default, .ui-widget-header .ui-state-default, .ui-button, html .ui-button.ui-state-disabled:hover, html .ui-button.ui-state-disabled:active {
    border: 1px solid #fff !important;
    background: #fff !important;
    font-weight: bold !important;
    color: #454545 !important;
    text-align: center !important;
    font-size: 14px;
    padding: 8px 0px 8px 0px;
}
.ui-datepicker .ui-datepicker-prev {
  left: 7px !important;
}
.ui-datepicker .ui-datepicker-next {
  right: 8px !important;
}
.ui-widget.ui-widget-content {
    width: 350px;
}

.ui-datepicker .ui-datepicker-title {
    font-size: 16px;
}

.ui-datepicker .ui-datepicker-header {
    width: 100%;
}

.ui-datepicker th {
    font-size: 15px;
    padding: 0.4em !important;
}

.ui-datepicker-calendar th:first-child {
   color: #ff2e47 !important;
}

.ui-datepicker-calendar th:nth-last-child(1) {
   color: #2baaff !important;
}

.ui-datepicker-calendar tr td:first-child a {
  color: #ff2e47 !important;
}
.ui-datepicker-calendar tr td:nth-last-child(1) a {
   color: #2baaff !important;
}
.ui-state-highlight, .ui-widget-content .ui-state-highlight, .ui-widget-header .ui-state-highlight{
   background:#26abff !important;
   color:white !important;
   border-radius:50% !important;
}

.table{ text-align: center; }

#search_group{
    width:50%;
    float:right;
}

.container.mt-5{
    padding-bottom:50px
}

.form-group{
    padding-bottom:5px
}

#myModal .modal-body {
  max-height: 400px;
  overflow-y: auto;
}

#myModal .modal-body::-webkit-scrollbar {
  width: 8px;
  background-color: #f5f5f5;
}

#myModal .modal-body::-webkit-scrollbar-thumb {
  background-color: #b8d3e4;
  border-radius: 20px;
}


</style>
</head>

<body>
<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />

<style>
.bg-primary {
    background-color: #03a9f4b0 !important;
}
.form-control:disabled, .form-control:read-only {
    background-color: #e9ecef69;
    opacity: 1;
}
</style>

			  <div class="container mt-5">
			  
			  
			  <div class="col-sm-12 col-xl-6">
                        <div class="bg-light rounded h-100 p-4">
                            <nav>
                                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                                    <button class="nav-link" id="nav-home-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home"
                                        aria-selected="false" onclick="location.href='getMian'">받은결재함</button>
                                        
                                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-profile" type="button" role="tab"
                                        aria-controls="nav-profile" aria-selected="false" onclick="location.href='sendMain'">보낸결재함</button>
                                        
                                    <button class="nav-link active" id="nav-contact-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-contact" type="button" role="tab"
                                        aria-controls="nav-contact" aria-selected="true"  onclick="location.href='writeOvertime'">작성하기</button>
                                
                                    <c:if test="${department == '인사부' || admin == 'true' }">
                                     <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab"
                                        data-bs-target="#nav-contact" type="button" role="tab"
                                        aria-controls="nav-contact" aria-selected="false"  onclick="location.href='getAdmin'">관리자</button>
                                    </c:if> 
                                
                                </div>
                            </nav>
                            <div class="tab-content pt-3" id="nav-tabContent">
			  
			  
			  
			  
			      <div class="card">
			        <div class="card-header bg-primary text-white">
			          <h4 class="card-title" style="color: white">초과근무신청서</h4>
			        </div>
			        <div class="card-body">
			  <form action="overtimeAction" method="post">
			     
			   <div class="form-group">
			    <label for="Classification">서류선택</label>
			
			                                <select class="form-control" id="floatingSelect"
			                                    aria-label="Floating label select example" name="classification">
			                                    <option value="초과근무신청서" selected>초과근무신청서</option>
			                                    <option value="휴가신청서">휴가신청서</option>
			                                </select>
			                            
			   </div> 
			     
			     
			    <div class="form-group">
			    <label for="vacation">근무일자</label>
			    <input type="text" class="form-control" name="overtime_date" id="overtime_date" maxlength="8" placeholder="근무 날짜를 선택하세요">
			   </div>
			  
			    <div class="form-group">
			    <label for="emergency">근무시간</label>
			    <div class="input-group mb-3">
			    <input type="time" class="form-control emergency" name="start_time" id="start_time"> &nbsp;~ &nbsp;
			    <input type="time" class="form-control emergency" name="end_time" id="end_time">
			   </div>
			   </div>
			
			   <div class="form-group">
			      <label for="vertime_content">작업내용</label>
			      <textarea name="overtime_content" id="overtime_content"   
			                rows="10" class="form-control" maxlength="1000" ></textarea>
			   </div>
			   
			   <div class="form-group">
			      <label for="overtime_reason">사유</label>
			      <textarea name="overtime_reason" id="overtime_reason"   
			                rows="10" class="form-control" maxlength="1000"></textarea>
			   </div> 
			   
			   
			   
			    <div class="form-group">
			      <label >참조자</label>
			      
			         <div class="input-group mb-3">
			        <input type="text" class="form-control" id="reference_person" readonly>
			        <input type="hidden" class="form-control" id="reference_person_id" name="reference_person">
					<button type="button" class="btn btn-outline-primary " data-toggle="modal" data-target="#myModal">
					  명단 검색
					</button>
			        </div>
			
			   </div> 
			   
			    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">  
			    <div class="form-group">
			    <button type="submit" class="btn btn-outline-primary  m-2 float-right" id="submit">신청</button>
			     <button type="button" class="btn btn-outline-danger m-2 float-right" onclick="location.href='getMian'">취소</button>
			    </div>
			  </form>


<style>
.modal-footer{
    border-top:none;
}
</style>		  
			
   <!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary" >
			        <h4 class="modal-title" id="myModalLabel" style="color: white">명단검색</h4>
			        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
			          <span aria-hidden="true">&times;</span>
			        </button>
			      </div>
			      <div class="modal-body">
			       
			       
							
						    <div class="input-group mb-3" id="search_group">      
								<input type="text" class="form-control" id="search_name" placeholder="이름을 검색하세요">
								<button  class="btn btn-outline-primary">🔍︎</button>						
							</div>
						
				
				   <div>
			        <table class="table">

			         <tr>
			         <th>체크</th>
			         <th>이름</th>
			         <th>부서</th>
			         </tr>

			         <tbody id="tbody">
			         <%-- 회원이 있을때 --%>
			        
			         
			         <c:if test="${membercount > 0}">
			         
			         <c:forEach var="b" items="${memberlist}"  varStatus="vs">    
			         <tr>
			         <td>
			         <div class="form-check">
			         <input type="checkbox" name="memberlist" value="${b.name},${b.id}" class="form-check-input">
			         </div>
			         </td>
			         <td>${b.name}</td>
			         <td>${b.department}</td>
			         </tr>
			         </c:forEach>
	 
			         </c:if>
			         <%-- 회원이 없을때 --%>
			         <c:if test="${membercount == 0}">
			          <tr><td colspan="3">검색된 명단이 없습니다.</td></tr>
			         </c:if>
			         </tbody>
			        </table>
			        </div>
			      </div>
			      <div class="modal-footer">
			        <button type="button" class="btn btn-outline-danger" data-dismiss="modal">닫기</button>
			        <button type="button" class="btn btn-outline-primary" data-dismiss="modal" id="modalSubmit">입력</button>
			      </div>
			    </div>
			  </div>
			</div>
		<!-- Modal -->
   </div>
</div>
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