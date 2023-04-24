
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import = "com.gant.myhome.domain.ProjectCalendar" %>
<%@ page import = "java.util.*" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import = "org.json.simple.JSONObject" %>


<%
	JSONArray list = (JSONArray)request.getAttribute("event");
	String p_no = (String)request.getAttribute("p_no");
	

%>
	
	
	




<html>


<head>

<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">

<title>일정 공유 캘린더</title>


<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
var jq1 = jQuery.noConflict();


</script>

<!-- bootstrap 4 -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">

<script	src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>





<link href="${pageContext.request.contextPath}/css/home/home.css" rel="stylesheet" type="text/css">
<!-- fullcalendar -->

<link href="${pageContext.request.contextPath}/calendar/lib/main.css"	rel='stylesheet' />
<script type="text/javascript"
	src="${pageContext.request.contextPath}/calendar/lib/main.js"></script>







<style>
@import
	url('https://fonts.googleapis.com/css2?family=Lato&display=swap');
.btn-check:checked+.btn-outline-primary, .btn-check:active+.btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show {
    color: white !important;
}
label.btn.btn-outline-primary:hover {
    color: white;
}
body {
	font-size: 14px;
	background-color: white;
	
}

#file {
  border-top-left-radius: 5px !important;
  border-bottom-left-radius: 5px !important;
}

#loginid{
	display: none;
}

.fc-button-primary{
background-color: #009CFF !important;
border-color: #009CFF !important;
}
.fc-toolbar-title {
	font-size: 20px !important;
}

#calendar {
	
	margin: 50px 300px 50px 150px;
	
}

.fc-day-sun a {
	color: red !important;
	text-decoration: none;
}

/* 토요일 날짜 파란색 */
.fc-day-sat a {
	color: blue !important;
	text-decoration: none;
}

</style>


<meta charset='utf-8' />


