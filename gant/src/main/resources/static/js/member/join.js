$(document).ready(function(){
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	let checkid = false;
	let checkpass1 = false;
	let checkpass2 = false;
	let checkname = false;
	let checkjumin1 = false;
	let checkjumin2 = false;
	let checkphone1 = false;
	let checkphone2 = false;
	let checkphone3 = false;
	let checkemail = false;
	let checkdomain = false;
	let checkcert = false;
	let checkpost = false;
	let checkaddress = false;
	
	$('#id').keyup(function(){
		const pattern = /^[A-Za-z]\w{3,15}$/;
		const id = $("#id").val();
		
		if(!pattern.test(id)){
			$('#id_message').css('color',"red").html("첫 글자는 영문, 4~16자 영문 또는 숫자로 입력하세요. ");
			checkid = false;
			return;
		}
		
		$.ajax({
			url: "idcheck",
			type : "post",
			dataType : "json",
			data: {"id" : id},
			beforeSend : function(xhr)
      			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        			xhr.setRequestHeader(header, token);			
        		},
			success : function(rdata){
				if(rdata == 0) {
					$('#id_message').css('color','green').html("사용 가능한 아이디입니다.");
					checkid=true;
				}else{
					$('#id_message').css('color','red').html("이미 사용중인 아이디입니다");
					checkid=false;
				}
			}
		});
	});
	
	$('#password,#password2').keyup(function(){
		
		const pattern = /^\w{8,20}$/;
		const pass1 = $('#password').val();
		const pass2 = $('#password2').val();
		
		if(!pattern.test(pass1)) {
			$("#pass_message").css('color','red').html("비밀번호 형식은 영문, 숫자를 조합하여 8~20자입니다.");
			checkpass1 = false;
		}else{
			$("#pass_message").html('');
			checkpass1 = true;
		}
	    
		if(pass1 == pass2 && checkpass1 == true){ //비밀번호 일치 + 첫번째 비밀번호 정상적으로 입력
			$("#pass2_message").css("color","green").html("비밀번호가 일치합니다.");
			checkpass2 = true;
		}else if(pass1 == pass2 && checkpass1 == false){ //비밀번호 일치 + 첫번째 비밀번호 비정상적으로 입력
			$("#pass2_message").html("");
			checkpass2 = false;
		}else{
			$("#pass2_message").css("color","red").html("비밀번호가 일치하지 않습니다.");
			checkpass2 = false;
		}
	});
	
	$('#name').keyup(function(){
		let message = $("#name_message");
		if($('#name').val().trim().length >= 2){
			checkname = true;
			message.html('');
		}else{
			checkname = false;
			message.css('color','red').html('두 글자 이상 입력하세요');
		}
	});
	
	$('#jumin1,#jumin2').keyup(function(){
		const pattern = /^[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|[3][01])$/;
		let jumin1 = $('#jumin1');
		let jumin2 = $('#jumin2');
	 	let message = $('#jumin_message');
	    
	  if(jumin1.val().length==6){
	 	if(pattern.test(jumin1.val())){
			jumin2.focus();
			checkjumin1 = true;
			message.html('');
		}else{
			checkjumin1 = false;
			message.css('color','red').html('주민번호 앞자리 형식이 일치하지 않습니다.');
		}
	  }else{
		checkjumin1 = false;
	  }
		
		const pattern2 = /^[1234][0-9]{6}$/;
	  if(jumin2.val().length==7) {
		if(pattern2.test(jumin2.val())) {
			checkjumin2 = true;
			if(checkjumin1==true)
				message.html('');
		}else{
			checkjumin2 = false;
			message.css('color','red').html('주민번호 뒷자리 형식이 일치하지 않습니다.');
		}		
	  }else{
		checkjumin2 = false;
	  }	
		
	});
	
	$('#phone1,#phone2,#phone3').keyup(function(){
		let phone1 = $('#phone1');
		let phone2 = $('#phone2');
		let phone3 = $('#phone3');
		let message = $('#phone_message');
		
		if(phone1.val().length==3){
			if($.isNumeric(phone1.val())) {
				message.html('');
				checkphone1 = true;
				phone2.focus();
			}else{
				message.css('color','red').html('숫자로 다시 입력하세요');
				checkphone1 = false;
				phone1.val('');
			}
		}else{
			checkphone1 = false;
		}
		
		if(phone2.val().length==4){
			if($.isNumeric(phone2.val())) {
				message.html('');
				checkphone2 = true;
				phone3.focus();
			}else{
				message.css('color','red').html('숫자로 다시 입력하세요');
				checkphone2 = false;
				phone2.val('');
			}
		}else{
			checkphone2 = false;
		}
		
		if(phone3.val().length==4){
			if($.isNumeric(phone3.val())) {
				message.html('');
				checkphone3 = true;
			}else{
				message.css('color','red').html('숫자로 다시 입력하세요');
				checkphone3 = false;
				phone3.val('');
			}
		}else{
			checkphone3 = false;
		}
		
	});	
	
	$('#email').keyup(function() {
		const pattern = /^\w+$/;
		const email = $(this).val();
		if(!pattern.test(email)){
			$("#email_message").css("color","red").html("이메일 형태가 일치하지 않습니다.");
			checkemail = false;
		}else{
			$("#email_message").html('');
			checkemail = true;
		}
	});
	
	$('#domain').keyup(function(){
		const pattern = /^\w+[.][A-Za-z]{3}$/;
		const domain = $(this).val();
		if(!pattern.test(domain)){
			$("#email_message").css("color","red").html("이메일 형태가 일치하지 않습니다.");
			checkdomain = false;
		}else{
			$("#email_message").html('');
			checkdomain = true;
		}
		
	});
	
	
	//이메일 도메인 올바르게 입력 시 '인증번호 발송'버튼 활성화
	$('#certsend').attr('disabled',true);
	$('#email,#domain').keyup(function(){ 
		if(checkemail==true && checkdomain==true){
			$('#certsend').attr('disabled',false);
		}else{
			$('#certsend').attr('disabled',true);
		}
	});

	//인증번호 발송 클릭 시 '인증번호 확인'버튼 활성화 , 기본값 비활성화
	$('#certcheck').attr('disabled',true);
	
	$('#certsend').click(function(){
		if(checkemail==true && checkdomain==true){
			$('#certsend').text('인증번호 재발송');
			$('#certcheck').attr('disabled',false);
			
			let emdomain = $('#email').val() + "@" + $('#domain').val();
			console.log(emdomain);
			$.ajax({
				url: "sendCert",
				type : "post",
				dataType : "json",
				data : {"emdomain" : emdomain},
				beforeSend : function(xhr)
      			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        			xhr.setRequestHeader(header, token);			
        		},
				success: function(rdata) {
					console.log("1234");
					console.log(rdata.certnum);
					console.log(rdata.result);
					certnum = rdata.certnum;
					alert(rdata.result);
				}
			});
		}else{
			alert("인증번호 발송을 실패했습니다. 형식을 올바르게 입력하세요");
		}
	});
	
	$("#certcheck").click(function(){
		let input = $("#certnum").val();
		if(certnum==input){
			checkcert = true;
			alert("인증을 성공했습니다.");
			$("#certcheck").text("인증완료");
			$("#certcheck").attr('disabled',true);
			
		}else{
			checkcert = false;
			alert("인증번호가 틀렸습니다.");
		}
	});
	
