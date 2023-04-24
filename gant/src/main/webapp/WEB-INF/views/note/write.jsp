<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>    
<head>
 <meta charset="utf-8">
<title>쪽지쓰기</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="http://code.jquery.com/ui/1.8.18/themes/base/jquery-ui.css" type="text/css" />  
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
<script src="http://code.jquery.com/ui/1.8.18/jquery-ui.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- 네이버 스마트에디터  -->
<!-- <head> 안에 추가 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/libs/smarteditor/dist/js/service/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script>
      $(document).ready(function () {
    	    
           //사진 선택을 취소하고싶을때 나타나는 버튼
           $('#deletefile').hide()
    	  
    	
            //submit click 이벤트 
            $("#submit").click(function(){
		    	//공백 검사
		    	
            	if($("#reference_person").val() == ""){
    	    		alert('받는사람을 선택하세요');
    				return false;
    	    	}
            	
            	if($("#subject").val() == ""){
		    		alert('제목을 입력하세요.');
		    		$("#subject").focus();
					return false;
		    	}
            			    	
          
            	//스마트 에디터 값을 텍스트컨텐츠로 전달
            	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
  		  });
            

            	
            

           
            let check_id = ''; //체크아이디저장
            
            //받는사람 체크박스 이벤트
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
        			url : "../request/searchMemberList",
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
            
            
            //파일 업로드 
    		$("#myFileUp").change(function(){
    			        readURL(this);
    			        $('#deletefile').show(); // 파일선택 취소 버튼 보이게하기
    			        $('#FileUp').hide();  //파일선택 버튼을 사라지게 한다.
    			    });
    		
    		// 취소를 선택했을때
    		$("#deletefile").click(function(){
    			        $('#fileName').val('');  //값을 지운다.     	
    			        $('#myFileUp').val('');
    			        $('#deletefile').hide(); // 파일선택 취소 버튼 보이게하기
    			        $('#FileUp').show();  //파일선택 버튼을 사라지게 한다.
    			    });
    		
    	 //readURL 함수
    	 function readURL(input) {
		        if (input.files && input.files[0]) {	               
		                $('#fileName').val(input.files[0].name);    //파일선택 form으로 파일명이 들어온다		        	          
		        }
		    }
         
    	 
    	 //답장하기의 경우
    	 let subject = '${subject}';
    	 let content = '${content}';
    	 let writer = '${writer}';
    	 
    	 if(subject != ''){
    		 $('#subject').val('RE: '+subject);
    	 }
    	 
    	 if(content != ''){
    		 $('#txtContent').text('-----Original Message-----<br>'+content);
    	 }
    	 console.log(writer);
    	 
    	 if(writer != ''){
    		 $("input[type='checkbox'][value='"+writer+"']").prop("checked", true);
    		 $('#modalSubmit').click();
    	 }
    	 
      
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
    	  console.log("쪽지 받는사람 아이디 =" + $("#reference_person_id").val()  ) 
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


.fileRegiBtn label {
	display: inline-block; 
	padding: .5em .75em; 
	color: #ffffff; 
	font-size: inherit; 
	line-height: normal; 
	vertical-align: middle; 
	background-color: #009CFF; 
	cursor: pointer; 
	border: 1px solid #ebebeb; 
	border-bottom-color: #e2e2e2; 
	border-radius: .25em;
}


.fileRegiBtn input[type="file"]{
	position: absolute; 
	width: 1px; 
	height: 1px; 
	padding: 0; 
	margin: -1px; 
	overflow: hidden; 
	clip:rect(0,0,0,0); 
	border: 0;
}

#filelabel{
    display:block
}

.fileRegiBtn{
width:130px; 
display:inline;
margin-left:-3px;	
}

.fileName:disabled, .fileName[readonly] {
    background-color: #e9ecef;
    opacity: 1;
}
.fileName {
	margin-right:-4px;
    width: 40%;
    height: calc(1.5em + 0.75rem + 2px);
    padding: 0.375rem 0.75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: 0.25rem;
    transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
}

#table{
width:100%
}

.card{
 width:120%   
}



</style>
</head>

<body>
<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />


<style>
th,td{
    padding-top:2%  !important;
    padding-bottom:2%  !important;
}

.input{
    width:70%
}


.rounded.h-100.p-4{
    margin-left:3%;
     margin-top:5%
    
}

#fileName{
border-radius : 5px 0px 0px 5px;
}

#FileUp,#deletefile{
    border-radius : 0px 5px 5px 0px;
}

#deletefile{
   color: white;
   font-weight: bold;
}

.modal-footer{
    border-top:none;
}

</style>

<div class="container ">		  
	<div class="col-xl-6">
      <div class="rounded h-100 p-4">                            
       <div class="tab-content pt-3" id="nav-tabContent">
	     <div class="card">
			        <div class="card-header bg-primary text-white">
			          <h4 class="card-title" style="color: white">쪽지쓰기</h4>
			        </div>
			<div class="card-body">
			  <form action="writeAction" enctype="multipart/form-data" method="post">
			  <table class="table-borderless" id="table">
			  <tr>
			  <th>받는사람</th>
			  <td>
			   <div class="input-group input">
			        <input type="text" class="form-control" id="reference_person" readonly>
			        <input type="hidden" class="form-control" id="reference_person_id" name="to_id">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
					  검색
					</button>
			   </div>
			  </td>			  
			  </tr>
			  
			  <tr>
			  <th>제목</th>
			  <td>
	              <div class="input">
				     <input name="subject" id="subject"  type="text" maxlength="100" 
			           class="form-control" placeholder="제목을 입력하세요">
	              </div>
			  </td>			  
			  </tr>
			  
			  <tr>
			  <th>파일첨부</th>
			  <td>
                  <div class="input-group input">
			         <input id="fileName" class="fileName" value="파일선택" disabled="disabled">
				   <div class="fileRegiBtn">
					 <label for="myFileUp" id="FileUp">파일등록하기</label>
					 <input type="file" id="myFileUp" name="uploadfile">
					 <input type="button" class="btn btn-primary" id="deletefile" value="x">
			       </div>
                  </div>
			  </td>			  
			  </tr>
			  
			  <tr>
			  <th></th>
			  <td>

			        <textarea id="txtContent" rows="10" cols="100" name="content" ></textarea>
			        <!-- textarea 밑에 script 작성하기 -->
						<script id="smartEditor" type="text/javascript"> 
							var oEditors = [];
							nhn.husky.EZCreator.createInIFrame({
							    oAppRef: oEditors,
							    elPlaceHolder: "txtContent",  //textarea ID 입력
							    sSkinURI: "${pageContext.request.contextPath}/resources/libs/smarteditor/dist/SmartEditor2Skin.html",  //martEditor2Skin.html 경로 입력
							    fCreator: "createSEditor2",
							    htParams : { 
							    	// 툴바 사용 여부 (true:사용/ false:사용하지 않음) 
							        bUseToolbar : true, 
								// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음) 
								bUseVerticalResizer : false, 
								// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음) 
								bUseModeChanger : false 
							    }
							});
						</script>        

			  </td>			  
			  </tr> 
		</table>   
			   
			    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">  
			    <button type="submit" class="btn btn-primary m-2 float-right" id="submit">보내기</button>
			    <button type="button" class="btn btn-danger m-2 float-right" onclick="location.href='getMian'">취소</button>			 
		</form>
      </div>
			
   <!-- Modal -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			  <div class="modal-dialog" role="document">
			    <div class="modal-content">
			      <div class="modal-header bg-primary" >
			        <h4 class="modal-title" id="myModalLabel" style="color: white">받는사람</h4>
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


   
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>

</body>
</html>