<script>

 
 var g_arg;	//이벤트 글로벌 변수(모달창에서 호출하는 함수에서 참조하기 위함)
 var calendar = null;
 var i=0;
 var all_events=null;


	var token = jq1("meta[name='_csrf']").attr("content");
	var header = jq1("meta[name='_csrf_header']").attr("content");
	

	
 jq1(document).ready(function() {
	    	

	 
            jq1('#xbutton').on('click', function(){
                jq1('#calendarModal').modal('hide');
            })
            jq1('#sprintSettingModalClose').on('click', function(){
                jq1('#calendarModal').modal('hide');
            })
            
            
            jq1('.col-form-label').css('font-weigth','bold !important');
  


			
        var calendarEl = document.getElementById('calendar');
            

       var all_events = <%=list%>;
       var p_no = <%=p_no%>;
       
        

		console.log("p_no");
		console.log(p_no);
				
		console.log("all_events");
		console.log(all_events);
		console.log(all_events.length);
		
		//all_events = list;
	
		//넘어오는 글제목 title
		//admin

		var loginid = jq1("#loginid").text();		
		
		console.log("loginId");
		console.log(loginid);
		



	    calendar = new FullCalendar.Calendar(calendarEl, {
	    	
	          editable: false,
	          droppable: false,
	          

	    
	    

           headerToolbar: {
               left: 'prev,next,today,addEventButton',

                right: 'dayGridMonth',
                center: 'title'

             },




			
	          customButtons: {
	        	  
                  addEventButton: { // 추가한 버튼 설정



      				
                      text : "일정 추가",  // 버튼 내용
                      click : function(){ 
                    	  // 버튼 클릭 시 이벤트 추가
                    	  
						jq1('#calendarModal #addCalendar')
                		.css('display', 'inline');
                    	  
                          jq1("#calendarModal").modal("show"); // modal 나타내기

                  		
                          jq1('#calendarModal #modifyCalendar').css('display', 'none');
            				jq1('#calendarModal #deleteCalendar').css('display', 'none');
            				jq1('#calendar_title').val('');
                          jq1('#calendar_content').val('');
                          jq1('#calendar_start_date').val('');
                          jq1('#calendar_end_date').val('');
                          
                          jq1("#calendarModal #calendar_title").attr("readonly",false); 

                          jq1("#addCalendar").off("click").on("click",function(){  // modal의 추가 버튼 클릭 시
                        	  

                        	  
                        	  var title = jq1("#calendar_title").val();
                              var content = jq1("#calendar_content").val();
                              var start_date = jq1("#calendar_start_date").val();
                              
                              var end_date = jq1("#calendar_end_date").val();
                              var check = 0; // 조건에 걸리는지 확인
                              
                              console.log("title");
                              console.log(title);
                              
                              console.log("content");
                              console.log(content);
                              
                              console.log("end_date");
                              console.log(end_date);
                              
                              console.log("start_date");
                              console.log(start_date);

                              
                            	for(var j=0;j<all_events.length;j++)
                        		{
                                    var idcheck = all_events[j].id;
                                    
                        			if(  idcheck == title && idcheck != null)
                        			{           
                        				
                        				check = 1;
                        				
                        			}
                        		}
							

                              //내용 입력 여부 확인
                              if(check == "1" || check == 1 ){
                    				alert("제목은 중복될 수 없습니다.");
                    				jq1('#calendar_title').val('');
                              }
                              else if( title == null || title == "" ){

                                  alert("내용을 입력하세요.");
                              }else if(content == null || content == ""){
                            	  alert("제목을 입력하세요.");
                              }else if(start_date == "" || end_date ==""){
                                  alert("날짜를 입력하세요.");
                              }else if(new Date(end_date)- new Date(start_date) < 0){ // date 타입으로 변경 후 확인
                                  alert("종료일이 시작일보다 먼저입니다.");
                              }else{ // 정상적인 입력 시
                                 
                           var m_end = new Date(end_date.substr(0, 4), end_date.substr(5, 2)-1, end_date.substr(8, 2));
                              
 
                                  
                           m_end.setDate(m_end.getDate()+1);
                                  
                           console.log(end_date);
                           console.log(m_end);
                           console.log(m_end.getFullYear());
                           console.log(m_end.getMonth()+1);
                                 
                                 
                           if(m_end.getMonth()+1 < 10 && m_end.getDate() < 10){
                              	 var m_end_dt = m_end.getFullYear() + '-0' + (m_end.getMonth()+1) + '-0' + m_end.getDate();	 
                           }
                           else if (m_end.getMonth()+1 < 10 && m_end.getDate() >= 10  )
                           {
                            	var m_end_dt = m_end.getFullYear() + '-0' + (m_end.getMonth()+1) + '-' + m_end.getDate();	  	 
                           }
                           else if(m_end.getMonth()+1 >= 10 && m_end.getDate() < 10)
                           {
                            	var m_end_dt = m_end.getFullYear() + '-' + (m_end.getMonth()+1) + '-0' + m_end.getDate();
                           }
                           else if(m_end.getMonth()+1 >= 10 && m_end.getDate() >= 10)
                           {
                            	var m_end_dt = m_end.getFullYear() + '-' + (m_end.getMonth()+1) + '-' + m_end.getDate();
                           }

                           
                           var obj = 
                           {
                        			"id" : title,
                        			"name" : loginid,

																			"title" : content,
																			"start" : start_date,
																			"end" : m_end_dt,
																			"allDay" : true,
																			"p_no" : p_no
																		}//전송할 객체 생성

																		console
																				.log(m_end_dt);
																		console
																				.log('obj = '
																						+ obj);
																		adddata(obj);
																		
																		if (obj != null)
																			i++;

																		calendar
																				.addEvent({
																					id : title,
																					title : content,
																					start : start_date,
																					end : m_end_dt,
																					allDay : true
																				})

																		/*
																		var allEvent =	 calendar.getEvents();
																		
																		console.log('allEvent[0] = ');
																		console.log(allEvent[0].title);
																		console.log(allEvent[0].start);
																		console.log(allEvent[0].end);
																		console.log(allEvent[0].allDay);
																		
																		
																		var startevent = moment(allEvent[0]._instance.range.start).format("YYYY-MM-DD");
																		var endevent = moment(allEvent[0]._instance.range.end).format("YYYY-MM-DD");
																		
																		//allday의 start end를 yyyy-mm-dd로 가공
																		
																		console.log('startevent');
																		console.log(startevent);

																		console.log('endevent');
																		console.log(endevent);
																		 */

																	}
								jq1(
								'#calendarModal')
								.modal(
										'hide');
																});

											}
										}
									},

									initialView : 'dayGridMonth',
									editable : false,
									displayEventTime : false,
									dayMaxEvents : true,
									locale : 'ko',
									events : all_events,
											
									buttonText : {
										today : '오늘',
										month : '달력',
										list : '일정'

									},

									eventAdd : function(obj) {

										console.log(obj);
										console.log('추가');

									},
									eventChange : function(obj) {
										console.log(obj);
										console.log('수정');

									},
									eventRemove : function(obj) {
										console.log(obj);
										console.log('삭제');

									},
									eventClick : function(arg) {
										
										jq1('#calendarModal #modifyCalendar')
												.css('display', 'inline');
										jq1('#calendarModal #deleteCalendar')
												.css('display', 'inline');
										

										
										var arg_name, arg_admin; 
										
										for(var j=0;j<all_events.length;j++)
										{
											
											if(all_events[j].title == arg.event.title)
											{
												
												arg_name = all_events[j].name;
												//admin을 calendar 테이블에 입력하는게 아니라
												//로그인 한 아이디의 admin 여부를 판별해야함
												
												//admin을 calendar 테이블에 입력하는게 아니라
												//로그인 한 아이디의 admin 여부를 판별해야함
		
											}	
										}
										
										
										
										arg_admin = getadmin(loginid);
										hostid = gethostid(p_no);
		
										console.log("admin 여부");
										console.log(arg_admin);
										
										
										
										console.log("arg_name 글 쓴 사람 id");
										console.log(arg_name);
																				
										console.log("loginid");
										console.log(loginid);
										
										console.log("hostid");
										console.log(hostid);
										
										
										insertModalOpen(arg, arg_admin, arg_name, loginid, hostid);//이벤트 클릭 시 모달 호출

									}

								});
						calendar.render();
					});(jQuery);
					




	function adddata(jsondata) {
		
		console.log("추가하기 위해 넘겨받은 jsondata")
		console.log(jsondata);
		
		jq1.ajax({
			type : 'POST',
			url : '${pageContext.request.contextPath}/pcalendar/add',
			data : jsondata,
			dataType : "text",
			async : true,
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
			success : function(rdata) {
				console.log('db 저장 완료.');
				//document.location.reload();
			},
			error : function(request, status, error) {
			},
			complete : function() {
			}
		})
	}

	function updatedata(arg, p_no) {

		var title = jq1("#calendar_title").val();
		var content = jq1("#calendar_content").val();
		var start_date = jq1("#calendar_start_date").val();
		var end_date = jq1("#calendar_end_date").val();
		var check = 0;
		
		console.log("start_date");
		console.log(start_date);

 
		if( title == null || title == "" ){

			alert("내용을 입력하세요.");

		} else if (start_date == "" || end_date == "") {
			alert("날짜를 입력하세요.");
		} else if (new Date(end_date) - new Date(start_date) < 0) { // date 타입으로 변경 후 확인
			alert("종료일이 시작일보다 먼저입니다.");
		} else { // 정상적인 입력 시

			var m_end = new Date(end_date.substr(0, 4),
					end_date.substr(5, 2) - 1, end_date.substr(8, 2));

			m_end.setDate(m_end.getDate() + 1);

			console.log(end_date);
			console.log(m_end);
			console.log(m_end.getFullYear());
			console.log(m_end.getMonth() + 1);

			if (m_end.getMonth() + 1 < 10 && m_end.getDate() < 10) {
				var m_end_dt = m_end.getFullYear() + '-0'
						+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
			} else if (m_end.getMonth() + 1 < 10 && m_end.getDate() >= 10) {
				var m_end_dt = m_end.getFullYear() + '-0'
						+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
			} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() < 10) {
				var m_end_dt = m_end.getFullYear() + '-'
						+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
			} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() >= 10) {
				var m_end_dt = m_end.getFullYear() + '-'
						+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
			}
		}

		var data = {

			"title" : content,
			"id" : title,
			"start" : start_date,
			"end" : m_end_dt,
			"allDay" : true,
			"p_no" : p_no
		};

		console.log(data);

		jq1.ajax({
			url : "${pageContext.request.contextPath}/pcalendar/update",
			type : "POST",
			data : data,
			dataType : "text",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},

			success : function(data) {

				jq1('#calendarModal').modal('hide');
				document.location.reload();
				console.log("event 수정 완료");
				

				g_arg = null;
				
			},
			error : function(data) {
				//alert(xhr.responseText);
				jq1('#calendarModal').modal('hide');
				alert('일정 수정 실패, 새로고침 후 재시도 해주세요');
				//document.location.reload();
			}
		});
	
	}

	function insertModalOpen(arg, admin, name, loginid, hostid) {

		jq1('#calendarModal #addCalendar').css('display', 'none');
		jq1("#calendarModal #calendar_title").attr("readonly",true); 

		
				
		if(!(name.equals(hostid) || name.equals(loginid) ||  admin.equals("true")))
		{
            jq1('#calendarModal #modifyCalendar').css('display', 'none');
			jq1('#calendarModal #deleteCalendar').css('display', 'none');
		}

		g_arg = arg;

		var m_end = new Date(g_arg.event.endStr.substr(0, 4),
				g_arg.event.endStr.substr(5, 2) - 1, g_arg.event.endStr.substr(8, 2));
		
		m_end.setDate(m_end.getDate()-1);

		console.log(m_end);
		console.log(m_end.getFullYear());
		console.log(m_end.getMonth() + 1);

		if (m_end.getMonth() + 1 < 10 && m_end.getDate() < 10) {
			var m_end_dt = m_end.getFullYear() + '-0'
					+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
		} else if (m_end.getMonth() + 1 < 10 && m_end.getDate() >= 10) {
			var m_end_dt = m_end.getFullYear() + '-0'
					+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
		} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() < 10) {
			var m_end_dt = m_end.getFullYear() + '-'
					+ (m_end.getMonth() + 1) + '-0' + m_end.getDate();
		} else if (m_end.getMonth() + 1 >= 10 && m_end.getDate() >= 10) {
			var m_end_dt = m_end.getFullYear() + '-'
					+ (m_end.getMonth() + 1) + '-' + m_end.getDate();
		}
		
		console.log("m_end_dt");
		console.log(m_end_dt);
		
		//console.log(g_arg.event.start.getHours()+':'+g_arg.event.start.getMinutes());
		
		//값이 있는경우 세팅
		if (g_arg.event != undefined) {

			
			jq1('#calendarModal #calendar_title').val(g_arg.event.id);
			jq1('#calendarModal #calendar_content').val(g_arg.event.title);
			jq1('#calendarModal #calendar_start_date').val(g_arg.event.startStr);
			jq1('#calendarModal #calendar_end_date').val(m_end_dt);

		}
		//모달창 show
		jq1('#calendarModal').modal('show');

	}

	
	function deletecal(arg, p_no) {
		
		console.log(p_no);
		
		if (confirm('일정을 삭제하시겠습니까?')) {
			var data = {
				"title" : arg.event.title,
				"id" : arg.event.id,
				"p_no" : p_no
				
			};

			console.log("data");
			console.log(data);

			//DB 삭제

			jq1.ajax({
				url : "${pageContext.request.contextPath}/pcalendar/delete",
				type : "POST",
				data : data,
				dataType : "text",
				beforeSend : function(xhr)
	  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},

				success : function(data) {

					arg.event.remove();
					jq1('#calendarModal').modal('hide');
					console.log("event.remove 완료");

					g_arg = null;
				},
				error : function(data) {
					//alert(xhr.responseText);
										
					alert('일정 삭제 실패 새로고침 후 재시도 해주세요');
					jq1('#calendarModal').modal('hide');
					//document.location.reload();
				}
			});
			//
		}
	}
	
	function getadmin(loginid) {
			var admin2;
			
			var data2 = {
				"id" : loginid
			};
			
			console.log("admin 정보의 loginid");
			console.log(loginid);
			
			console.log("getadmin data의 data");
			console.log(data2);

			
			
			console.log(loginid);

			jq1.ajax({
				type : "POST",
				url : "${pageContext.request.contextPath}/pcalendar/getadmin",
				data : data2,
				dataType : "json",
				async: false,
				beforeSend : function(xhr)
	  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},

				success : function(data) {

					admin2 = data;
					
					console.log("admin");
					console.log(admin2);
					console.log("admin 가져오기 완료");
					
					
				},
				error : function(data) {
					//alert(xhr.responseText);
					console.log("실패 결과");
					console.log(data);
					jq1('#calendarModal').modal('hide');
					//document.location.reload();
					alert('admin 생성 실패');
				}
			});
			
			console.log("리턴 전 admin");
			console.log(admin2);
			
			return admin2;
			

		}
	
	function gethostid(p_no) {
		var host2;
		
		
		
		var data2 = {
			"p_no" : p_no
		};
		

		console.log(data2);


		jq1.ajax({
			type : "POST",
			url : "${pageContext.request.contextPath}/pcalendar/gethost",
			data : data2,
			dataType : "text",
			async: false,
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},

			success : function(data) {

				host2 = data;
				
				console.log("host2");
				console.log(host2);
				
				
			},
			error : function(data) {
				//alert(xhr.responseText);
				console.log("실패 결과");
				console.log(data);
				jq1('#calendarModal').modal('hide');
				//document.location.reload();
				alert('host 생성 실패');
			}
		});
		
		console.log("리턴 전 host2");
		console.log(host2);
		
		return host2;
		

	}
	
