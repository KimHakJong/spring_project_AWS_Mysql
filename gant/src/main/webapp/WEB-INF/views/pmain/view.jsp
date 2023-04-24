<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link href="../resources/css/pmain/view.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="../resources/css/pmain/style.css"> <!-- 프로젝트인원 모달 -->
  <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<meta charset="UTF-8">

</head>

<body>
<jsp:include page="../home/side.jsp" />


<div class="content">
<jsp:include page="../home/header2.jsp" />
<div class="pmain">
		<div id="search_div">
		<form id="search_form" action="view" method="post">
			<input type="text" name="p_name" id="search_word" placeholder="프로젝트명을 검색하세요 . . ."><button type="submit" class="search_click">검&nbsp;색</button>
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</form>
		</div>
		
		<div id="projects">
		<c:if test="${!empty list}">
		
		<c:forEach var="p" items="${list}">
			
			<div class="project">
				<input type="hidden" class="p_no" value="${p.p_no}">
				<input type="hidden" class="sendids" value="${p.p_mids}">
				<div class="project_people">
					<a class="godetail" data-toggle="modal" href="#detailmodal">
						<img class="project_peopleimg" src="../image/pmain/project_user4.png"><span></span>
					</a>
					<input type="hidden" class="p_mnames" value="${p.p_mnames}">
				</div>
				<c:if test="${p.p_hostid==check_id || admin=='true'}">  <!--  -->
				<a class="goupdate" data-toggle="modal" href="#updatemodal" data-backdrop="static"><img class="project_editimg" src="../image/pmain/pencil.png"></a>
				<img class="project_deleteimg" src="../image/pmain/clear.png">
				</c:if>
				<div class="project_content">
					<div class="project_innerdiv">${p.p_name}</div>
					<div class="project_innerdiv">${p.p_sdate} ~ ${p.p_edate}</div>
					<div class="project_innerdiv">${p.p_situation}</div>
					<div class="project_innerdiv">
						<div class="progress">
  							<div class="progress-bar progress-bar-success" role="progressbar"
  								 aria-valuemin="0" aria-valuemax="100" style="width:${p.p_percent}%">
  								 ${p.p_percent}%
  							</div>
  						</div>
					</div>
			
  				</div>
			</div><!-- project -->
		  </c:forEach>
			</c:if>
		  <c:if test="${empty list}">
			<h5 id="noproject">조회된 프로젝트가 없습니다.</h5>
		  </c:if>
		</div><!-- projects -->
			<img id="project_openmenu" src="../image/pmain/projectmenu3.png">
			<div id="project_openedmenu">
				<div>
				<a class="gocreate" data-toggle="modal" href="#createmodal" data-backdrop="static">추가</a>
				</div>
				<div>
				<a id="update_project">수정</a>
				</div>
				<div>
				<a id="remove_project">삭제</a>
				</div>
			</div>
</div><!-- pmain -->

<%-- 참여명단모달 창 --%>
<div class="modal" id="detailmodal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		 <section class="main-content">
		<div class="container">
			<h3>프로젝트 명단</h3>
			
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
<%--생성모달 창 --%>
<div class="modal" id="createmodal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="create_subject">프로젝트 생성</h4>
		  	<button type="button" id="create_close" data-dismiss="modal">×</button>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		  		<form name="createForm" id="createForm" action="createProject" method="post">
		  		<input type="hidden" name="p_hostid" id="create_id">
		  		<label for="create_name">프로젝트명</label>
				<input type="text" name="p_name" id="create_name">
		<label for="create_sdate">프로젝트 기간</label>
			<input type="date" name="p_sdate" id="create_sdate"><span>~</span>
			
			<input type="date" name="p_edate" id="create_edate">
			
		<label for="create_member">명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단</label>
			<input type="text" name="p_mnames" id="create_membername" readOnly>
			<button type="button" id="member_search" data-target="#msearch" data-toggle="modal" data-backdrop="static">명단 검색</button>
			<input type="hidden" name="p_mids" id="create_member">
	
		<label for="create_content">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</label>
			<textarea name="p_content" id="create_content"></textarea>
		 
		  		<button type="submit" id="create_submit" >추가</button>
		  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  		</form>
		  	</div>
		  </div>
		</div>
	</div>
	<%--모달 끝 --%>	
