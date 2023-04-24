<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="page-enter" content="blendTrans(duration=0.3)">
<meta http-equiv="page-exit" content="blendTrans(duration=0.3)">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link href="../resources/css/reserve/reservemain.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="../resources/js/reserve/reservemain.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../home/side.jsp" />


<div class="content">
<jsp:include page="../home/header2.jsp" />

	<div class="reserve_main">
		<div class="reserve_head">
			<button type="button" id="add_resource" data-target="#resource_modal" data-toggle="modal" data-backdrop="static">자원추가</button>
			<div class="show_date"><span></span><img src="../resources/image/reserve/calendar6.png">
				<input type="hidden" id="show_date_input">
			</div>
			<div class="head_buttondiv">
			<button type="button" class="head_button1">예약현황</button>
			<button type="button" class="head_button2" data-target="#reserve_insert" data-toggle="modal" data-backdrop="static">예약</button>
			</div>
			<div class="datepicker"></div>
		</div>
		 
		<div class="reserve_body">
		<div id="explain">
		<div></div><span>예약 불가</span>
		</div>
			<div class="reserve_time">
				<span id="type_span">
					<select id="type_select">
						<c:if test="${types!=null}">
						
						<c:forEach var="type" items="${types}" varStatus="status">
						 <c:if test="${status.index==0}">
						 	<option selected value="${type}">${type}</option>
						 </c:if>
						 <c:if test="${status.index>0}">
						 	<option value="${type}">${type}</option>
						 </c:if>
						</c:forEach>
						
						</c:if>
						<c:if test="${types==null}">
							<option selected value="">자원을 추가하세요</option>
							<script>
								
							</script>
						</c:if>
					</select>
				</span>
				<span class="time_span">08:00</span>
				<span class="time_span">09:00</span>
				<span class="time_span">10:00</span>
				<span class="time_span">11:00</span>
				<span class="time_span">12:00</span>
				<span class="time_span">13:00</span>
				<span class="time_span">14:00</span>
				<span class="time_span">15:00</span>
				<span class="time_span">16:00</span>
				<span class="time_span last_before">17:00</span>
				<span class="time_span">18:00</span>
			</div>
			<table class="reserve_table">
				<c:if test="${!empty resources_by_type}">
				<c:forEach var="resource" items="${resources_by_type}">
					<tr><td>${resource}</td>
								<td></td><td></td><td></td><td></td><td></td>
								<td></td><td></td><td></td><td></td><td></td>
								<td></td><td></td><td></td><td></td><td></td>
								<td></td><td></td><td></td><td></td><td></td>
					</tr>
				</c:forEach>
				</c:if>
				<c:if test="${empty resources_by_type}">
					<tr><td id="noadd"><h4>등록된 자원이 없습니다.</h4></td></tr>
				</c:if>
			</table>
		</div>
	</div>
	
	<!-- 해당예약확인 모달 시작-->
	<div id="detail_reservation" class="modal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="detail_subject">예약 상세보기</h4>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
			
			<table class="table detail_table">
					<tr><th class="detail_th">예약자</th><td colspan="2"></tr>
					<tr><th class="detail_th">자원명</th><td colspan="2"></td>
					</tr>
					<tr><th class="detail_th">예약 시간</th><td></td><td></td>
					</tr>
					<tr><th class="detail_th">명단</th><td colspan="2"></td></tr>
					<tr><th class="detail_th">목적</th><td colspan="2"></td></tr>

			</table>

		 	<div id="detail_buttondiv">
		 	<input type="hidden" id="detail_num">
		  	<button type="button" id="detail_to_update">수정</button>
		  	<button type="button" id="detail_to_delete">삭제</button>
		  	<button type="button" id="detail_close">확인</button>
		 	</div>
		 	</div>
		  	</div>
		  </div>
		</div>