</script>


</head>


<body>

<jsp:include page="../home/side.jsp" />


<div class="content">


	<jsp:include page="../home/header2.jsp" />
	
	<div class="container-fluid pt-4 px-4">
	<div class="container">	
	    
    			<div class="btn-group" role="group">
                  <input type="radio" class="btn-check" name="btnradio" id="btnradio1">
                    <label class="btn btn-outline-primary" id="file" for="btnradio1" onclick="window.location.href='${pageContext.request.contextPath}/filebox/home?p_no=<%=p_no %>';" >파일 보관함</label>

                    <input type="radio" class="btn-check" name="btnradio" id="btnradio2" >
                    <label class="btn btn-outline-primary" for="btnradio2" onclick="window.location.href='${pageContext.request.contextPath}/todolist/receive?p_no=<%=p_no %>';">할일 리스트</label>

                    <input type="radio" class="btn-check" name="btnradio" id="btnradio3" checked>
                    <label class="btn btn-outline-primary" for="btnradio3" >캘린더</label>
                 </div>
    	<br><br>
    	</div>
    </div>
	

		<sec:authorize access="isAuthenticated()">
			<sec:authentication property="principal" var="pinfo"/>

		<div id='calendar'>
			<span id="loginid">${pinfo.username}</span>
		</div>
			</sec:authorize>

		<div class="container-fluid pt-4 px-4">		</div>
