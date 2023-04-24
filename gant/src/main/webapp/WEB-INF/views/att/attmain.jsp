<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>    
<head>
 <meta charset="utf-8">
   <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
  <link href="${pageContext.request.contextPath}/resources/css/home/home.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/att_css/main.css">
<title>근태관리</title>
<script>

	$(document).ready(function(){
	
		
		//출퇴근버튼 체크 ${checkbutton} == "true"이면 출근버튼 비활성화 / "false" 이면 퇴근버튼 비활성화
		let checkbutton = ${checkbutton};
		console.log("checkbutton = "+checkbutton);
		if(checkbutton == true){ // 출근버튼 비활성화
			$("#start").attr("disabled", true); 
			$("#start").attr('class','btn btn-outline-primary '); // 출근버튼 회색으로 
			$("#end").attr("disabled", false); // 퇴근버튼 활성화
			$("#end").attr('class','btn btn-primary '); // 퇴근버튼 파란색으로 
		}else if(checkbutton == false){ //  퇴근버튼 비활성화
			$("#start").attr("disabled",false);
			$("#start").attr('class','btn btn-primary '); // 출근버튼 파란색으로
			$("#end").attr("disabled",true); // 퇴근버튼 비활성화
			$("#end").attr('class','btn btn-outline-primary '); // 퇴근버튼 회색으로
		}
		
		// 출근버튼 클릭시
		$("#start").click(function(){
			// 현재시간 구하기
			let today = new Date(); 
			let hours = today.getHours(); // 시
			let minutes = today.getMinutes();  // 분
			let seconds = today.getSeconds();  // 초
			 // 시 분 초 가 1의 자리일때 두번째자리는 0 이 붙는다. 01 : 02 : 13
	        let th = hours;
	        let tm = minutes;
	        let ts = seconds;
	        if(th<10){
	        th = "0" + hours;
	        }
	        if(tm < 10){
	        tm = "0" + minutes;
	        }
	        if(ts < 10){
	        ts = "0" + seconds;
	        }
			
			let CurrenTime = th+":"+ tm +":"+ts; //시 : 분 : 초
			console.log("출근시간 : "+CurrenTime);
			const data = {startTime : CurrenTime ,checkbutton : "startbutton" }; //json 형식으로 출근시간을 넘겨준다.
			$.ajax({
				   data : data,
				   url :  "TimeUpdate",
				   dataType : "json" , 
				   success : function(data){
					   alert(data.success);
					 //퇴근버튼 활성화 , 출근버튼 비활성화 
					   $("#start").attr("disabled", true); 
					   $("#start").attr('class','btn btn-outline-primary '); // 출근버튼 회색으로 
					   $("#end").attr("disabled", false); // 퇴근버튼 활성화
					   $("#end").attr('class','btn btn-primary '); // 퇴근버튼 파란색으로
					   
				   }, //success end
				   error: function( request, status, error ){
					    alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);

					   }
				     
			   }) // ajax end
			
		 }); // 출근버튼이벤트 end
		
			
		
		
		//퇴근버튼클릭시
		  $("#end").click(function(){
			// 현재시간 구하기 - > 퇴근시간 구하기 
				let today = new Date(); 
				let hours = today.getHours(); // 시
				let minutes = today.getMinutes();  // 분
				let seconds = today.getSeconds();  // 초
				 // 시 분 초 가 1의 자리일때 두번째자리는 0 이 붙는다. 01 : 02 : 13
		        let th = hours;
		        let tm = minutes;
		        let ts = seconds;
		        if(th<10){
		        th = "0" + hours;
		        }
		        if(tm < 10){
		        tm = "0" + minutes;
		        }
		        if(ts < 10){
		        ts = "0" + seconds;
		        }
				
				let CurrenTime = th+":"+ tm +":"+ts; //시 : 분 : 초
				console.log("퇴근시간 : "+ CurrenTime);
				let	work_week = $('#work_week').text(); // 화면에 기록되어있는 주간 총 근무시간도 넘겨준다. - > 하루 총 근무시간을 더해주기 위해서이다.				
				const data = { endTime : CurrenTime ,checkbutton : "endbutton", work_week : work_week }; //json 형식으로 출근시간을 넘겨준다.
				$.ajax({
					   data : data,
					   url :  "TimeUpdate",
					   dataType : "json" ,
					   success : function(data){
						$('#work_today').text(data.work_today);
						$('#work_week').text(data.work_week);
						$('#overtime').text(data.overTime);
						  alert("퇴근등록되었습니다.");
						 //퇴근버튼 비활성화 , 출근버튼 활성화 
						$("#start").attr("disabled",false);
					    $("#start").attr('class','btn btn-primary '); // 출근버튼 파란색으로
						$("#end").attr("disabled",true); // 퇴근버튼 비활성화
						$("#end").attr('class','btn btn-outline-primary '); // 퇴근버튼 회색으로 
						
						// 나의 주간 근무 현황(%) -> 하루 점심시간 1시간씩 포함하여 하루9시간 , 주 5일 근무로 주간 총 근로시간이 45시간이 된다면 100센트로나타나게 한다.
						  let work_week_hours = data.work_week_hours;
					      let h = Number(work_week_hours);
					      let work_percent = Math.floor(h/45*100); // 전체값의 일부값은 = 일부값/전체값*100 -> 퍼센트 구하는 공식
					      $("#work_percent").css({"width":work_percent+"%"});
					      
						
					   }, //success end
					   error: function( request, status, error ){
						    alert("status : " + request.status + ", error : " + error);

						   }
					     
				   }) // ajax end 
		
		  });// 퇴근버튼이벤트 end
		  
		  
		  // 나의 주간 근무 현황(%) -> 하루 점심시간 1시간씩 포함하여 하루9시간 , 주 5일 근무로 주간 총 근로시간이 45시간이 된다면 100센트로나타나게 한다.
		  let work_week_hours = ${work_week_hours};
	      let h = Number(work_week_hours);
	      let work_percent = Math.floor(h/45*100); // 전체값의 일부값은 = 일부값/전체값*100 -> 퍼센트 구하는 공식
	      $("#work_percent").css({"width":work_percent+"%"});
	      $("#my_week").text("나의 주간 근무 현황 ("+work_percent+"%)");
	      
	      
	   // 나의 휴가 현황(%) -> 기본 휴가 15개로 산정한다. 
	      let vacation_num = ${vacation_num};
	      let vnum = Number(vacation_num);
	      let vacation_percent = Math.floor(vnum/15*100); // 포함값/전체값*100 -> 퍼센트 구하는 공식
	      $("#vacation_percent").css({"width":vacation_percent+"%"});
	      $("#my_vacation").text("나의 휴가 현황 (남은 휴가 갯수:"+vacation_num+")");
	      

	    // 초과근무신청 버튼 이벤트 팝업창 생성
	    $("#commute_record").click(function(){
	          //overtime.jsp 팝업창으로 띄우기
	    	  var overtime_popup = window.open('commute_record', '초과근무수당신청서', 'width=1000px,height=600px');	    	  
	    });
	      
	      
	});