<!-- 해당예약확인 모달 끝 -->
<!-- 예약수정모달 시작 -->
	<div class="modal" id="reserve_update">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="update_title">예약 수정</h4>
		  	<button type="button" id="update_close" data-dismiss="modal">×</button>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		  		<form name="updateForm" id="updateForm" action="updateReservation" method="post">
		  			<div class="update_menudiv">
		  			<input type="hidden" name="num" id="update_num">
		  			<label for="update_name">예약자명</label>
					<input type="text" name="name" id="update_name" readonly>
					<input type="hidden" name="id" id="update_id">
		  			</div>
				
					<div class="update_menudiv">
					<label for="update_type">자원선택</label>
					<select name="type" id="update_type">
					<option selected></option>
					</select>
					<select name="resource_name" id="update_resource_name">
					<option selected></option>
					</select>
					</div>
										
					<div class="update_menudiv">
					<label for="update_purpose">예약목적</label>
					<input type="text" name="purpose" id="update_purpose">
					</div>				

					<div class="update_menudiv wrap_namediv">
					<label id="names_label">참여명단</label>
					<div id="update_namediv">

					</div>
					<input type="hidden" name="names" id="update_names">
					<button type="button" id="member_search2" data-target="#msearch" data-toggle="modal" data-backdrop="static">명단 검색</button>
					</div>
					
					<div class="update_menudiv wrap_daydiv">
					<label for="update_day">예약날짜</label>
					<input type="text" name="day" id="update_day" required>
					</div>
					
					<div class="insert_menudiv wrap_timediv">
					<label for="insert_time">예약시간</label>
					<div id="update_timediv">
					<div class="update_time can">08:00</div><input type="hidden" value="16">
					<div class="update_time can">08:30</div><input type="hidden" value="17">
					<div class="update_time can">09:00</div><input type="hidden" value="18">
					<div class="update_time can">09:30</div><input type="hidden" value="19">
					<div class="update_time can">10:00</div><input type="hidden" value="20">
					<div class="update_time can">10:30</div><input type="hidden" value="21">
					<div class="update_time can">11:00</div><input type="hidden" value="22">
					<div class="update_time can">11:30</div><input type="hidden" value="23">
					<div class="update_time can">12:00</div><input type="hidden" value="24">
					<div class="update_time can">12:30</div><input type="hidden" value="25">
					<div class="update_time can">13:00</div><input type="hidden" value="26">
					<div class="update_time can">13:30</div><input type="hidden" value="27">
					<div class="update_time can">14:00</div><input type="hidden" value="28">
					<div class="update_time can">14:30</div><input type="hidden" value="29">
					<div class="update_time can">15:00</div><input type="hidden" value="30">
					<div class="update_time can">15:30</div><input type="hidden" value="31">
					<div class="update_time can">16:00</div><input type="hidden" value="32">
					<div class="update_time can">16:30</div><input type="hidden" value="33">
					<div class="update_time can">17:00</div><input type="hidden" value="34">
					<div class="update_time can">17:30</div><input type="hidden" value="35">
					</div>
					<input type="hidden" name="start_time" id="start_time2">
					<input type="hidden" name="end_time" id="end_time2">
					<input type="hidden" name="before_time" id="before_time">
					<input type="hidden" class="max_person">
					</div>
					
		  		<button type="submit" id="update_submit" >수정완료</button>
		  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  		</form>
		  	</div>
		  </div>
		</div>
	</div>
<!-- 예약수정모달 끝 -->
<!-- 예약추가모달 시작 -->
	<div class="modal" id="reserve_insert">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="insert_title">예약 추가</h4>
		  	<button type="button" id="insert_close" data-dismiss="modal">×</button>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		  		<form name="insertForm" id="insertForm" action="insertReservation" method="post">
		  			<div class="insert_menudiv">
		  			<input type="hidden" name="number" id="insert_number">
		  			<label for="insert_name">예약자명</label>
					<input type="text" name="name" id="insert_name" readonly>
					<input type="hidden" name="id" id="insert_id">
		  			</div>
				
					<div class="insert_menudiv">
					<label for="insert_purpose">예약목적</label>
					<input type="text" name="purpose" id="insert_purpose">
					</div>				

					<div class="insert_menudiv wrap_namediv">
					<label id="names_label">참여명단</label>
					<div id="insert_namediv">
			
					</div>
					<input type="hidden" name="names" id="insert_names">
					<button type="button" id="member_search" data-target="#msearch" data-toggle="modal" data-backdrop="static">명단 검색</button>
					</div>
					
					<div class="insert_menudiv">
					<label for="insert_type">자원선택</label>
					<select name="type" id="insert_type">
					<option value="" disabled selected>종류 선택</option>
					<c:if test="${types!=null}">
					<c:forEach var="type" items="${types}">
						<option value="${type}">${type}</option>
					</c:forEach>
					</c:if>
					</select>
					
					<select name="resource_name" id="insert_resource_name">
					<option value="" disabled selected>자원명 선택</option>
					</select>
					</div>
					
					<div class="insert_menudiv wrap_daydiv">
					<label for="insert_day">예약날짜</label>
					<input type="text" name="day" id="insert_day" required>
					<!-- 
					 <input type="date" name="day" id="insert_day" required>
					 -->
					</div>
					
					<div class="insert_menudiv wrap_timediv">
					<label for="insert_time">예약시간</label>
					<div id="insert_timediv">
					<div class="insert_time can">08:00</div><input type="hidden" value="16">
					<div class="insert_time can">08:30</div><input type="hidden" value="17">
					<div class="insert_time can">09:00</div><input type="hidden" value="18">
					<div class="insert_time can">09:30</div><input type="hidden" value="19">
					<div class="insert_time can">10:00</div><input type="hidden" value="20">
					<div class="insert_time can">10:30</div><input type="hidden" value="21">
					<div class="insert_time can">11:00</div><input type="hidden" value="22">
					<div class="insert_time can">11:30</div><input type="hidden" value="23">
					<div class="insert_time can">12:00</div><input type="hidden" value="24">
					<div class="insert_time can">12:30</div><input type="hidden" value="25">
					<div class="insert_time can">13:00</div><input type="hidden" value="26">
					<div class="insert_time can">13:30</div><input type="hidden" value="27">
					<div class="insert_time can">14:00</div><input type="hidden" value="28">
					<div class="insert_time can">14:30</div><input type="hidden" value="29">
					<div class="insert_time can">15:00</div><input type="hidden" value="30">
					<div class="insert_time can">15:30</div><input type="hidden" value="31">
					<div class="insert_time can">16:00</div><input type="hidden" value="32">
					<div class="insert_time can">16:30</div><input type="hidden" value="33">
					<div class="insert_time can">17:00</div><input type="hidden" value="34">
					<div class="insert_time can">17:30</div><input type="hidden" value="35">
					</div>
					<input type="hidden" name="start_time" id="start_time">
					<input type="hidden" name="end_time" id="end_time">
					<input type="hidden" class="max_person"> 
					</div>
					
		  		<button type="submit" id="insert_submit" >등&nbsp;&nbsp;록</button>
		  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  		</form>
		  	</div>
		  </div>
		</div>
	</div>
	<!-- 예약추가모달 끝 -->

	<!-- 명단검색모달 -->
	<div id="msearch" class="modal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="msearch_subject">명단 검색</h4>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
			
			<input type="text" id="msearch_input"><span>🔍︎</span>
			
			<table class="table msearch_table_head">
					<tr><td>체크</td><td>이름</td><td>부서명</td></tr>
			</table>
			<div id="msearch_table_div" style="width:100%; height:180px; overflow:auto">

		 	</div>
		 	<div id="mesearch_buttondiv">
		  	<button type="button" id="msearch_ok" data-dismiss="modal">확인</button>
		  	<button type="reset" id="msearch_cancel" data-dismiss="modal" >취소</button>
		 	</div>
		  	</div>
		  </div>
		</div>
	</div>
	<!-- 명단검색모달 끝 -->
	<!-- 자원생성모달 -->
	<div id="resource_modal" class="modal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="resource_subject">자원 추가</h4>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
			<form action="addResource" method="post" id="addResourceForm">
			<input type="text" name="type" class="resource_input" placeholder="자원 종류">
			<input type="text" name="resource_name" class="resource_input" placeholder="자원명">
			<input type="text" name="max_person" class="resource_input" placeholder="최대 인원 수">
			
		 	<div id="resource_buttondiv">
		 	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  	<button type="submit" id="resource_ok">등록</button>
		  	<button type="button" id="resource_cancel" data-dismiss="modal">취소</button>
		 	</div>
			</form>
		  	</div>
		  </div>
		</div>
	</div>
	<!-- 자원생성모달 끝 -->
	
