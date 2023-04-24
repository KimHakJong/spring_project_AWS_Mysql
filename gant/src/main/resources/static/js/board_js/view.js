let option=1;  //선택한 등록순과 최신순을 수정, 삭제, 추가 후에도 유지되도록 하기위한 변수로 사용됩니다.

//토큰
let token = $("meta[name='_csrf']").attr("content");
let header = $("meta[name='_csrf_header']").attr("content");

// 댓글 리스트를 가져와 출력하는 함수
function getList(state){//현재 선택한 댓글 정렬방식을 저장합니다. 1=>등록순, 2=>최신순
	    console.log(state)
	    option=state;
		$.ajax({
			type:"post",
			url:"../comment/list",
			dataType:'json',	
			data : {"comment_board_num" : $("#comment_board_num").val(), state:state},
			beforeSend : function(xhr)
	        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	        	xhr.setRequestHeader(header, token);			
	        },
			success:function(rdata){
				$('#count').text(rdata.listcount).css('font-family','arial,sans-serif')
				let red1 ='red';
				let red2 ='red';
				if(state==1){ //등록순
					red2="gray"
				}else if(state==2){ // 최신순
					red1="gray"
				}
				
				let output ="";

			 if(rdata.boardlist.length>0){ //댓글이 1개 이상일때만 나타난다.
				 output += '<li class="comment-order-item ' + red1 +'">' 
				        + '   <a href="javascript:getList(1)" class="comment-order-button">등록순</a>'
                        + '</li>'
                        + '<li class="comment-order-item ' + red2 +'">'
                        + '   <a href="javascript:getList(2)" class="comment-order-button">최신순</a>'
                        + '</li>' 
                        
                   $('.comment-order-list').html(output);
                   output='';  
					$(rdata.boardlist).each(function(){
						//댓글이면 1 댓글의 댓글은 2
						const lev = this.comment_re_lev;
						let comment_reply='';
						if(lev==1){
							comment_reply = ' comment-list-item--reply lev1';
						}else if(lev==2){
							comment_reply = ' comment-list-item--reply lev2';
						}
						const profile=this.profileimg;
						let src ='../image/memberupload/people.png';
						if(profile){
							src ='../image/memberupload/'+profile;
						}
						
					output += '<li id="' + this.num + '" class="comment-list-item' + comment_reply +'">'
					       +  '  <div class="comment-nick-area">'
					       +  '     <img src="'+ src + '" alt="프로필 사진" width="36" height="36">'
					       +  '  <div class="comment-box">'
						   +  '    <div class="comment-nick-box">'
						   +  '       <div class="comment-nick-info">'
						   +  '           <div class="comment-nickname">' + this.id + '</div>'
						   +  '       </div>' // comment-nick-info
						   +  '    </div>' //comment-nick-box
						   +  '  </div>' //comment-box
						   +  '  <div class="comment-text-box">'
						   +  '     <p class="comment-text-view">'
						   +  '        <span class="text-comment">' + this.content + '</span>'
						   +  '     </p>'
						   +  '  </div>' //comment-text-box
						   +  '  <div class="comment-info-box">'
						   +  '    <span class="comment-info-date">' + this.reg_date + '</span>';
						   
						if(lev<2){
							output += ' <a href="javascript:replyform('+ this.num + ','
							        + lev+ ',' + this.comment_re_seq + ','
							        + this.comment_re_ref + ')" class="comment-info-button">답글쓰기</a>'				       
						}   
					 	output += '    </div>' //comment-info-box
					
					if($("#loginid").val()==this.id || $("#admin").val() == 'true'){
					output += ' <div class="comment-tool">'
					  	   + ' <div title="더보기" class="comment-tool-button">'
					  	   + '     <div>&#46;&#46;&#46;</div>'
					  	   + ' </div>'
					  	   + ' <div id="comment-list-item-layer' + this.num + '" class="LayerMore">' // 스타일에서 display:none;
					  	   + '    <ul class="layer-list">'
					  	   + '      <li class="layer-item">'
					  	   + '        <a href="javascript:updateForm('+this.num + ')"'
					  	   + '            class="layer-button">수정</a>&nbsp;&nbsp;'
					  	   + '        <a href="javascript:del('+this.num + ')"'
					  	   + '           class="layer-button">삭제</a>&nbsp;&nbsp;'
						   + '  </div>' //LayerMore
						   + ' </div>' //comment-tool
				
					}
					
					output += '</div>'//comment-nick-area
					        +'</li>' // li.ccomment-list-item						    
					})//each end
					
					
					
					$('.comment-list').html(output);
			 }//if(rdata.boardlist.length>0)
			 else{ //댓글 1개가 있는 상태에서 삭제하는 경우 갯수는 0이라 if문을 수행하지 않고 이곳으로 옵니다.
			      // 이곳에서 아래의 두 영역을 없앱니다.
				$('.comment-list').empty();
				$('.comment-order-list').empty();
			 }
			}//success end
		});//ajax end
	}//function(getList) end


	
