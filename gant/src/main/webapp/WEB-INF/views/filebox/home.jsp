<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="../resources/js/jquery-3.6.3.js"></script>
<title>Insert title here</title>
<style>
.content{
height:800px !important
}
/* 폴더모달 시작*/

/* The Modal (background) */
.modal {
  font-family: Arial, Helvetica, sans-serif !important;
  display: none; /* Hidden by default */
  position: fixed; /* Stay in place */
  z-index: 1; /* Sit on top */
  padding-top: 100px; /* Location of the box */
  left: 0;
  top: 0;
  width: 100%; /* Full width */
  height: 100%; /* Full height */
  overflow: auto; /* Enable scroll if needed */
  background-color: rgb(0,0,0); /* Fallback color */
  background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
}

/* Modal Content */
.modal-content {
  background-color: #fefefe;
  margin: auto;
  padding: 25px 25px 20px 25px;
  border: 1px solid #888;
  width: 23% !important;
  margin-top:8%;
}
.modal-content h4{
	margin-left:5px;
}
#input_fname{
	width:100%;
	height:50px;
	border:1px solid #C4C5C8;
	border-radius:4px;
	outline:none;
	margin: 15px 0px 25px 0px;
	padding:15px;
}
#modal_btndiv button{
	float:right;
	height:40px;
	width:60px;
	border:none;
	border-radius:4px;
	color:#26abff;
	background:transparent;
	
}
#modal_btndiv button:hover{
	border:1px solid #26abff;
}
#modal_btndiv button:active{
	background:#26abff;
	color:white;
}
/* The Close Button */
.close {
}

.close:hover,
.close:focus {
}
.close + button {
	margin-right:13px;
}
/* 폴더모달 끝 */
*{box-sizing:border-box; font-family:"noto sans", sans-serif;}
.content{
}
#path > a {
	color:black;
	font-weight:bold;
	font-size:19px;
	padding:10px;
}
#path > a:hover{
background: #26abff;
border-radius: 25px;
cursor:pointer;
color:white;
}
#path span{
	color:black !important;
}
#path > .nowpath{
	color:#26abff !important;
	cursor:default !important;
}
.nowpath:hover{
	background:none !important;
}
.btn-check:checked+.btn-outline-primary, .btn-check:active+.btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary.active, .btn-outline-primary.dropdown-toggle.show {
    color: white !important;
}
label.btn.btn-outline-primary:hover {
    color: white;
}
.btn-group{
	left:11.2%;
	margin-top:1.5rem
}
/* 이동하기 div */
#move {
    background: white;
    border: none;
    position: absolute;
    z-index: 3;
    margin-top: -35px;
    padding: 15px 20px;
    width: 320px;
    font-size: 15px;
    color: black;
    display: none;
    border-radius: 4px;
    box-shadow: rgba(0, 0, 0, 0.35) 0px 5px 15px;
}
#move h5 {
font-size:1.15rem;
margin-bottom:12px;

}
div#move_content {
    border: 1px solid #ced4da;
    border-radius: 4px;
    padding: 10px;
}
#move ul {
	padding-left:5px;
	cursor:default;
}
#move li{
	list-style:none;
	margin: 3px 0px;
}
#move img {
    width: 22.5px;
    height: 22.5px;
    margin-right:4px;
}
.subicon{
	margin-right:0px !important;
}
#move_content > ul > li > ul{/* 첫번째 ul은 간격이 너무 넓음 */
	padding-left:7px !important;
}
#move li ul {
	padding-left:33px;
}
.move_select {
    width: 17px !important;
    height: 17px !important;
    position: relative;
    left: 5px;
    bottom: 1.1px;
}
#move span {
    display: inline-block;
    position: relative;
    top: 1.8px;
}

#move_button{
	float:right;
	margin-top:10px;
}
#move_button button{
	height:35px;
	color:#26abff;
	background:white;
	border:1px solid transparent;
	border-radius:4px;
	
}
#move_button button:first-child{
}

