<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta http-equiv="page-enter" content="blendTrans(duration=0.3)">
<meta http-equiv="page-exit" content="blendTrans(duration=0.3)">
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel="stylesheet" href="../css/reserve/style.css">
	<link rel="stylesheet" href="../css/pmain/style.css"> <!-- 예약인원 모달 :프로젝트인원모달과 동일-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}
#mylist_head {
  margin: 30px 0px 30px 10px;
}
#mylist_head span {
  color: black;
  font-size: 18px;
}
#mylist_head input:focus{
	border:2px solid #26abff;
	outline:none;
	
}
#mylist_head span:first-child{
  font-weight: bold;
margin-right: 20px;
}
#start_day + img + span {
	margin:0px 20px 0px -5px
}
#start_day , #end_day{
	box-sizing:border-box;
	padding:15px;
	width:181px;
	height: 40px;
	border:1px solid #ced4da;
	border-radius:4px;
}

#mylist_head button{
	height:40px;
	background:#3abff7;
	color:white;
	width:60px;
	font-weight:bold;
	font-size:18px !important;
	position:relative;
	right:25px;
	outline:none;
	border-radius:4px !important;
	border:1px solid #3abff7;
}
img.ui-datepicker-trigger, img.ui-datepicker-trigger {
    width: 25px;
    height: 25px;
    position: relative;
    right: 42px;
    bottom: 3px;
}
	
.persons li a img {
 border-radius: 50%;
 max-width: 100%; 
}
a {
  -webkit-transition: .3s all ease;
  -o-transition: .3s all ease;
  transition: .3s all ease; 
}
a, a:hover {
    text-decoration: none !important; 
}
.persons {
    padding: 0;
    margin: 0; }
.persons{
	height:36px
}
.persons li {
      padding: 0;
      margin: 0 0 0 -15px;
      list-style: none;
      display: inline-block;
      position:relative;
      bottom:7px;
       }
.persons li a {
        display: inline-block;
      	cursor:pointer;
        width: 36px; 
}
#notable{
	margin-top:39px;
	text-align:center;
	height:350px;
	border:1px solid #ced4da;
}
#notable > h4{
	height:100%;
	line-height:350px;
}
.list_table {
        	color:black !important;
}
.list_table span{
        	font-size:24px;
        	position:relative;
        	cursor:pointer;
        	left:18px;
}
#hidden_show{
	border:none;
	border-radius:4px;
	background:transparent;
	color:white;
	position:relative;
	bottom:15px;
}
#hidden_show img {
	width:40px;
	height:40px;
}
#nouse{
	width:10px;
	height:40px;
}
	</style>
<script>
$(document).ready(function(){
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	//조회한 날짜가 다시 새로고침되어도 표시되게, ajax로 보낼 때 날짜도 보내도록
	let start_day = '${start_day}';
	let end_day = '${end_day}';
	if(start_day){
		$("#start_day").val(start_day);
	}
	if(end_day){
		$("#end_day").val(end_day);
	}
	//DatePicker
	 $('#start_day, #end_day').datepicker({
		   	dateFormat: 'yy-mm-dd',
		   	showOn:"button",
            buttonImage:"../resources/image/reserve/calendar6.png",
            buttonImageOnly:true,
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        showOtherMonths: true,
	        yearSuffix: '년',
	        minDate: "0D",
	        maxDate: "+1M",
	        todayHighlight :true,
		    onSelect: function(dateString) {
		    	if($(this).attr('id')=='insert_day'){
		       		 $("#insert_day").trigger('change');
		       		 console.log("클릭되었따");
		    	}else if($(this).attr('id')=='update_day'){
		       		 $("#update_day").trigger('change');
		    	}
		    }
		});
	
	//검색할 때 유효성 검사
	$("#r_search").submit(function(){
		let start_day = $("#start_day").val().replaceAll("-","");
		let end_day = $("#end_day").val().replaceAll("-","");
		if(start_day>end_day){
			alert("조회 날짜형식이 올바르지 않습니다.");
			return false;
		}
	});
	
	//현재행5개보다 보여줄 행이 적으면 안보이게
	 if("${count}" <= 5){
			$("#hidden_show").css('display','none');	
	 }
	//명단에 있는 사진 클릭
	$("body").on('click',".persons img, .person span",function(){
			let names = $(this).parent().parent().parent().parent().find('.names').val();
			
			$.ajax({
				url : "rmemberdetail",
				type: "post",
				dataType: "json",
				data : { "names" : names },
				beforeSend : function(xhr)
	  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},
	    		success : function(rdata){
	    			$(".detailtable").find("tbody").remove();
	    			let output = '';
	    			if(rdata!=null){
	    				output += "<tbody>"
	    				$(rdata).each(function(){
	    					console.log(this.profileimg +this.name+this.department+this.position+this.phone_num);
		    				output += "<tr><td>"
		    						+ '<div class="user-info">'
		    						+ 	'<div class="user-info__img">';
		    				if(this.profileimg==null){
		    				output +='<img src="../resources/image/member/defaultprofile.png" alt="User Img">';
		    				}else{
		    				output +='<img src="../resources/image/memberupload/'+this.profileimg+'" alt="User Img">';
		    				}
		    				output += 	'</div>'
		    						+ 	'<div class="user-info__basic">'
		    						+ 		'<h6 class="mb-0">'+this.name+'</h6>'
		    						+ 	'</div>'
		    						+ '</div>'
		    						+ '</td>'
		    						+ '<td><h6 class="mb-0">'+ this.department + '</h6></td>'
		    						+ '<td><h6 class="mb-0">'+ this.position + '</h6></td>'
		    						+ '<td><h6 class="mb-0">'+ this.phone_num + '</h6></td></tr>';
	    				});
	    				output += "</tbody>";
	    			}else{
	    				output += "<h5>예약참여 명단이 없습니다.</h5>";
	    			}
	    			$(".detailtable").append(output);
	    			
	    		}
			});	
			$("#detailmodal").modal('show');
		});
		$("#detail_close").click(function(){
			$("#detailmodal").modal('hide');
		});
		
		let page = 1; //더보기하기전은 1페이지!
		$("#hidden_show").click(function(){ //클릭하면 ajax로 다음페이지도 보여줌
			see_more(++page);
		});
		
		function see_more(page) {
			$.ajax({
					type : "post",
					url : "mylist_ajax",
					data : {
						"start_day" : start_day,
						"end_day" : end_day,
						"page" : page
					},
					dataType : "json",
					beforeSend : function(xhr)
	      			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	        			xhr.setRequestHeader(header, token);			
	        		},
					success : function(rdata) {
							let rowsize = 0;
							$(".list_table tbody").empty();
							$(rdata).each(function() {
								let output = '';
								console.log("조회해보자:"+this.name+this.type+this.resource_name+this.day+this.start_time+this.end_time);
								++rowsize;
								console.log("행개수:"+rowsize);
								output += '<tr class="alert" role="alert">'
								 		+ '<th scope="row">'+ this.name +'</th>'
										+ '<td>'+ this.type +'</td>'
										+ '<td>'+ this.resource_name + '</td>'
										+ '<td>'+ this.day+" "+ this.start_time + " ~ " + this.end_time+ '</td>'
										+ '<td>'+ '</td>'
										+ '<td><input type="hidden" class="names" value="'+ this.names + '">'
										+ '<ul class="persons">';
								
								var split_profile = this.profileimgs.split(",");
								for(var i=0; i<split_profile.length; i++){
									output += '<li><a>';
									if(i<5){
										if(split_profile[i]=='null'){
											output += '<img src="../resources/image/member/defaultprofile.png" class="img-fluid">';
										}else{
											output += '<img src="../resources/image/memberupload/'+ split_profile[i] +'" class="img-fluid">';
										}
									}else if(i==5){
										output += '<span>···</span>';
									}
									output += '</a></li>';
								}	
								output += '</ul></td></tr>';
								$('.list_table tbody').append(output);
								$(".list_table tbody tr:last").find("td:nth-child(5)").text(this.purpose);
							}); //each end
					//방금 보여준 행보다 보여줄 행이 적으면
					if("${count}"<=rowsize){
						$("#hidden_show").css('display','none');	
					}
					}//success
			});//ajax
		}//getList*/
});
</script>
</head>
<body>
<jsp:include page="../home/side.jsp" />