//더보기-수정 클릭한 경우에 수정 폼을 보여주는 함수
function updateForm(num){ //num : 수정할 댓글 글번호
   
   //수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겨요
   $('.comment-tool').hide();
   
   $('.LayerMore').hide(); //수정 삭제 영역도 숨겨요
   
   let $num = $("#"+num);
    
    //선택한 내용을 구합니다.
    const content=$num.find('.text-comment').text();
    
    const selector = '#'+num+'> .comment-nick-area'
    $(selector).hide(); // selector 영역 숨겨요 - 수정에서 취소를 선택하면 보여줄 예정입니다.
    
    //$('.comment-list+.comment-write').clone(): 기본 글쓰기 영역 복사합니다.
    //글이 있던 영역에 글을 수정 할 수 있는 폼으로 바꿉니다.
    $num.append($('.comment-list+.comment-write').clone());
    
    //수정폼의 <textarea> 에 내용을 나타냅니다.
    $num.find('textarea').val(content);
	
	//'.btn-register' 영역에 수정할 글 번호를 속성 'date-id'에 나타내고클래스 'update' 를 추가합니다
	$num.find('.btn-register').attr('data-id',num).addClass('update').text('수정완료');
	 
	 //폼에서 취소를 사용할 수 있도록 보이게 합니다.
	$num.find('.btn-cancel').css('display','block');
	  
	const count = content.length;
	$num.find('.comment-write-area-count').text(count+"/200");
	 
}//function(updateForm) end

	
	
//더보기 -> 삭제 클릭한 경우 실행하는 함수
function del(num){//num : 댓글 번호
  	if(!confirm('정말 삭제하시겠습니까?')){
		  $('#comment-list-item-layer' + num).hide(); //'수정 삭제 영역 숨겨요
		  return;
	  }
	  
	  $.ajax({
			url:"../comment/delete", 
			data : {num:num},
			beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
			success:function(rdata){
				if(rdata >= 1){
				getList(option);
				}	
			}
	   })//ajax
}//function(del) end


//답글 달기 폼 함수
function replyform(num,lev,seq,ref){
	//수정 삭제 영역 선택 후 답글쓰기 클릭한 경우 
   $('.LayerMore').hide(); 
   
   let output ='<li class="comment-list-item comment-list-item--reply lev' + lev + '"></li>'
   const $num = $('#'+num);
   //선택한 글 뒤에 답글 폼을 추가합니다.
   $num.after(output);
   
   //글쓰기 영역 복사합니다.
   output = $('.comment-list+.comment-write').clone();
   
   const $num_next = $num.next();
   //선택한 글 뒤에 답글 폼 생성합니다.
   $num_next.html(output);
   
   //답글 폼의 <textarea> 속성 'placeholder'를 '답글을 남겨보세요' 로 바꾸어 줍니다.
   $num_next.find('textarea').attr('placeholder','답글을 입력하세요');
   
   //답글 폼의 'btn-cancel' 을 보여주고 클래스 'reply-cancel'를  추가합니다.
   	 $num_next.find('btn-cancel').css('display','block').addClass('reply-cancel');
   	 
   //답글 폼의 '.btn-register'에 클래스 'reply' 추가합니다.
   // 속성 'data-ref' 에 ref, 'data-lev'에 lev, 'data-seq'에 seq값을 설정합니다.
   // 등록을 답글 완료로 변경합니다.
   $num_next.find('.btn-register').addClass('reply')
                       .attr('data-ref',ref).attr('data-lev',lev).attr('data-seq',seq).text('답글 완료');
    	
}//function(replyform) end