#move_button button:hover{
	border:1px solid #26abff;
	color:white;
	background:#26abff;
}
/* 이동하기 div 끝 */
.home{
	/*width:89%;*/
	width:78%;
	position:relative;
	height:80%;
	transform: translate(-50%, 0%);
	left:50%;
	margin-top:3%
}
.nowpath:first-child{
	padding-left:0px;
}
#file_menu {
    width: 100%;
    height: 40px;
    margin-top: 2%;
}
#file_menu form{
	width:170px;
	float:right;
}

#newbtn {
    height: 38px;
    width: 70px;
    font-size: 14px;
    border-radius: 4px;
    border: none;
    color: white;
    background: #ff9300;
    cursor:pointer;
}
#newbtn:hover{
	opacity:0.8;
}
#uploadbtn {
    height: 38px;
    border-radius: 4px;
    background: #26abff;
    color: white;
    border: none;
    line-height: 35px;
    width: 90px;
    text-align: center;
    font-size: 14px;
    cursor:pointer;
    position:relative;
    bottom:1.3px;
}
#uploadbtn:hover{
	opacity:0.8;
}

#uploadbtn img {
    height: 18px;
    width: 18px;
    position: relative;
    bottom: 1.5px;
    margin-right: 5px;
}
#upfile{
	display:none;
}
#file_content {
    width: 100%;
    border: 1px solid #ced4da;
    height: 610px;
    margin-top: 17px;
    position:relative;
    padding:25.8px 38px;
    overflow-y : scroll;
   -ms-overflow-style: none; /* 인터넷 익스플로러 */
    scrollbar-width: none; /* 파이어폭스 */
    cursor:default;
    border-radius:4px;
}
.menuicon:hover{
	cursor:pointer !important;
}
#file_content::-webkit-scrollbar {
    display: none; /* 크롬, 사파리, 오페라, 엣지 */
}
.wrap_file{
	display:inline-block;
	margin:15px 25.8px;
	/* 27.6px*/
}
.file_show{
	width:150px;
	height:150px;
	border:1px solid #ced4da;
	/*border:1px solid #d4d4d4;*/
	border-radius:4px;
	text-align:center;
	line-height:150px;
}
.file_show:hover {
    background: aliceblue;
}
img.foldericon, .fileicon {
    width: 80px;
    height: 80px;
}
.img{/*
	width:100%;
	height:100%;
	margin-bottom:8px;*/
	border-radius:4px;
}