</div>






	<!-- modal 추가 -->
	
	<div class="modal fade insertModal" id="calendarModal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">일정을 입력하세요.</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" id="xbutton">
						<span aria-hidden="true">&times;</span>
					</button>

				</div>
				<div class="modal-body">
					<div class="form-group">
						<label for="taskId" class="col-form-label" style="font-weight:bold">일정 제목</label> 
						<input type="text" class="form-control" id="calendar_title"	name="calendar_title">
						 
						<label for="taskId"	class="col-form-label" style="font-weight:bold">일정 내용</label> 
						<input type="text" class="form-control" id="calendar_content" name="calendar_content">
						 
						<label for="taskId" class="col-form-label" style="font-weight:bold">시작 날짜</label> 
						<input type="date" class="form-control" id="calendar_start_date" name="calendar_start_date">
						
						<label for="taskId"	class="col-form-label" style="font-weight:bold">종료 날짜</label> 
						<input type="date" class="form-control" id="calendar_end_date" name="calendar_end_date">
							
					</div>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-success" id="modifyCalendar"
						onclick="updatedata(g_arg,<%=p_no%>)">수정</button>
					<button type="button" class="btn btn-danger" id="deleteCalendar"
						onclick="deletecal(g_arg,<%=p_no%>)">삭제</button>

					<button type="button" class="btn btn-secondary" id="addCalendar">추가</button>

					<button type="button" class="btn btn-dark" data-dismiss="modal"
						id="sprintSettingModalClose" data-backdrop="static"
						data-keybord="false">닫기</button>
				</div>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
			</div>
		</div>
	</div>

<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>

<script>


</script>

</body>

</html>
