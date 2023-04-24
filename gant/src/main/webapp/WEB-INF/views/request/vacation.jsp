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
		    if($(this).val() == "초과근무신청서"){
		    	 location.href="writeOvertime"
		    }
		   
         });
    	  
    	  
    	  
    	  
    	  
    	  $.datepicker.setDefaults($.datepicker.regional['ko']);
          
    	  $( "#startDate" ).datepicker({
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
               maxDate: 365,      // 선택할수있는 최대날짜, (1년 이후 날짜 선택 불가)
               minDate:0,//선택할수있는 최소 날짜 ( 오늘 이후 날짜 선택 불가))
               onClose: function( selectedDate ) {    
                   //시작일(startDate) datepicker가 닫힐때
                   //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
                  $("#endDate").datepicker( "option", "minDate", selectedDate );
              }   
          });  
          
    	  $( "#endDate" ).datepicker({
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
              maxDate: 500,           // 선택할수있는 최대날짜, ( 500일 이후 날짜 선택 불가)
              minDate:0, //선택할수있는 최소 날짜 ( 오늘 이후 날짜 선택 불가))
              onClose: function( selectedDate ) {    
                  // 종료일(endDate) datepicker가 닫힐때
                  // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
                  $("#startDate").datepicker( "option", "maxDate", selectedDate );
              }   
         }); 
    	  
         //submit click 이벤트 
         $("#submit").click(function(){
		    	
        	//공백 검사 
         	if($("#startDate").val() == ""){
		    		alert('휴가 시작일을 선택하세요.');
		    		$("#startDate").focus();
					return false;
		    	}
		    	
         	if($("#endDate").val() == ""){
		    		alert('휴가 종료일을 선택하세요.');
		    		$("#endDate").focus();
					return false;
		    	}
         	
         	if($("#emergency_one").val() == ""){
		    		alert('비상연락망을 입력하세요');
		    		$("#emergency_one").focus();
					return false;
		    	}
         	
         	
         	if($("#emergency_two").val() == ""){
		    		alert('비상연락망을 입력하세요');
		    		$("#emergency_two").focus();
					return false;
		    	}
         	
         	if($("#emergency_three").val() == ""){
		    		alert('비상연락망을 입력하세요');
		    		$("#emergency_three").focus();
					return false;
		    	}
         	
         	if($("#details").val() == ""){
		    		alert('세부사항을 입력하세요');
		    		$("#details").focus();
					return false;
		    	}
         	
         	
         	if($("#reference_person").val() == ""){
	    		alert('참조자를 선택하세요');
				return false;
	    	}
         
		  });
         
         // 휴가 시작날짜 입력시 유효성 검사
         $('#startDate').keyup(function(){
         	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
         	// 년도4자리 월2자리 일 자리	
     		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
     		const domain = $(this).val();
     		if(!pattern.test(domain)){
     			alert('날짜 형식에 맞게 입력하여 주세요');
     			$(this).val("").focus();
     		}
         	}
     	}); 
         
         // 휴가 종료날짜 입력시 유효성 검사
         $('#endDate').keyup(function(){
         	if($.trim($(this).val()).length == 8){ // 입력값이 8자리가 되었을때 실행
         	// 년도4자리 월2자리 일 자리	
     		const pattern = /^[0-9]{4}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
     		const domain = $(this).val();
     		if(!pattern.test(domain)){
     			alert('날짜 형식에 맞게 입력하여 주세요');
     			$(this).val("").focus();
     		}
         	}
     	});
         
         //전화번호 입력시 유효성 검사
         $('#emergency_one').keyup(function(){
         	if($.trim($(this).val()).length == 3){ // 입력값이 8자리가 되었을때 실행
         	// 년도4자리 월2자리 일 자리	
     		const pattern = /^[0-9]{3}$/;
     		const domain = $(this).val();
     		if(!pattern.test(domain)){
     			alert('형식에 맞게 숫자로 입력하여 주세요');
     			$(this).val("").focus();
     		}else{
     			$('#emergency_two').focus();
     		}
         	}
     	});
         
         $('#emergency_two').keyup(function(){
         	if($.trim($(this).val()).length == 4){ // 입력값이 8자리가 되었을때 실행
         	// 년도4자리 월2자리 일 자리	
     		const pattern = /^[0-9]{4}$/;
     		const domain = $(this).val();
     		if(!pattern.test(domain)){
     			alert('형식에 맞게 숫자로 입력하여 주세요');
     			$(this).val("").focus();
     		}else{
     			$('#emergency_three').focus();
     		}
         	}
     	});
         
         $('#emergency_three').keyup(function(){
         	if($.trim($(this).val()).length == 4){ // 입력값이 8자리가 되었을때 실행
         	// 년도4자리 월2자리 일 자리	
     		const pattern = /^[0-9]{4}$/;
     		const domain = $(this).val();
     		if(!pattern.test(domain)){
     			alert('형식에 맞게 숫자로 입력하여 주세요');
     			$(this).val("").focus();
     		}else{
     			$('#details').focus();
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
            
            
            //휴가 종류 선택시 직접입력을 선택하지 않았을때
            $("#selboxDirect").hide();
           //휴가 종류 선택시 직접입력을 선택했을때
            $("#division").change(function() {
                   //직접입력을 누를 때 나타남
                  if($("#division").val() == "direct") {
                      $("#selboxDirect").show();
                      $('#selboxDirect').prop('required', true);
                      $('#division').removeProp('required');
                  }  else {                	 
                	  $("#selboxDirect").hide();
                	  $('#selboxDirect').removeProp('required');
                	  $('#division').prop('required', true);
                  }
              })    
              
              //모달 스크롤 
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
			          <h4 class="card-title" style="color: white">휴가신청서</h4>
			        </div>
			        <div class="card-body">
			  <form action=vacationAction method="post">
			     
			   <div class="form-group">
			    <label for="Classification">서류선택</label>
			
			                                <select class="form-control" id="floatingSelect"
			                                    aria-label="Floating label select example" name="classification">
			                                    <option value="초과근무신청서">초과근무신청서</option>
			                                    <option value="휴가신청서" selected>휴가신청서</option>
			                                </select>
			                            
			   </div> 
			   
			    <div class="form-group">
			    <label for="Classification">휴가종류</label>
			
			                                <select class="form-control"  required
			                                    aria-label="Floating label select example" name="division" id="division">
			                                    <option value="" selected>선택</option>
			                                    <option value="연차">연차</option>
			                                    <option value="병가">병가</option>
			                                    <option value="출산휴가">출산휴가</option>
			                                    <option value="direct">직접입력</option>
			                                </select>
			                                &nbsp; 
			                                <input type="text" class="form-control" id="selboxDirect" name="division_direct">                                               
			   </div>   
			  
		    
			   <div class="form-group">
			    <label for="vacation">휴가기간</label>
			    <div class="input-group mb-3">
			    <input type="text" class="form-control" name="start_date" id="startDate" placeholder="휴가 시작일">&nbsp;~&nbsp;
			    <input type="text" class="form-control" name="end_date" id="endDate" placeholder="휴가 종료일">
			   </div>
			   </div>
			  
			    <div class="form-group">
			    <label for="emergency">비상연락망</label>
			    <div class="input-group mb-3">
			    <input type="text" class="form-control emergency" name="emergency_one" id="emergency_one" placeholder="010" maxlength="3"> &nbsp;- &nbsp;
			    <input type="text" class="form-control emergency" name="emergency_two" id="emergency_two" placeholder="0000" maxlength="4">&nbsp;- &nbsp;
			    <input type="text" class="form-control emergency" name="emergency_three" id="emergency_three" placeholder="0000" maxlength="4">
			   </div>
			   </div>
			
			   <div class="form-group">
			      <label for="details">세부사항</label>
			      <textarea name="details" id="details"   
			                rows="10" class="form-control" ></textarea>
			   </div> 
			   
			   
			   
			    <div class="form-group">
			      <label >참조자</label>
			      
			         <div class="input-group mb-3">
			        <input type="text" class="form-control" id="reference_person" readonly>
			        <input type="hidden" class="form-control" id="reference_person_id" name="reference_person">
					<button type="button" class="btn btn-outline-primary" data-toggle="modal" data-target="#myModal">
					  명단 검색
					</button>
			        </div>
			
			   </div> 
			   
			    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">  
			    <div class="form-group">
			    <button type="submit" class="btn btn-outline-primary m-2 float-right" id="submit">신청</button>
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