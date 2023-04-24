<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/home/home.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link href="${pageContext.request.contextPath}/resources/css/board_css/modify.css" rel="stylesheet" type="text/css">

<script>
$(document).ready(function(){
	
	 // 비밀번호 체크박스 클릭시
	 $("#passwordbox").change(function(){
	        if($("#passwordbox").is(":checked")){ // 체크박스 체크했을때 readonly 제거
	        	$("#board_pass").removeAttr('readonly');
	        
	        }else{// 체크박스 헤제했을때 readonly 생성
	        	$("#board_pass").attr('readonly','readonly');
	        	$("#board_pass").val("");
	        }
	    }); 

        
	// 공지사항 체크박스 클릭시
	 $("#noticebox").change(function(){
	        if($("#noticebox").is(":checked")){ // 체크박스 체크했을때 val = true
	        	$("#noticebox").attr('value','true');
	            console.log($("#noticebox").val());
	        }else{// 체크박스 체크했을때 readonly 생성
	        	$("#noticebox").attr('value','false');
	           console.log($("#noticebox").val());
	        }
	    }); 
	
	     //파일 업로드 
		$("#myFileUp").change(function(){
			        readURL(this);		
			    });
		
		
		//readURL 함수
		 function readURL(input) {
		        if (input.files && input.files[0]) {	               
		                $('#fileName').val(input.files[0].name);    //파일선택 form으로 파일명이 들어온다		        	          
		        }
		    }

     //글 내용 기본 css
     $('#board_content').css({"font-size": "15px" , "font-weight": "400"});
		
	//내용 글자색 선택시
	$("#fontColor").change(function(){
		$('#board_content').css('color' , $(this).val() );	      	
	});
	
	//내용 글자 크기 선택시
	$("#fontSize").change(function(){
		$('#board_content').css('font-size',$(this).val());	
    });
	
	//내용 글자 굵기 선택시
	$("#fontWeight").change(function(){
		$('#board_content').css('font-weight', $(this).val());			
    });
	
	// 취소버튼 클릭시
	$("#cancel").click(function(){
		history.back(-1);			
    });
	
	// 등록 클릭시 이벤트
	$("#submit").click(function(){
		
	
		// 비밀글 설정이 체크되어있을때만 실행
    	if($("#passwordbox").is(":checked")){ 
    		//비밀번호 공백 검사
    		if($.trim($("#board_pass").val()) == ""){
        		alert('비밀번호를 입력하세요');
        		$("#board_pass").focus();
    			return false;}
    		
    		// 비밀번호 유효성검사
    		if($.trim($("#board_pass").val()).length <= 1){
        		alert('비밀번호를 2자리 이상 입력하세요');
        		$("#board_pass").val("").focus();
    			return false;}
    		
        } // if($("#passwordbox").is(":checked")) end
		
    	//제목 공백 검사
    	if($.trim($("#board_subject").val()) == ""){
    		alert('제목을 입력하세요');
    		$("#board_subject").focus();
			return false;
    	}
    	//내용 공백 검사
    	if($.trim($("#board_content").val()) == ""){
    		alert('글을 입력하세요.');
    		$("#board_content").focus();
			return false;
    	}
    	
	  });//$("#submit").click end
	  
	  
 
	  
	
	
});

</script>
</head>
<body>

<jsp:include page="../home/side.jsp" />

	<div class="content">
	<jsp:include page="../home/header2.jsp" />
	<div class="container-fluid pt-4 px-4"> 
	
         <div class="container" id="container">
		  <form action="add" method="post" enctype="multipart/form-data" name="boardform">
		   
		   <div class="form-group">     
		      <label for="board_name">글쓴이</label>
		      <input name="board_name" id="board_name" value="${id}" readonly
		       type="text" class="form-control" placeholder="Enter board_name">
		
		   </div>
		   
		   <div class="form-group">
		      <label for="board_pass">비밀글 설정&nbsp;&nbsp;<input type="checkbox" id="passwordbox" checked="checked" ></label>
		      <input name="board_pass" id="board_pass"  type="password" maxlength="30" 
		      class="form-control" placeholder="Enter board_pass">
		   </div>
		   
		 
		  <div class="form-group">
		    <label id="filelabel">파일첨부</label> 
		         <input id="fileName" class="fileName" value="파일선택" disabled="disabled">
			   <div class="fileRegiBtn">
				 <label for="myFileUp" id="FileUp">파일등록하기</label>
				 <input type="file" id="myFileUp" name="uploadfile">
		       </div>
		  </div>
		  
		   
		   
		   <div class="form-group">
		      <label for="board_subject">제목</label>
		      <input name="board_subject" id="board_subject"  type="text" maxlength="100" 
		      class="form-control" placeholder="Enter board_subject">
		   </div>
		   
		   <div class="form-group">
		      <label for="board_content">내용</label>
		      
		      <div class="board_style">
		      글자 색 : <input type="color" name="fontColor" id="fontColor"> &nbsp;&nbsp;
		      글자 크기 :&nbsp;<select name='fontSize' id="fontSize">
				  <option value='10px'>10px</option>
				  <option value='15px' selected>15px</option>
				  <option value='20px'>20px</option>
				  <option value='25px'>25px</option>
				  <option value='30px'>30px</option>
				  <option value='35px'>35px</option>
				  <option value='40px'>40px</option>
				  <option value='45px'>45px</option>
				  <option value='50px'>50px</option>
				  <option value='55px'>55px</option>
				  <option value='60px'>60px</option>
			  </select>
			  &nbsp;&nbsp;글자 굵기 :&nbsp;<select name='fontWeight' id="fontWeight">
				  <option value=200 >얇은</option>
				  <option value=400 selected>보통</option>
				  <option value=700 >굵은</option>
				  <option value=900>더 굵은</option>
			  </select>
		      </div>
		      <textarea name="board_content" id="board_content"   
		                rows="10" class="form-control" ></textarea>
		   </div>
		   
		   <c:if test="${admin == 'true'}">
		   <div class="form-group">
		   <label for="noticebox" style="color:orange;">공지글 설정&nbsp;&nbsp;
		   <input type="checkbox" id="noticebox" name="noticebox" value="false"></label>   
		   </div>
		   
		  </c:if>
		    <div id="button">
		    <button type="button" class="btn btn-primary m-2" id="cancel">취소</button>
		    <button type="submit" class="btn btn-primary m-2" id="submit">등록</button>
		    </div>
		    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		  </form>
		</div> <%-- contain--%>
	</div> 
	
  </div> 
     
	<footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer> 
		
</body>
</html>