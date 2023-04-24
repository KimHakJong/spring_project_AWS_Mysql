$(document).ready(function(){

	$("form[name=modifyform]").submit(function(){
		

		if($.trim($("#board_subject").val())==""){
			alert("제목를 입력하세요");
			$("#board_subject").focus();
			return false;
						
		}
		if($.trim($("#board_content").val())==""){
			alert("내용를 입력하세요");
			$("#board_content").focus();
			return false;
						
		}
	
	});
	
	
});