$('#spost').click(function(){
	Postcode();
  });
  
  //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
 function Postcode() {
        new daum.Postcode({
            oncomplete: function(data) {
            	console.log(data.zonecode)
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
 
                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수
 
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }
 
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                 $("#post").val(data.zonecode); //5자리 새우편번호 사용
                $("#address").val(fullRoadAddr);
            }
        }).open();
    };//function Postcode()
	
	
		let message = $('#address_message');
		if($('#address').val().trim()==''){
			checkaddress = false;
			message.css('color','red').html('주소를 입력하세요');
		}else{
			checkaddress = true;
			message.html('');
		}
	
	$('form').submit(function(){
		
		if(!checkid){
			alert("아이디를 확인하세요");
			$('#id').focus();
			return false;
		}
		
		if(!checkpass1){
			alert("비밀번호를 확인하세요");
			$('#password').focus();
			return false;
		}
		
		if(!checkpass2){
			alert("비밀번호를 확인하세요")
			$('#password2').focus();
			return false;
		}
		
		if(!checkname) {
			alert("이름을 입력하세요");
			$("#name").focus();
			return false;
		}
		
		if(!checkjumin1){
			alert("주민번호 앞자리를 확인하세요");
			$('#jumin1').focus();
			return false;
		}
		
		if(!checkjumin2){
			alert("주민번호 뒷자리를 확인하세요");
			$('#jumin2').focus();
			return false;
		}
		
		if(!checkphone1){
			alert("휴대폰 번호 첫번째 자리를 확인하세요");
			$('#phone1').focus();
			return false;
		}
		
		if(!checkphone2){
			alert("휴대폰 번호 가운데 자리를 확인하세요");
			$('#phone2').focus();
			return false;
		}
		
		if(!checkphone3){
			alert("휴대폰 번호 마지막 자리를 확인하세요");
			$('#phone3').focus();
			return false;
		}
		
		if(!checkemail){
			alert("이메일 형식을 확인하세요")
			$('#email').focus();
			return false;
		}
		
		if(!checkdomain){
			alert("이메일 형식을 확인하세요")
			$('#domain').focus();
			return false;
		}
		
		if(!checkcert){
			alert("이메일 인증을 해주세요");
			$('#certnum').focus();
			return false;
		}
		
		if($('#post').val().trim()==''){
			checkpost = false;
		}else{
			checkpost = true;
		}
		
		if(!checkpost){
			alert("우편번호를 확인하세요");
			$("#post").focus();
			return false;
		}
		
		if($('#address').val().trim()==''){
			checkaddress = false;
		}else{
			checkaddress = true;
		}
		
		if(!checkaddress){
			alert("주소를 입력하세요");
			$('#address').focus();
			return false;
		}
		
		if($("#department option:selected").val()==''){
				alert("부서명을 선택해주세요");
				$('#department').focus();
				return false;
		}
		
		if($("#position option:selected").val()==''){
			alert("직급을 선택해주세요");
			$('#position').focus();
			return false;
		}
		
		if($("#department option:selected").val()=='대표' && $("#position option:selected").val()!='대표'){
				alert("부서명과 직급을 올바르게 선택해주세요");
				return false;
		}
		
		if($("#department option:selected").val()!='대표' && $("#position option:selected").val()=='대표'){
				alert("부서명과 직급을 올바르게 선택해주세요");
				return false;
		}
		
	});
});