</div> <!-- class content -->

<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>
<script>
//관리자인 경우 : 자원추가버튼 보임
if('${admin}'=='true'){
	$("#add_resource").css('display','block');
	if(!'${types}'){
		alert("자원을 추가하세요");
	}
}
//자원추가 성공
if('${add_item}'==1){
	   alert("예약자원 등록을 성공했습니다.");
}
//예약추가 성공
if('${add_reservation}'==1){
	if('${remain_count}'){
		let count = '${remain_count}';
		console.log(count);
		if(count==0){
			alert("정상적으로 예약되었습니다.\n오늘 잔여 예약 시간을 모두 소진했습니다.");
		}else if(count>0 && count%2==0){
			alert("정상적으로 예약되었습니다.\n오늘 잔여 예약 시간은 " + (parseInt(count/2)) + "시간 입니다.");
		}else{
			alert("정상적으로 예약되었습니다.\n오늘 잔여 예약 시간은 " + (parseInt(count/2)) + "시간 " + (count%2*30)+"분 입니다.");
		}
	}
}
//예약수정 성공
if('${update_reservation}'==1){
	if('${remain_count}'){
		let count = '${remain_count}';
		console.log(count);
		if(count==0){
			alert("정상적으로 수정되었습니다.\n오늘 잔여 예약 시간을 모두 소진했습니다.");
		}else if(count>0 && count%2==0){
			alert("정상적으로 수정되었습니다.\n오늘 잔여 예약 시간은 " + (parseInt(count/2)) + "시간 입니다.");
		}else{
			alert("정상적으로 수정되었습니다.\n오늘 잔여 예약 시간은 " + (parseInt(count/2)) + "시간 " + (count%2*30)+"분 입니다.");
		}
	}
}

//예약시간 할당 성공
if('${add_count}'==1){
	alert("하루 최대 6시간 예약가능합니다.");
}

//예약 시간 부족
if('${lack_of_count}'){
	let count = '${lack_of_count}';
	console.log(count);
	if(count==0){
		alert("예약을 실패했습니다.\n오늘 잔여 예약 시간을 모두 소진했습니다.");
	}else if(count>0 && count%2==0){
		alert("예약을 실패했습니다.\n오늘 잔여 예약 시간은 " + (parseInt(count/2)) + "시간 입니다.");
	}else{
		alert("예약을 실패했습니다.\n오늘 잔여 예약 시간은 " + (parseInt(count/2)) + "시간 " + (count%2*30)+"분 입니다.");
	}
}

//예약 삭제
if('${delete}'==1){
	alert("예약을 취소했습니다.");
}

</script>
</body>
</html>