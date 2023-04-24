$(document).ready(function(){

	
	$("#cancel").click(function(){
		history.back(-1);			
    });
	
	//submit할때 이벤트 부분
	$("#add").click(function(){
		
		if($.trim($("#r_name").val()) ==""){
			alert("명단이 비었습니다.");
			$("#board_subject").focus();
			return false;
		}
		if($.trim($("#deadline").val()) ==""){
			alert("기한을 입력하세요");
			$("#board_subject").focus();
			return false;
		}

		if($.trim($("#board_subject").val()) ==""){
			alert("제목을 입력하세요");
			$("#board_subject").focus();
			return false;
		}
		if($.trim($("#board_content").val()) ==""){
			alert("내용을 입력하세요");
			$("#board_content").focus();
			return false;
		}
	}); //submit end
}); //ready() end