<%--수정 모달창 --%>
<div class="modal" id="updatemodal">
		<div class="modal-dialog">
		  <div class="modal-content">
		  	<h4 id="update_subject">프로젝트 수정</h4>
		  	<button type="button" id="update_close" >×</button>
		  	<%--Modal Body --%>
		  	<div class="modal-body">
		  		<form name="updateForm" id="updateForm" action="updateProject" method="post">
		  		<input type="hidden" name="p_no" id="update_no">
		  		<label for="update_name">프로젝트명</label>
				<input type="text" name="p_name" id="update_name">
		<label for="update_sdate">프로젝트 기간</label>
			<input type="date" name="p_sdate" id="update_sdate"><span>~</span>
			
			<input type="date" name="p_edate" id="update_edate">
			
		<label for="update_member">명&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;단</label>
			<input type="text" name="p_mnames" id="update_membername" readOnly>
			<button type="button" id="member_search2" data-target="#msearch" data-toggle="modal" data-backdrop="static">명단 검색</button>
			<input type="hidden" name="p_mids" id="update_member">
	
		<label for="update_content">내&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;용</label>
			<textarea name="p_content" id="update_content"></textarea>
		 
		<label for="update_situation">진행현황</label>
			<input type="text" name="p_situation" id="update_situation"><input type="text" name="p_percent" id="update_percent">
			<img src="../resources/image/pmain/percenticon.png">
		  		<button type="submit" id="update_submit" >수정하기</button>
		  		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  		</form>
		  	</div>
		  </div>
		</div>
	</div>
<%--수정모달 끝 --%>		
	
	<%--명단검색 모달 --%>
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
	<%--명단검색 모달 끝 --%>

<div class="container-fluid pt-4 px-4">
</div>
</div> <!-- class content -->

<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>