.menuicon {
    width: 30px;
    height: 30px;
    position: absolute;
    margin-top: 6px;
    margin-left: 6px;
    display:none;
}/*
.img + .menuicon{
	margin-left:-29px;
}*/
#menudiv {
    text-align: left;
    display: inline-block;
    position: absolute;
    box-shadow: rgba(0, 0, 0, 0.15) 2.4px 2.4px 3.2px;
    border-radius: 4px;
    background: white;
    font-size: 14px;
    margin-left: -25px;
    margin-top:15px;
    width:130px;
    color:black;
}
#menudiv ul {
    list-style: none;
    margin: 0px;
    padding: 0px;
    width:100%;
}
#menudiv li {
    height: 33px;
    line-height: 33px;

    width:100%;
}
#menudiv li:hover{
	background:#F3F6F9;
	cursor:pointer;
}
#menudiv li a{
	display:inline-block;
	width:100%;
	padding: 0px 15px;
}
#menudiv img {
    width: 18px;
    height: 18px;
    margin-right: 10px;
}
.file_name {
    width: 150px;
    height: 20px;
    border: none;
    font-size: 14px;
    line-height: 20px;
    text-align: center;
    margin-top: 8px;
    color:black;
}
.edit_name{
	text-align:center;
	border-radius:4px;
	width:100%;
	display:none;
}
</style>
<script>
$(document).ready(function(){
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");	
	let p_no = ${p_no};//현재프로젝트 번호
	
		//console.log($("#path").children().last().data('url')); //폴더경로
		//console.log($("#path").children().last().text()); //폴더이름
	
	loadAll(); //처음 페이지들어갔을 때 불러옴
		
	//파일,폴더정보 불러옴
	function loadAll(){
		//프로젝트번호 폴더번호 폴더경로
		let included_folder_num = $("#path").children().last().data('num');
		let folder_path = $("#path").children().last().data('url');
		
		console.log("불러올 때");
		console.log("현재 폴더번호:"+included_folder_num);
		console.log("현재 폴더경로:"+folder_path);
		$("#file_content").empty();
		$.ajax({
			url : "loadAll",
			type : "post",
			data : { "p_no" : p_no , "included_folder_num" : included_folder_num, "folder_path" : folder_path },
			dataType : "json",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(rdata){
    			
    			
    			let output = '';
    			//폴더추가
    			$(rdata.folder).each(function(){
    				let folder_name = this.folder_name;
    				if(folder_name.length>12){
    					folder_name = folder_name.substring(0,10)+"..."; 
    				}
    				output += '<div class="wrap_file">'
    						+ 	'<div class="file_show thisfolder" data-url="'+this.folder_path+'" data-folder_num="'+ this.folder_num+'"><img class="foldericon" src="../resources/image/filebox/foldericon.png">'
    						+ 		'<img class="menuicon" src="../resources/image/filebox/menuicon2.png">'
    						+ 	'</div>'
    						+ 	'<div title="'+ this.folder_name+'" class="file_name"><span>'+ folder_name + '</span><input class="edit_name" type="text" value="'+ this.folder_name+'"></div>'
    						+ '</div>';
    			});
    			$("#file_content").append(output);

    			
    			//파일추가
    			output = '';
    			$(rdata.file).each(function(){
    				let file_name = this.FILE_NAME + '.' + this.EXTENSION;
    				if(file_name.length>12){
    					file_name = file_name.substring(0,10)+"..."; 
    				}
    				output += '<div class="wrap_file">'
    						+ '<div class="file_show thisfile" data-file_num="'+ this.FILE_NUM 
    						+ '" data-id="'+ this.ID +'" data-save_path="'+this.FILE_SAVE_PATH + '">';
    						
    						const pattern = /(gif|jpg|jpeg|png)$/i;
    						if(pattern.test(this.EXTENSION)){
    							output += '<img class="fileicon img" src="../fileboxupload/'+ this.FILE_SAVE_PATH +'">';	
    						}else if (this.EXTENSION.toUpperCase()=='PDF'){
    							output += '<img class="fileicon" src="../resources/image/filebox/pdficon.png">';
    						}else if (this.EXTENSION.toUpperCase()=='PPTX'){
    							output += '<img class="fileicon" src="../resources/image/filebox/ppticon.png">';
    						}else if (this.EXTENSION.toUpperCase()=='XLSX'){
    							output += '<img class="fileicon" src="../resources/image/filebox/xlsxicon.png">';
    						}else if (this.EXTENSION.toUpperCase()=='DOCX'){
    							output += '<img class="fileicon" src="../resources/image/filebox/docxicon.png">';
    						}else if (this.EXTENSION.toUpperCase()=='TXT'){
    							output += '<img class="fileicon" src="../resources/image/filebox/txticon.png">';
    						}else{
    							output += '<img class="fileicon" src="../resources/image/filebox/etcicon.png">';
    						}
    						
    				output += '<img class="menuicon" src="../resources/image/filebox/menuicon2.png">'
    						+ '</div>'
    						+ '<div title="'+ this.FILE_NAME+'.'+this.EXTENSION+'" class="file_name" data-name="'+ this.FILE_NAME+'"><span>'+ file_name + '</span>'
    						+ '<input class="edit_name" type="text" value="'+ this.FILE_NAME+'"></div>'
    						+ '</div>';
    						
    				//console.log("넘어온파일번호:"+this.FILE_NUM);
    				//console.log("넘어온파일번호:"+this.ID);
    				//console.log("넘어온파일번호:"+this.FILE_NAME);
    				//console.log("넘어온파일번호:"+this.EXTENSION);
    				//console.log("넘어온파일경로:"+this.FILE_SAVE_PATH);
    				
    			});
    			$("#file_content").append(output);
    		},
    		error : function(xhr,status,error){
    			alert("파일로드오류:"+error);
    		}
		})
	}
	
	//상단에 폴더이름 클릭: 해당폴더의 경로로 이동
	$("body").on('click',"#path a",function(){
		if($(this).index() !=$("#path").children().last().index()){
			
			let click_index = $(this).index();
			let last_index = $("#path").children().last().index();
		
			$(".nowpath").removeClass("nowpath");
			$(this).addClass("nowpath");
		
			//클릭한 인덱스~마지막인덱스는 지움
			for(var i=click_index; i<last_index; i++){
				$(this).next().remove();
			}
			loadAll();
		}
	});
		
	//새폴더만들 때
	$("#folder_insertbtn").click(function(){
		let folder_name = $("#input_fname").val();
		let folder_path = $("#path").children().last().data('url')+folder_name+"/"; //폴더생성할 현재 경로+새폴더이름
		
		
		console.log("새 폴더 만들 때");
		console.log("프로젝트 번호:"+p_no);
		console.log("새폴더 이름:"+folder_name);
		console.log("새폴더 경로:"+folder_path);
		let can_newfolder = 1;
		$(".thisfolder").next().each(function(){
			if(folder_name == $(this).attr('title')) {
				can_newfolder = 0;
			}
		});
		if(can_newfolder == 0 ){ //중복폴더 있으면
			alert("중복된 폴더명 입니다.");
		}else{ //중복된 폴더명 없으면
			
		
		$.ajax({
			url : "addFolder",
			type : "post",
			data : {"p_no" : p_no, "folder_name" : folder_name, "folder_path" : folder_path },
			dataType : "json",
			async: false,
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
			success : function(rdata){
				if(rdata==1){
					alert("폴더를 생성했습니다.");
				}
			},
			error : function(xhr,status,error){
				console.log("폴더 생성을 실패했습니다.");
			}
		});//ajax
		$("#folder_modal").css('display','none');
		loadAll();
		}
	});
		
	//파일업로드 할 때
	$("body").on('change','#upfile',function(){

		let id = $(".side_userid").text();
		let included_folder_num = $("#path").children().last().data('num');
		let folder_path = $("#path").children().last().data('url');
		let fake_file_name = $(this).val().split("\\");
		let real_file_name = fake_file_name[fake_file_name.length-1];
		let split_file_name = real_file_name.split(".");
		
		let file_name = '';
		for(var i=0; i<split_file_name.length-1;i++){//파일이름에 .이 섞여있을 수 있으므로 마지막 확장자 앞에는 다 파일명임
			if(i==split_file_name.length-2){ 
				file_name += split_file_name[i]; //맨마지막 에는 .을 추가 X
			}else{
				file_name += split_file_name[i]+"."; //기존에 지워졌던 .을 추가
			}
		}
		let extension = split_file_name[split_file_name.length-1];
		
		let noname = 0;
		//업로드할 때 동일 파일명 체크
		$(".edit_name").each(function(){
			if(file_name==$(this).val()){
				alert("업로드를 실패했습니다.\n현재 폴더에 동일한 파일명이 존재합니다.");
				noname = 1;
				return false;
			}
		});
		
		//파일크기 초과 : 알림창, 값초기화
		var maxSize = 20 * 1024 * 1024; // 20MB
	
		var fileSize = $("#upfile")[0].files[0].size;
		console.log("파일크기는?:"+fileSize);
		if(fileSize > maxSize){
			alert("첨부파일 사이즈는 20MB 이내로 등록 가능합니다.");
			$("#upfile").val("");
		}else{
			
		if(noname==0){
		
		console.log("파일업로드할 때");
		console.log("프로젝트번호:"+p_no); //프로젝트번호
		console.log("파일작성자:"+$('.side_userid').text()); //아이디(파일 작성자)
		console.log("파일이 포함될 폴더번호:"+$("#path").children().last().data('num')); //포함될 폴더번호
		console.log("파일이 포함될 폴더번호:"+$("#path").children().last().data('url')); //포함될 폴더경로
		console.log("파일이름(확장자 앞):"+file_name); //파일이름(확장자 앞)
		console.log("확장자:"+extension); //확장자
		
		var file = $("#upfile")[0].files[0];
		var formData = new FormData();
		formData.append('file',file);
		
		var data = {
				p_no: p_no,
				id : id,
				included_folder_num : included_folder_num,
				file_name : file_name,
				extension : extension,
				folder_path : folder_path
		}
		formData.append("value_store",new Blob([JSON.stringify(data)], {type:"application/json"}));
		
		$.ajax({
			url : "fileUpload",
			type : "post",
			data : formData,
			dataType : "json",
    		contentType: false,
    		processData: false,
    		cache : false,
    		async: false,
    		enctype: 'multipart/form-data',
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function (rdata){
    			if(rdata==1){
    				alert("파일이 업로드되었습니다.");
    				//파일로드하는 함수호출!
    			}
    		},
    		error : function(xhr,status,error){
    			console.log("파일업로드ajax오류:"+error);
    		}
			
		});//ajax
		loadAll();
		}//이름중복 if 끝
		}//파일용량 if끝
	});
	
	//폴더클릭
	$('body').on('click',".thisfolder",function(){
		let change_url = $(this).data('url');
		let change_folder_num = $(this).data('folder_num');
		let change_folder_name = $(this).next().text();
		
		$(".nowpath").removeClass("nowpath");
		let output = '<span> > </span>'
				   + '<a class="nowpath" data-url="'+change_url+'" data-num="'
				   + change_folder_num + '">'+ change_folder_name + '</a>';
		$("#path").append(output);
		loadAll();
	});
	
	//파일,폴더에 커서 : 메뉴바생김
	$('body').on('mouseenter','.file_show',function(){
		$(this).find(".menuicon").css('display','inline-block');
	});
	$('body').on('mouseleave','.file_show',function(){
		$(this).find(".menuicon").css('display','none');
	});
	
	$("body").on('click','.menuicon',function(event){
		event.stopPropagation();
		if($("#menudiv").attr('id')=='menudiv'){ //감싸는div 옆에 menudiv 있으면 삭제
			$("#menudiv").remove();
		}else{ //없으면 생성
			let menudiv ='<div id="menudiv"><ul><li><a><img src="../resources/image/filebox/edit.png">이름바꾸기</a></li>'
						+						'<li><a><img src="../resources/image/filebox/down.png">다운로드</a></li>'
						+						'<li><a><img src="../resources/image/filebox/move.png">이동</a></li>'
						+						'<li><a><img src="../resources/image/filebox/delete.png">삭제</a></li></ul></div>';
			$(this).parent().parent().after(menudiv);
		}
	});
	
	//해당 메뉴제외한 곳 클릭하면 사라지게
	$(document).click(function(e){ 
	    if (!$(e.target).is('#menudiv')) { 
			$("#menudiv").remove();
	    }
	});
	
	//이름바꾸기 클릭
	$('body').on('click','#menudiv li:eq(0) a',function(){
		$(this).parent().parent().parent().prev().find(".edit_name").css('display','inline-block').select();
		$(this).parent().parent().parent().prev().find("span").css('display','none');
	});
	
	//이름바꾸기 완료: 공백 - 값원상복귀 , 다름 - 이름변경 ajax로 보냄
	$('body').on('blur',".edit_name",function(){

		if($(this).val().trim()==""){ //공백일 때
			if($(this).parent().data('name')){//파일명인 경우 원래파일명으로
				$(this).val($(this).parent().data('name'));
			}else{//폴더인 경우 원래파일명으로
				$(this).val($(this).prev().text());
			}
			$(this).prev().css('display','inline-block');
			$(this).css('display','none');
		}else if($(this).val()==$(this).prev().text() || $(this).val()==$(this).parent().data('name')){ //값 똑같을 때
			$(this).prev().css('display','inline-block');
			$(this).css('display','none');			
		}else{ //변경 값 있을 때
			let name = $(this).val();
			let can = 1;
			$(this).prev().css('display','inline-block');
			$(this).css('display','none');
			if($(this).parent().prev().attr('class')=='file_show thisfile'){//파일인 경우
				$(".thisfile").next().each(function(){
					if(name == $(this).data('name')){
						$(this).val($(this).parent().data('name'));//원래파일명으로
						can = 0;	
					}
				});
				if(can==1){
				let file_num = $(this).parent().prev().data('file_num');
				edit_name_ajax(file_num,'파일',name);
				}else if(can==0){
					alert("현재 경로에 동일한 파일명이 있습니다.");
				}
			}else{//폴더인 경우
				$(".thisfolder").next().each(function(){
					if(name == $(this).attr('title')) {
						$(this).val($(this).parent().attr('title'));//원래파일명으로
						can = 0;
					}
				});
				if(can==1){
				let folder_num = $(this).parent().prev().data('folder_num');
				edit_name_ajax(folder_num,'폴더',name);
				}else if(can==0){
					alert("현재 경로에 동일한 폴더명이 있습니다.");
				}
			}
			
			loadAll();
		}
			function edit_name_ajax(what_num,type,name){
				
				$.ajax({
					url : "editName",
					type : "post",
					data : { "num" : what_num , "type" : type, "name" : name },
					dataType : "json",
					async : false,
					beforeSend : function(xhr)
		  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
		    			xhr.setRequestHeader(header, token);			
		    		},
		    		success : function(rdata){
		    			alert("이름이 수정되었습니다.");
		    		},
		    		error : function(xhr,status,error){
		    			console.log("이름수정중 오류발생:"+error);
		    		}
				});
			}
	}); //이름변경끝
	
	//다운로드 클릭 시 폼에 파일이름,경로 실어서 전송
	$('body').on('click','#menudiv li:eq(1) a',function(){
		let selector = $(this).parent().parent().parent().prev(); //클릭한 파일 또는 폴더에 해당하는 div
		if(selector.find('.file_show').attr('class')=='file_show thisfolder'){ //폴더인 경우
			let folder_path = selector.find('.thisfolder').data('url'); //폴더경로
			let folder_name = selector.find('.file_name').attr('title'); //폴더이름
			$("#down_folder_path").val(folder_path);
			$("#down_p_no").val(p_no); //프로젝트 번호
			$("#down_folder_name").val(folder_name);
			console.log("폴더경로어디야?"+folder_path);
			console.log("폴더이름?:"+folder_name);
			$("#down2").submit();
			
		}else if(selector.find('.file_show').attr('class')=='file_show thisfile'){ //파일인 경우
			let file_fullname = selector.find('.file_name').attr('title'); //원본파일명.확장자
			let file_save_path = selector.find('.thisfile').data('save_path'); //파일경로+임의파일명
			$("#down_name").val(file_fullname); //확장자포함한 파일명을 넘긴다.
			$("#down_path").val(file_save_path);			
			$("#down").submit();
		}

	});

	//이동div에서 하위폴더를 가져오는 함수
	function loadFolderForMove(folder_path, p_no, where_append,disting){
		
		$.ajax({
			url : "loadFolderForMove",
			type : "post",
			data : { "folder_path" : folder_path , "p_no" : p_no },
			dataType : "json",
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(rdata) {
    			let output = '';
    			
    			if(rdata!=null){
    				output +='<ul class="toggle">';	
    				$(rdata).each(function(){
    					output += '<li data-folder_path="'+this.folder_path+'"><a>';
    					if(disting != 'first'){ //처음폴더가 아닌 경우 꺽은선이미지 넣음
    						output += '<img class="subicon" src="../resources/image/filebox/line.png">';
    					}
    					output +='<img src="../resources/image/filebox/foldericon.png"><span>'+this.folder_name+'</span></a></li>';
    				});
    				output += '</ul>';

    			}else{
    				//output +='<h5>폴더가 존재하지 않습니다.</h5>';
    			}
    			where_append.append(output);
    		},
    		error : function(xhr,status,error) {
    			console.log("파일/폴더 이동 중 불러오는 오류 발생:"+error);
    		}
		})//ajax
	}//function
	
	folder_to_move = "";
	file_to_move = "";
	//이동 클릭 (폴더의 맨처음 경로의 폴더들을 가져온다.)
	$("body").on('click',"#menudiv li:eq(2) a",function(){
		let what_type = $(this).parent().parent().parent().prev().find('.file_show');//폴더인지 파일인지
		if(what_type.attr('class')=='file_show thisfolder') { //폴더
			folder_to_move = what_type.data('url'); //선택한 폴더경로
		}else if(what_type.attr('class')=='file_show thisfile') { //파일
			file_to_move = what_type.data('file_num');//선택한 파일번호
		}
		$("#move").css('display','block');	
		let folder_path = $("#path").children().first().data('url');
		$("#move_content").empty();
		loadFolderForMove(folder_path, p_no, $("#move_content"),'first');
	});//이동클릭 끝
	
		//이동안에서 폴더클릭(하위 폴더 보여줌)
		$('body').on('click','#move_content li',function(event){
			event.stopPropagation();
			if($(this).data('folder_path')!=$(".move_select").parent().parent().data('folder_path')){ //기존 체크되있는 것과 다른 경우
				$(".move_select").remove();
				$(this).children().first().append('<img class="move_select" src="../resources/image/filebox/checkicon.png">');
			}
			
			let folder_path = $(this).data('folder_path'); //클릭한 폴더의 경로
			if($(this).find('.toggle').attr('class')=='toggle'){
				$(this).find('.toggle').remove();
			}else{
				loadFolderForMove(folder_path, p_no, $(this),'');
			}
			
		});//하위폴더클릭 끝
	
	//이동div에서 이동하기
	$("#move_button button").eq(0).click(function(){
		if($(".move_select").attr('class')=='move_select'){ //체크된 게 있으면
			let folder_path = $(".move_select").parent().parent().data('folder_path');
			
			//파일을 이동하려는 경우 : folder_to_move값은 '' , 폴더를 이동하려는 경우 : file_to_move값은 ''
			$.ajax({
				url : "updateForMove",
				type : "post",
				data : { "p_no": p_no, "folder_path" : folder_path, "folder_to_move" : folder_to_move , "file_to_move" : file_to_move },
				dataType : "json",
				async : false,
				beforeSend : function(xhr)
	  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},
	    		success : function(rdata) {
	    			if(rdata==1){
	    				alert("해당 파일이 이동되었습니다.");
	    			}else if(rdata==2){
	    				alert("해당 폴더가 이동되었습니다.");
	    			}
	    		},
	    		error : function(xhr,status,error) {
	    			console.log("파일/폴더이동중 오류발생:"+error);
	    		}
			})
			
			$("#move").css('display','none');
			$(".move_select").removeClass("move_select");
			loadAll();
			
		}else{
			alert("이동할 폴더를 체크해주세요");
		}
		
	});
		
	//이동div에서 취소
	$("#move_button button").eq(1).click(function(){
		$("#move").css('display','none');
		$(".move_select").removeClass("move_select");
		folder_to_move = ''; //이동시킬 폴더경로와 파일번호를 초기화
		file_to_move = '';
	});
	
	//삭제 클릭 ( 폴더삭제는 관리자와 프로젝트생성자만 가능 )
	$('body').on('click','#menudiv li:eq(3) a',function(){
		let id = $(".side_userid").text();
		let selector = $(this).parent().parent().parent().prev().find('.file_show');
		if(selector.attr('class')=='file_show thisfile') {//파일div가 존재하면
			let file_num = selector.data('file_num');
			delete_ajax(id,file_num,'파일',p_no,'');
			
		}else if (selector.attr('class')=='file_show thisfolder') { //폴더div가 존재하면
			let folder_num = selector.data('folder_num');
			let folder_path = selector.data('url');
			delete_ajax(id,folder_num,'폴더',p_no, folder_path);
		}
		
		loadAll();
		function delete_ajax(id, num, type, p_no, folder_path){
			
		$.ajax({
			url : "delete",
			type : "post",
			data : { "id" : id, "num" : num, "type" : type, "p_no": p_no, "folder_path" : folder_path},
			dataType : "json",
			async : false,
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
    			xhr.setRequestHeader(header, token);			
    		},
    		success : function(rdata){
    			console.log("삭제클릭 ajax");
    			
    			if(rdata>0){
    				alert("삭제되었습니다.");
    			}else{
    				alert("삭제권한이 없습니다.");
    			}
    		},
    		error : function(xhr,status,error){
    			console.log("파일/폴더 삭제 중 오류 발생");
    		}
		});//ajax
		}//function
		
	});
	
	$("#newbtn").click(function() {
		$("#folder_modal").css('display','block');
		$("#input_fname").val("새 폴더");
		$("#input_fname").select();
	});
	
	$(".close").click(function() {
		$("#folder_modal").css('display','none');
	});

	$("window").click(function(event) {
		if(event.target == $("#folder_modal")){
			$("#folder_modal").css('display','none');
		}
	});
});