//ready 
$(function() { 
	getList(option);  //처음 로드 될때는 등록순 정렬


	$('.comment-area').on('keyup','.comment-write-area-text', function() {
	    const length = $(this).val().length;
	    $(this).prev().text(length+'/200');
	});// keyup','.comment-write-area-text', function() {
	
	
	//댓글 등록을 클릭하면 데이터베이스에 저장 -> 저장 성공 후에 리스트 불러옵니다.
	$('ul+.comment-write .btn-register').click(function() {
		const content=$('.comment-write-area-text').val();
		if(!content){ // 내용없이 등록 클릭한 경우
             alert('댓글을 입력하세요');
             return;			
		}
		
		$.ajax({
			url:"../comment/add", //원문 등록
			data : {
				content : content,
				comment_board_num : $("#comment_board_num").val(),
				comment_re_lev : 0, 			                                    
				comment_re_seq : 0// 원문댓글 경우 comment_re_seq는 0,
				// comment_re_ref는 원문댓글인경우 원문댓글번호 
				},
			type:"post",
			beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
			success:function(rdata){
				if(rdata == 1){
				getList(option);
				}	
			}
	   })//ajax
			$('.comment-write-area-text').val(''); // textarea 초기화
			$('.comment-write-area-count').text('0/200'); // 입력한 글 카운트 초기화
	})// $('.btn-register').click(function(){
	
	
	
	//더보기 클릭 이벤트
	$(".comment-list").on('click', '.comment-tool-button', function() {        		
	//더보기를 클릭하면 수정과 삭제 영역이 나타나고 다시 클릭하면 사라진다.
	$(this).next().toggle();
	
	//클릭 한 곳만 수정 삭제 영역이 나타나도록 합니다. 내가선택한것을 제외하면 안보이게 하기
	$(".comment-tool-button").not(this).next().hide();
	})
	
	

	//수정 후 수정완료를 클릭한 경우
	$('.comment-area').on('click','.update',function(){
		const content = $(this).parent().parent().find('textarea').val();
		if(!content){ // 내용없이 등록 클릭한 경우
			alert('수정할 댓글을 입력하세요.')
			return;
		}
		const num = $(this).attr('data-id');
		$.ajax({
			url:"../comment/update", 
			data : {num:num, content:content},
			beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
			success:function(rdata){
				if(rdata == 1){
				getList(option);
				}//if	
			} //success
	   });//ajax	
	})//수정 후 수정완료를 클릭한 경우
	
	
	//수정 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.btn-cancel',function(){
		//댓글 번호를 구합니다.
		const num = $(this).next().attr('data-id');
		const selector ='#'+num;
		
		//.comment-write 영역을 삭제합니다.
		$(selector+' .comment-write').remove();
		
		//숨겨두었던 .comment-nick-area 영역 보여줍니다.
		$(selector+'>.comment-nick-area').css('display','block');
		
		//수정 폼이 있는 상태에서 더보기를 클릭할 수 없도록 더 보기 영역을 숨겼는데 취소를 선택하면 보여주도록 합니다.
		$(".comment-tool").show();
		
	})//수정 후 취소 버튼을 클릭한 경우
	
	
	
	//답글완료 클릭한 경우
	$('.comment-area').on('click','.reply',function(){
		
		const content = $(this).parent().parent().find('.comment-write-area-text').val();
		if(!content){ // 내용없이 답글완료 클릭한 경우
			alert('답글을 입력하세요');
			return;
		}
		
		const comment_re_ref = $(this).attr('data-ref');
		const lev = $(this).attr('data-lev');
		const seq = $(this).attr('data-seq');
		$.ajax({
			url:"../comment/reply", 
			dataType:'json',	
			data : {
				content:content,
				comment_board_num : $("#comment_board_num").val(),
			    comment_re_lev : lev,
				comment_re_ref : comment_re_ref,
				comment_re_seq : seq
				},
				type : 'POST',
				beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
			success:function(rdata){
				if(rdata == 1){
				getList(option);
				}//if	
			} //success
	   });//ajax	
		
	})//답글완료 클릭한 경우
	
	
	//답글쓰기 후 취소 버튼을 클릭한 경우
	$('.comment-area').on('click','.reply-cancel',function(){
		$(this).parent().parent().parent().remove();
		$(".comment-tool").show(); // 더보기 영역 보이도록 합니다.
	})//답글쓰기  후 취소 버튼을 클릭한 경우
	
	//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
	$('.comment-area').on('click','.comment-info-button',function(event){
	//답글쓰기 폼이 있는 상태에서 더보기를 클릭할수 없도록 더 보기 영역을 숨겨요
	$(".comment-tool").hide();
	
	//답글쓰기 폼의 갯수를 구합니다.
	const length = $(".comment-area .btn-register.reply").length;
	if(length==1){ // 답글쓰기 폼이 한 개가 존재하면 anchor 태그 (<a>)의 기본 이벤트를 막아 또 다른 답글쓰기 폼이 나타나지 않도록 합니다.
	 event.preventDefault();
	}
	
	})//답글쓰기 클릭 후 계속 누르는 것을 방지하기 위한 작업
	
	
	//  -----------------------------------------댓글 끝
	
	    //like_check 값 like버튼 값으로 넣어준다.
		$("#like").val($('#like_check').val());
		
		if($("#like").val() == 'false'){ // 좋아요 체크가 false이면 좋아요버튼 검정색
			$("#like").removeClass("class_name");
			$(".heartAnim").removeClass('spreadHeart');
		}else if ($("#like").val() == 'true'){ // 좋아요 체크가 false이면 좋아요버튼 하얀색
			$("#like").addClass('heart');
			$(".heartAnim").addClass('spreadHeart');
		}

		//좋아요 클릭시 이벤트
		$("#like").click(function(){
			
			//like_check == false인 상태에서(좋아요 체크하지 않은 상태에서) 좋아요 체크를 했을때
			if($("#like").val() == 'false'){ 
				
			const data = {like_check : "true" , board_num : $('#comment_board_num').val()}; //json 형식으로 
			$.ajax({
				   data : data,
				   url :  "likecheck", 
				   beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
				   success : function(data){	
					   $("#like").val('true'); // 좋아요 체크 true으로 변경
					   $("#like").addClass('heart');
					   $(".heartAnim").addClass('spreadHeart');
					   
				   }, //success end
				   error: function( request, status, error ){
					    alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);

					   }
				     
			   }) // ajax end
			
			}else if($("#like").val() == 'true'){//like_check == true인 상태에서(좋아요 체크한상태에서) 좋아요 체크를 해제했을때
				
				const data = {like_check : "false" , board_num : $('#comment_board_num').val()}; //json 형식으로 
				$.ajax({
					   data : data,
					   url :  "likecheck",
					   beforeSend : function(xhr)
				        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
				        	xhr.setRequestHeader(header, token);			
				        },
					   success : function(data){	
						   $("#like").val('false'); // 좋아요 체크 true으로 변경
						   $("#like").removeClass('heart');
						   $(".heartAnim").removeClass('spreadHeart');
						   
					   }, //success end
					   error: function( request, status, error ){
						    alert("status : " + request.status + ", message : " + request.responseText + ", error : " + error);

						   }					     
				   }) // ajax end				
			} //if end			
		});
	
	
	 // 가져온 데이터로 글 css 적용
	$('#content').css('font-weight', $('#fontWeight').val() ).css('font-size', $('#fontSize').val()).css('color',$('#fontColor').val() );
	
	 
	 //삭제버튼 클릭시 이벤트 
	$("#bodelete").click(function(){
		var result = confirm("정말 삭제하시겠습니까?");
		if(result){
			location.href="delete?board_num="+$('#comment_board_num').val(); 
		}
		 });
	
	
	
	
})//ready