</script>
</head>
<body>
<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4">


		<div class="main">
			<div class="container mt-3">
               
              
               
                <div class="watch">            
		               <div id="watch_names">
		               <span class="watch_name">주간 총 근무시간</span>
		               <span class="watch_name">&nbsp;&nbsp;오늘 총 근무시간</span>
		               <span class="watch_name">&nbsp;초과 총 근무시간</span>
		               </div>
                            <span class="swa_dial">
                                <span id="work_week">${work_week}</span>                     
                            </span> 
                               
                            <span class="swa_dial">
                                 <span id="work_today">00:00:00</span>                            
                            </span>

                            <span class="swa_dial">
                              <span id="overtime">00:00:00</span>           
                            </span>
                </div> 
                           
               <div id="workbutton">
                      <div id="gotowork">                 
                     <button  type="button" class="btn btn-primary " id="start">출근</button>
                     </div>
                     <div id="leavework">
                     <button type="button" class="btn btn-primary " id="end" >퇴근</button>
                     </div>
               </div>       
          
          
           <div id="work">  
          <button  type="button" class="btn btn-primary " id="commute_record">근태기록</button>
            <h6 id="my_week">나의 주간 근무 현황</h6>
		      <div class="progress">
		       <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="50"
		        id="work_percent" aria-valuemin="0" aria-valuemax="100" >
		     
             </div>
            </div>
          </div>
          
           <div id="work" class="vacationbox">  
            <h6 id="my_vacation">나의 휴가 현황</h6>
		      <div class="progress">
		       <div class="progress-bar progress-bar-striped" role="progressbar" aria-valuenow="50"
		       id="vacation_percent"  aria-valuemin="0" aria-valuemax="100" >
		     
             </div>
            </div>
          </div>
     </div>    
		
		
		</div> <%-- class main end --%>
	</div> <%-- class row end --%>
   </div><!-- class content -->
   
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>

</body>
</html>