$(document).ready(function(){
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	let checkemail = false;	   //이메일 형식 일치 여부
	let checksendcert = false; //인증번호 발송 눌렀는지
	let checkcertnum = false; //인증번호 일치 여부
	
	$("a:eq(1)").click(function(){
		return false;
	});
	
	const pattern = /^\w+[@]\w+[.][A-Za-z]{3}$/; //이메일 형식
	var email = $('#email');
	
	$('#sendcert').attr('disabled',true); //기본값 인증번호발송버튼 비황성화
	$('#email').keyup(function(){ 
		if(pattern.test(email.val())) {
			checkemail = true;
			$('#sendcert').attr('disabled',false);
		}else{
			checkemail = false;
			$('#sendcert').attr('disabled',true);
		}
	});		
	
	$("#sendcert").click(function(){
		if(checkemail==true){
		$('#sendcert').text('인증번호 재발송');
		const emdomain = $('#email').val();
		$.ajax({
				url: "sendCert",
				type: "post",
				dataType : "json",
				data : {"emdomain" : emdomain},
				beforeSend : function(xhr)
      			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        			xhr.setRequestHeader(header, token);			
        		},				
				success: function(rdata){
					certnum = rdata.certnum;
					alert(rdata.result);
					checksendcert = true;
				}
			});
		}
	});
	
		
	$('form').submit(function(){
		
		if($('#id').val().trim()==''){
			alert("아이디를 입력하세요");
			$('#id').focus();
			return false;
		}
		
		if($('#name').val().trim()==''){
			alert("이름을 입력하세요");
			$('#name').focus();
			return false;
		}
		
		if(!pattern.test(email.val())) {
			alert("이메일 주소를 형식에 맞게 입력하세요");
			email.focus();
			return false;
		}
		
		if(!checksendcert){
			alert("인증번호를 발송해주세요");
			email.focus();
			return false;
		}
		
		let input = $("#certnum").val();
		if(certnum==input){
			checkcertnum = true;
		}else{
			checkcertnum = false;
		}

		if($('#certnum').val().trim()==''){
			alert("인증번호를 입력하세요");
			$('#certnum').focus();
			return false;
		}else if(!checkcertnum){
			alert("인증번호가 틀렸습니다.");
			$('#certnum').focus();
			return false;
		}
	});
});