<div class="content">
<jsp:include page="../home/header2.jsp" />
	
	<div class="mylist">
	<h4>내 예약현황</h4>
	<hr>
	<form action="mylist" method="get" id="r_search">
	<div id="mylist_head">
	<span>조회기간</span><input type="text" name="start_day" id="start_day"><span>~</span><input type="text" name="end_day" id="end_day">
	<button type="submit">검색</button>
	</div>
	</form>
						<c:if test="${!empty list}">
						<table class="table list_table">
						  <thead>
						    <tr>
						      <th>예약자</th>
						      <th>종류</th>
						      <th>자원명</th>
						      <th>예약일시</th>
						      <th>예약목적</th>
						      <th>명단</th>
						    </tr>
						  </thead>
						  <tbody>
						  
						  <c:forEach var="rs" items="${list}">
						   <tr class="alert" role="alert">
						      <th scope="row">${rs.name}</th>
						      <td>${rs.type}</td>
						      <td>${rs.resource_name}</td>
							<td>${rs.day} ${rs.start_time} ~ ${rs.end_time}</td>
						      <td>${rs.purpose}</td>
							<td>
							<input type="hidden" class="names" value="${rs.names}">
							  <ul class="persons">
							  <!-- 참여명단 각 인원에 대한 프로필사진과 아이디값 가져옴 -->
							    <c:set var="split_profile" value="${fn:split(rs.profileimgs, ',')}"/>
							    <c:forEach var="part_profile" items="${split_profile}" varStatus="status">
							      <li>
							        <a>
							      <c:if test="${status.count < 6}">
							        	<c:if test="${part_profile =='null'}">
								   		<img src="../resources/image/member/defaultprofile.png" class="img-fluid">
							        	</c:if>
							        	<c:if test="${part_profile!='null'}">
								    	<img src="../resources/image/memberupload/${part_profile}" class="img-fluid">
							        	</c:if>
							      </c:if>
							      <c:if test="${status.count == 6}">
								      <span>···</span>
							      </c:if>
							        </a>
							      </li>
							    </c:forEach> 
							  </ul>
							  
							</td>
						    </tr>
						  </c:forEach>
						  </tbody>
						</table>
						 </c:if>
						 <c:if test="${empty list}">
						 <div id="notable">
						 <h4>예약내역이 없습니다.</h4>
						 </div>
						 </c:if>

	<button type="button" id="hidden_show"><img src="../resources/image/reserve/hiddenshowicon.png"></button>
	</div>
	<div id="nouse">
	</div>
<%-- 참여명단모달 창 --%>
<div class="modal" id="detailmodal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		 <section class="main-content">
		<div class="container">
			<h3>참여 명단</h3>
			
			<br>
			<br>
		
			<table class="table detailtable">
				<thead>
					<tr>
						<th>이름</th>
						<th>부서명</th>
						<th>직급</th>
						<th>휴대폰</th>
					</tr>
				</thead>
			</table>
		</div>
		<button type="button" id="detail_close">창 닫기</button>
	</section>
		  	</div>
		  </div>
		</div>
	</div>
	<%--참여명단 모달끝 --%>	
</div> <!-- class content -->

<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>
</body>
</html>