</script>
</head>
<body>
<jsp:include page="../home/side.jsp" />

<div class="content">
<jsp:include page="../home/header2.jsp" />
    				  <div class="btn-group" role="group">
                  <input type="radio" class="btn-check" name="btnradio" checked="checked" id="btnradio1">
					<label class="btn btn-outline-primary" for="btnradio1">파일 보관함</label>

                    <input type="radio" class="btn-check" name="btnradio" id="btnradio2" >
                    <label class="btn btn-outline-primary" for="btnradio2" onclick="window.location.href='${pageContext.request.contextPath}/todolist/receive?p_no=${p_no}';">할일 리스트</label>

                    <input type="radio" class="btn-check" name="btnradio" id="btnradio3" >
                    <label class="btn btn-outline-primary" for="btnradio3" onclick="window.location.href='${pageContext.request.contextPath}/pcalendar/cal?p_no=${p_no}';" >캘린더</label>
                 </div>
<div class="home">
<div id="file_head">
	<div id="path">
		<c:if test="${!empty ffolder}">
		<a class="nowpath" data-url="${ffolder.folder_path}" data-num='${ffolder.folder_num}'>${ffolder.folder_name}</a>
		</c:if>
	</div>
	
	<div id="file_menu">
		<form action="fileUpload" method="post" enctype="multipart/form-data" id="uploadForm" name="uploadForm">
			<button type="button" id="newbtn">새 폴더</button>
			<label for="upfile">
				<div id="uploadbtn"><img src="../resources/image/filebox/uploadbtn.png">올리기</div>
       		</label>
       			<input type="file" id="upfile" name="uploadfile">
		</form>
	</div>