</body>
<script>
$(document).ready(function(){
	
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

$(".project").each(function(){ //인원수 넣기
	let names = $(this).find(".p_mnames").val();
	let s_name = names.split(",");
	$(this).find(".project_peopleimg").next().text(s_name.length);
});

//수정,삭제 클릭 시 활성화
$("#update_project").click(function(){
	if($(".project_deleteimg").css('display')=='none'){
		$(".goupdate").toggle();
	}
});
$("#remove_project").click(function(){
	if($(".goupdate").css('display')=='none'){
		$(".project_deleteimg").toggle();
	}
});
 
if('${create}'==1){
	alert("프로젝트가 생성되었습니다.");
}else if('${update}'==1){
	alert("프로젝트가 수정되었습니다.");
}else if('${delete}'==1){
	alert("프로젝트가 삭제되었습니다.");
}

	$('#project_openmenu').click(function(){
		$("#project_openedmenu").toggle();
	});
	
	$(".project").click(function(){
		let p_no =$(this).find('.p_no').val();
		let p_mids = $(this).find('.sendids').val();
		let p_mnames = $(this).find('.p_mnames').val();
		location.href="${pageContext.request.contextPath}/todolist/receive?p_no="+p_no+"&p_mids="+p_mids+"&p_mnames="+p_mnames;
	});
	
	//닫기버튼 눌렀을 때 잘 닫히도록
	$("#update_close, #detail_close").click(function(){
		if($(this).attr('id')=='update_close'){
			$("#updatemodal").modal('hide');
		}else if($(this).attr('id')=='detail_close'){
			$("#detailmodal").modal('hide');
		}
	});
	
	//시작일먼저 선택 후 종료일 선택하게
	$("#create_edate").click(function(){
		if($("#create_sdate").val()){
			$("#create_edate").attr('min',$("#create_sdate").val());
		}else{
			alert("시작일을 먼저 선택하세요");
			$("#create_sdate").focus();
			return false;
		}
	});

	//시작일먼저 선택 후 종료일 선택하게
	$("#update_edate").click(function(){
		if($("#update_sdate").val()){
			$("#update_edate").attr('min',$("#update_sdate").val());
		}else{
			alert("시작일을 먼저 선택하세요");
			$("#update_sdate").focus();
			return false;
		}
	});
	//모달에서 생성하기 했을 때 : 공백있으면 기본이벤트 제거
	$("#createForm").submit(function(){
		
		//시작일 < 종료일 되도록
		let num_sdate = $("#create_sdate").val().replaceAll("-","");
		let num_edate = $("#create_edate").val().replaceAll("-","");
		console.log(num_sdate);
		console.log(num_edate);
		
		if($("#create_id").val().trim()=="") {
			alert("아이디를 불러오지 못했습니다\n로그인창으로 이동합니다.");
			location.href="../member/login";
			//return false; 로그인창으로 이동하기에 작동X
		}else if($("#create_name").val().trim()==""){
			alert("프로젝트명을 입력하세요");
			$("#create_name").focus();
			return false;
		}else if($("#create_sdate").val().trim()=="") {
			alert("프로젝트 시작일을 입력하세요");
			$("#create_sdate").focus();
			return false;
		}else if($("#create_edate").val().trim()==""){
			$("#create_edate").focus();
			alert("프로젝트 종료일을 입력하세요");
			return false;
		}else if(parseInt(num_edate) < parseInt(num_sdate)){
			$("#create_sdate").focus();
			alert("시작일과 종료일을 다시 설정하세요");
			return false;
		}else if($("#create_membername").val().trim()=="" || $("#create_member").val().trim()==""){
			alert("명단을 선택하세요");
			$("#create_membername").focus();
			return false;
		}else if($("#create_content").val().trim()==""){
			alert("내용을 입력하세요");
			$("#create_content").focus();
			return false;
		}
		
	});
	//생성 눌렀을 때 모달에 아이디값 넣기
	$(".gocreate").click(function(){
		$("#project_openedmenu").toggle();
		
		$("#create_id").val($(".side_userid").text());
		gocreate = true;
		goupdate = false;
	});
	
	//프로젝트 수정 눌렀을 때 모달에 프로젝트 번호 넣기
	$(".goupdate").click(function(){
		$("#project_openedmenu").toggle();
		$(".goupdate").toggle();
		goupdate = true;
		gocreate = false;
 		let p_no = $(this).parent().find(".p_no").val();
 		$("#update_no").val(p_no);
 		$.ajax({
 			url : "loadupdatemodal",
 			type : "post",
 			data : {"p_no" : p_no},
 			dataType : "json",
 			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(rdata){
    			$("#update_name").val(rdata.p_name);
    			$("#update_sdate").val(rdata.p_sdate);
    			$("#update_edate").val(rdata.p_edate);
    			$("#update_membername").val(rdata.p_mnames);
    			$("#update_member").val(rdata.p_mids);
    			$("#update_content").val(rdata.p_content);
    			$("#update_situation").val(rdata.p_situation);
    			$("#update_percent").val(rdata.p_percent);
    		}
 		});
		event.stopPropagation();
		$('#updatemodal').modal('show')
 	});
	
	//모달에서 수정하기 했을 때 : 공백있으면 기본이벤트 제거
	$("#updateForm").submit(function(){
		//시작일 < 종료일 되도록
		let num_sdate = $("#update_sdate").val().replaceAll("-","");
		let num_edate = $("#update_edate").val().replaceAll("-","");
		console.log($("#update_percent").val());
		if($("#update_no").val().trim()=="") {
			alert("프로젝트를 불러오지 못했습니다.");
			return false;
		}else if($("#update_name").val().trim()==""){
			alert("프로젝트명을 입력하세요");
			$("#update_name").focus();
			return false;
		}else if($("#update_sdate").val().trim()=="") {
			alert("프로젝트 시작일을 입력하세요");
			$("#update_sdate").focus();
			return false;
		}else if($("#update_edate").val().trim()==""){
			alert("프로젝트 종료일을 입력하세요");
			$("#update_edate").focus();
			return false;
		}else if(parseInt(num_edate) < parseInt(num_sdate)){
			$("#update_sdate").focus();
			alert("시작일과 종료일을 다시 설정하세요");
			return false;
		}else if($("#update_membername").val().trim()=="" || $("#update_member").val().trim()==""){
			alert("명단을 선택하세요");
			$("#update_membername").focus();
			return false;
		}else if($("#update_content").val().trim()==""){
			alert("내용을 입력하세요");
			$("#update_content").focus();
			return false;
		}else if($("#update_situation").val().trim()==""){
			alert("진행상황을 입력하세요");
			$("#update_situation").focus();
			return false;
		}else if(isNaN($("#update_percent").val()) || $("#update_percent").val()==''){ //숫자가 아닌경우
			alert("숫자로 입력하세요");
			$("#update_percent").focus();
			return false;
		}else if(parseInt($("#update_percent").val())>100){
			alert("100이하의 숫자로 입력하세요");
			$("#update_percent").focus();
			return false;
		}
		
	});
	
	//처음엔 생성,수정모달에 id,name들 가져옴 -> 명단검색클릭: 가져온 값 체크되도록 -> 취소:값초기화, 확인:check_id에 저장된 아이디값을 모달에 넘김
	//check_id = 명단검색눌렀을 때 id값들 받아옴 / 체크O,체크X 시 해당value를 check_id에 추가,제거 / 취소눌렀을 때 값초기화 / input할 때마다 check_id에 있는 값 체크되도록 , 확인눌렀을 때 check_id에 있는 각각 value와 비교해서 값넘김
	$("body").on('change','input[type="checkbox"]',function(){
		console.log(check_id);
		let change_id = $(this).val(); //변화감지된 아이디
		if($(this).is(":checked")){//새로 체크되었을 때
			if(!check_id.includes(change_id+",")){ //기존 체크 id에 방금 체크한 아이디가 없는 경우
				if(check_id.substr(-1) == "," || check_id.length==0){ //맨마지막이 ,인 경우
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
		
		console.log(check_id);
	});
	
	
	$("#msearch_input").keyup(function(){
		name = $(this).val();
		
		$.ajax({
			url : "searchMemberList_ajax ",
			type : "post",
			data : { "name" : name},
			dataType : "json",
			async: false,
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(rdata){
				console.log("명단입력후ajax성공");
				
				let output ='';
				if(rdata!=null){
					output += "<table class='table msearch_table_body'>";
					$(rdata).each(function(){
						if(check_id.includes(this.id+",")){ //check_id에 값이 있다면 자동으로 체크되도록!
						output += '<tr><td><input type="checkbox" value="' + this.id +'" checked></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
						}else{
						output += '<tr><td><input type="checkbox" value="' + this.id +'"</td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
						}
					});
					output += '</table>';
				}else{
					output += "<h5 style='text-align:center'>조회된 회원 명단이 없습니다.</h5>";
				}
				$("#msearch_table_div").empty();
				$("#msearch_table_div").append(output); 	
    		}
		});
	});
	
	
	$("#member_search, #member_search2").click(function(){
		console.log("명단검색클릭");
	
		$("#msearch_table_div").empty();
		console.log($(this).attr('id'));
		
		//생성,수정이든 각각 명단아이디가 저장되어있으면 그 값을 check_id변수에도 저장
		if(gocreate==true){
			if($("#create_member").val()==""){
				check_id = $("#create_member").val();
			}else{
				check_id = $("#create_member").val()+",";
			}
			console.log("create"+check_id);
		}else if (goupdate==true) {
			if($("#update_member").val()==""){
				check_id = $("#update_member").val();
			}else{
				check_id = $("#update_member").val()+",";
			}
			console.log("update"+check_id);
		}
		
		$.ajax({
			url : "memberlist_ajax",
			type: "post",
			dataType: "json",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
			success : function(rdata){
				console.log("ajax명단검색성공");
				
				let output ='';
				if(rdata!=null){
					output += "<table class='table msearch_table_body'>";
					$(rdata).each(function(){
						if(check_id.includes(this.id+",")){ //명단에 있으면 다시 명단 검색갔을 때 체크되어있다.
						output += '<tr><td><input type="checkbox" value="' + this.id +'" checked></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
						}else{
						output += '<tr><td><input type="checkbox" value="' + this.id +'"></td><td>'+this.name+'</td><td>'+this.department+'</td></tr>';
						}
					});
					output += '</table>';
				}else{
					output += "<h5 style='text-align:center'>조회된 회원 명단이 없습니다.</h5>";
				}
				$("#msearch_table_div").append(output); 
			}
		});
	});

	//명단검색에서 취소 : 체크박스 체크 해제
	$("#msearch_cancel").click(function(){ 
		$(".msearch_table_body").find('input[type=checkbox]').each(function(){
			$(this).attr('checked',false);
		});
		$("#msearch_input").val(""); //검색창
		$("#update_member").val(""); //명단 아이디
		$("#create_member").val(""); //명단 아이디
		$("#update_membername").val("");//명단 이름
		$("#create_membername").val("");//명단 이름
	});
	
	//명단검색에서 체크 후 확인 : 생성하기모달 명단에 자동입력
	$("#msearch_ok").click(function(){
		check_name ='';
		$("#msearch_input").val(""); //검색창
		$("#msearch_input").keyup(); //검색된 상태에서 조회하면 다른 체크된 이름들이 반영X (닫기전에 keyup이벤트로 모든 체크박스가 반영되도록)
		if($("#msearch_input").val()==""){
			
		$("input[type='checkbox']").each(function(){
			if(check_id.includes($(this).val()+",")) { //명단에 있으면 다시 명단 검색갔을 때 체크되어있다.
				//각각 체크박스에서 val가 만약 check_id에 포함되면 해당 id와 name저장
				check_name += $(this).parent().next().text()+",";
			}
		});

		}
		//맨 마지막 쉼표 제거하기 위함
		if(check_id.substr(-1)==','){
			check_id = check_id.substring(0,check_id.length-1);		
		}
		if(check_name.substr(-1)==','){
			check_name = check_name.substring(0,check_name.length-1);
		}
		console.log("명단확인버튼(이름):"+check_name);
		console.log("명단확인버튼(아이디):"+check_id);
		
		if(gocreate==true){
		$("#create_membername").val(check_name);
		$("#create_member").val(check_id);
		}else if(goupdate==true){
		$("#update_membername").val(check_name);
		$("#update_member").val(check_id);
		}
	});
	
	$(".project_deleteimg").click(function(){
		$("#project_openedmenu").toggle();
		$(".project_deleteimg").toggle();
		event.stopPropagation();
		let p_no = $(this).parent().find('.p_no').val();
		if(confirm("정말로 삭제하시겠습니까?")){
			location.href="deleteProject?p_no="+p_no;
		}
	});
	
	//인원수체크 클릭
	$(".godetail").click(function(event){
		
		let p_no = $(this).parent().parent().find(".p_no").val();
		console.log(p_no);
		$.ajax({
			url : "pmemberdetail",
			type: "post",
			dataType: "json",
			data : { "p_no" : p_no },
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
    				output += "<h5>프로젝트 명단이 없습니다.</h5>";
    			}
    			$(".detailtable").append(output);
    			
    		}
		});	
		event.stopPropagation();
		$('#detailmodal').modal('show')
	});
});
</script>
</html>