</div><!-- file_head -->
<!-- 이동 div -->
<div id="move">
	<h5>HOME</h5>
	<div id="move_content">
	<ul>
		<li><a><img src="../resources/image/filebox/movefoldericon.png">폴더1</a>
			<ul>
			<li class="move_select"><a><img src="../resources/image/filebox/movefoldericon.png">내부</a></li>
			<li><a><img src="../resources/image/filebox/movefoldericon.png">내부2</a></li>
			</ul>
		</li>
		<li><a><img src="../resources/image/filebox/movefoldericon.png">폴더2</a></li>	
		<li><a><img src="../resources/image/filebox/movefoldericon.png">폴더3</a></li>	
		<li><a><img src="../resources/image/filebox/movefoldericon.png">폴더4</a></li>	
	</ul>
	</div>
	
	<div id="move_button">
		<button type="button" id="movebtn1">이동하기</button>
		<button type="button" id="movebtn2">취소</button>
	</div>
</div>
<!-- 이동 div끝 -->

	<div id="file_content">
	</div>
	<form action="fileDown" method="post" id="down">
		<input type="hidden" name="file_name" id="down_name">
		<input type="hidden" name="file_save_path" id="down_path">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">	

	</form>
	
	<form action="folderDown" method="post" id="down2" style="height:0px">
		<input type="hidden" name="p_no" id="down_p_no">
		<input type="hidden" name="folder_name" id="down_folder_name">
		<input type="hidden" name="folder_path" id="down_folder_path">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
	</form>	
	</div>
</div><!-- home -->
</div> <!-- class content -->
<!-- 폴더생성 모달 -->
<div id="folder_modal" class="modal">
  <!-- Modal content -->
  <div class="modal-content">
  	<h4>새 폴더</h4>
  	<input type="text" id="input_fname" value="새 폴더">
  	<div id="modal_btndiv">
  	<button type="button" class="close">취소</button>
  	<button type="button" id="folder_insertbtn">생성</button>
  	</div>
  </div>

</div>
<!-- 모달 끝 -->
<footer>
<jsp:include page="../home/bottom.jsp" />
</footer>
</body>
</html>