   $(function() {
	   let token = $("meta[name='_csrf']").attr("content");
	   let header = $("meta[name='_csrf_header']").attr("content");
		
	   $(".head_button1").click(function(){
	   	location.href="mylist";
	   });
	   const now = new Date();
	   const nowyear = now.getFullYear();
	   const nowmonth = ("0" + (now.getMonth()+1).toString()).slice(-2);
	   const nowdate = ("0" + now.getDate().toString()).slice(-2);
	   const nowday = now.getDay();
	   var weekday = new Array(7);
	   weekday[0] = "일";
	   weekday[1] = "월";
	   weekday[2] = "화";
	   weekday[3] = "수";
	   weekday[4] = "목";
	   weekday[5] = "금";
	   weekday[6] = "토";
	   
	   //오늘날짜 표시
	   $('.show_date span').text(nowyear+". " + nowmonth + ". " + nowdate +" (" + weekday[nowday] + ")");
	   $("#show_date_input").text(nowyear+"-"+nowmonth+"-"+nowdate);
	   //초기값 오늘
	   $('.datepicker').datepicker('setDate', 'today');
	   
	   $(".show_date").click(function(){
		   $(".ui-datepicker-inline").toggle();
	   $('.datepicker').datepicker({
		   	dateFormat: 'yy. mm. dd (D)',
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        showOtherMonths: true,
	        yearSuffix: '년',
	        minDate: "0D",
	        maxDate: "+1M",
	        todayHighlight :true,
		    onSelect: function(dateString) {
		        $(".ui-datepicker-inline").toggle();
	   			$(".show_date span").text(dateString);
	   			$("#show_date_input").text(dateString.substring(0,4)+"-"+dateString.substring(6,8)+"-"+dateString.substring(10,12));
	   			loadTime();
		    }
		});
	   });
	   
	   $('#insert_day, #update_day').datepicker({
		   	dateFormat: 'yy-mm-dd',
		   	showOn:"button",
            buttonImage:"../resources/image/reserve/calendar6.png",
            buttonImageOnly:true,
	        prevText: '이전 달',
	        nextText: '다음 달',
	        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	        showMonthAfterYear: true,
	        showOtherMonths: true,
	        yearSuffix: '년',
	        minDate: "0D",
	        maxDate: "+1M",
	        todayHighlight :true,
		    onSelect: function(dateString) {
		    	if($(this).attr('id')=='insert_day'){
		       		 $("#insert_day").trigger('change');
		       		 console.log("클릭되었따");
		    	}else if($(this).attr('id')=='update_day'){
		       		 $("#update_day").trigger('change');
		    	}
		    }
		});
		
	   //자원종류선택 변경 시 선택된 종류의 자원표시
	   $("#type_select").change(function(){
			let type = $("#type_select option:selected").text();
			$.ajax({
				url : "loadResource_ajax",
				type : "post",
				data : {"type" : type},
				dataType : "json",
				async: false,
				beforeSend : function(xhr)
	  			 {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		 },
	    		success : function(rdata){

	    			//종류마다 테이블 행(자원개수)이 다르므로 초기화 후 해당 자원이름 넣는 작업
	    			$(".reserve_table").empty();
	    			 $(rdata).each(function(){
	    				let output = '';
	    				output += "<tr><td>" + this + "</td>"
	    					    + "<td></td><td></td><td></td><td></td><td></td>"
	    				        + "<td></td><td></td><td></td><td></td><td></td>"
	    				        + "<td></td><td></td><td></td><td></td><td></td>"
	    				        + "<td></td><td></td><td></td><td></td><td></td></tr>";
	    				$(".reserve_table").append(output);
	    			 });
	    		 }//success
			});//ajax
			
			loadTime();
	   });
	   
	   //해당 자원명에 대한 예약시간조회
	   loadTime();
	   //테이블 예약가능시간 조회
	   function loadTime(){
		   let day = $("#show_date_input").text();
		   
		   $(".reserve_table tr").each(function(){
			  let resource_name = $(this).children().eq(0).text();
				  $(this).find('.reserved').text('');
			  $(this).find('td').removeClass('reserved');	
			  loadTime_ajax(resource_name, day, $(this));
		   });
			 //예약된 막대 테두리 둥글게
	 		 $(".reserved").each(function(){
	 		 	if($(this).find('.reserved_num').val()!=$(this).next().find('.reserved_num').val() && $(this).find('.reserved_num').val()!=$(this).prev().find('.reserved_num').val()){
	 		 		$(this).css('border-radius','30px');
	 		 		$(this).css('padding','13px 4px');
	 		 		$(this).prepend($(this).find('.reserved_name').val());
	 		 	}else if($(this).find('.reserved_num').val()!=$(this).next().find('.reserved_num').val()){
	 		 		$(this).css('border-radius','0px 30px 30px 0px');
	 		 		$(this).css('padding','13px 4px 13px 0px');
	 		 	}else if($(this).find('.reserved_num').val()!=$(this).prev().find('.reserved_num').val()){
	 		 		$(this).css('border-radius','30px 0px 0px 30px');
	 		 		$(this).css('padding','13px 0px 13px 4px');
	 		 		$(this).prepend($(this).find('.reserved_name').val());
	 		 	}else{
	 		 		$(this).css('border-radius','0px');
	 		 		$(this).css('padding','13px 0px');
	 		 	}
	 		 });			   
	 		 
		   function loadTime_ajax(resource_name, day, selector){
			  	  $.ajax({
			   	  	 url: "loadTime_ajax",
			   	  	 type : "post",
			   	  	 data : {"resource_name" : resource_name, "day" : day},
			   	  	 dataType : "json",
			   	  	 async: false,
			   		 beforeSend : function(xhr)
		  			 {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
		    			xhr.setRequestHeader(header, token);			
		    		 },
		    		 success : function(rdata){
		    			if(rdata!=null){
			    			$(rdata).each(function(){// 예약된 시간에 reserved 클래스추가 , 번호값 예약자추가
		    					selector.children().eq(this.reserved_time-15).addClass('reserved');
		    					//if(selector.children().eq(this.reserved_time-15).prev().find('.reserved_num').val()==this.num){
		    						
		    					//}else{
			    					//selector.children().eq(this.reserved_time-15).prepend(this.name);
		    					//}
		    					selector.children().eq(this.reserved_time-15).append("<input type='hidden' class='reserved_num' value='"+this.num+"'>");
		    					selector.children().eq(this.reserved_time-15).append("<input type='hidden' class='reserved_name' value='"+this.name+"'>");
			    			});
		    			}
		    		 }
			  	  });
			 }//loadTime_ajax function
			 
	   }//loadTime funciton

//예약확인모달 시작	   
	    //테이블에 예약된 것 클릭 시 예약확인모달 띄우고 해당 예약번호에 대한 데이터 가져옴
		$("body").on('click','.reserved',function(){
			$("#detail_reservation").modal('show');
			$("#detail_num").val($(this).find(".reserved_num").val());
			let num = $("#detail_num").val();
			console.log("클릭:"+num);
			
			$.ajax({
				url : "loadDetail_ajax",
				type : "post",
				data : { "num" : num, "id" : $(".side_userid").text() },
				dataType : "json",
				beforeSend : function(xhr)
	  			 {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		 },
	    		success : function(rdata){
	    		console.log(rdata.admin);
	    			if(rdata.obj.id==$(".side_userid").text() || rdata.admin=='true'){ //관리자이거나 예약자인 경우
						$('#detail_to_update').css('display','block');
						$('#detail_to_delete').css('display','block');
					}else{	
						$('#detail_to_update').css('display','none');
						$('#detail_to_delete').css('display','none');
					}
					
					$(".detail_table tr").eq(0).find('td').text(rdata.obj.name);
	    			$(".detail_table tr").eq(1).find('td').text(rdata.obj.resource_name);
	    			$(".detail_table tr:nth-child(3) td").eq(0).text(rdata.obj.day);
	    			let start = '';
	    			let end = '';
	    			if(rdata.obj.start_time.substring(0,2)>=12){
	    				start = "오후 " + rdata.obj.start_time;
	    			}else{
	    				start = "오전 " + rdata.obj.start_time;
	    			}
	    			
	    			if(rdata.obj.end_time.substring(0,12)>=12){
	    				end = "오후 " + rdata.obj.end_time;
	    			}else{
	    				end = "오전 " + rdata.obj.end_time;
	    			}
	    			$(".detail_table tr:nth-child(3) td").eq(1).text(start + " ~ " + end);
	    			$(".detail_table tr").eq(3).find('td').text(rdata.obj.names);
	    			$(".detail_table tr").eq(4).find('td').text(rdata.obj.purpose);	    			
	    		 }//success
			});//ajax

		});
		
//예약확인모달 끝
//예약수정모달 시작
		$("#detail_to_update").click(function(){//수정: 예약번호보냄
			goupdate = true;
			goinsert = false;
			$("#detail_reservation").modal("hide");
			let num = $(this).parent().find('#detail_num').val();
			$.ajax({
				url : "loadDetail_ajax",
				type : "post",
				data : { "num" : num },
				dataType : "json",
				async: false,
				beforeSend : function(xhr)
		  		{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
		    			xhr.setRequestHeader(header, token);			
		    	},
		    	success : function(rdata) {
		    		$("#update_num").val(rdata.obj.num);
		    		$("#update_name").val(rdata.obj.name);
		    		$("#update_id").val(rdata.obj.id);
		    		$("#update_type").find('option').text(rdata.obj.type);
		    		$("#update_type").find('option').val(rdata.obj.type);
		    		$("#update_resource_name").find('option').text(rdata.obj.resource_name);
		    		$("#update_resource_name").find('option').val(rdata.obj.resource_name);
		    		
		    		$("#update_purpose").val(rdata.obj.purpose);
		    		$("#update_names").val(rdata.obj.names);
		    		//이름이 div로 표시되도록
		    		let update_name = $("#update_names").val().split(",");
					$("#update_namediv").empty();
					let output ="";
			
					if($("#update_names").val()){ //값이 존재할 때
						for(var i=0; i<update_name.length; i++){
							if(i==7){
								output += '<div class="update_name etc_name">'+ "·&nbsp;·&nbsp;·"+'</div>';	
								output += '<div class="update_name etc_show">'+ update_name[i] +'</div>';	
							}else if(i>7){
								output += '<div class="update_name etc_show">'+update_name[i]+'</div>';
							}else{
								output += '<div class="update_name">'+update_name[i]+'</div>';
							}
						}
						$("#update_namediv").append(output);
						setTimeout(function(){
							$(".wrap_namediv").css('height',$("#update_namediv").css('height'));
						}, 100);
					}//if
					
		    		$("#update_day").val(rdata.obj.day);
	  				//예약날짜 최소:오늘 , 최대:한달 (예약수정에서)
	 				var after_day = new Date(now.setMonth(now.getMonth()+1));
	  				$("#update_day").attr('min',nowyear+"-"+nowmonth+"-"+nowdate);
	  				$("#update_day").attr('max',after_day.getFullYear() + "-"
	   												+ ("0" + (after_day.getMonth()+1).toString()).slice(-2) 
	   												+ "-"+ ("0" + after_day.getDate().toString()).slice(-2));
	   				
	   				//입력된 날짜
	   				let dayval = $("#update_day").val().substring(0,4)+$("#update_day").val().substring(5,7)+$("#update_day").val().substring(8,10);
	   				let compare_now = nowyear+nowmonth+nowdate; //현재날짜
	   		
	   				let resource_name = $("#update_resource_name option:selected").val();
	   				let day = $("#update_day").val();
	   		
	   				if(compare_now > dayval || day==""){
	    				$(".update_time").css('display','none');
	   				}else{
	   					$("#start_time2").val( (rdata.obj.start_time.substring(0,2)*2) + ( rdata.obj.start_time.substring(3,5)/30) );
		    			$("#end_time2").val( (rdata.obj.end_time.substring(0,2)*2) + ( (rdata.obj.end_time.substring(3,5)/30)-1) );
		    			updatemodalon=false;
	   					modal_loadTime(resource_name,day,dayval,compare_now);
		    			$(".update_time").css('display','inline-block');
		    		}
		    		$("#before_time").val(parseInt($("#end_time2").val())-parseInt($("#start_time2").val())+1);
		    		//전에 예약했던 시간 보냄
				}//success
			});//ajax
			
		    updatemodalon=true;
		    $("#reserve_update").modal("show");
	   	});//detail_to_update 	
	   	
	   	$("#update_day").change(function(){
		   	//입력된 날짜
	   		let dayval = $("#update_day").val().substring(0,4)+$("#update_day").val().substring(5,7)+$("#update_day").val().substring(8,10);
	   		let compare_now = nowyear+nowmonth+nowdate; //현재날짜
	   		
	   		let resource_name = $("#update_resource_name option:selected").val();
	   		let day = $("#update_day").val();
	   		
	   		if(compare_now > dayval || day==""){
	    		$(".update_time").css('display','none');
	   		}else{
	   			modal_loadTime(resource_name,day,dayval,compare_now);
		    	$(".update_time").css('display','inline-block');	  
		    } 	
	   	});
	   	//X누르면 닫힘
		$("#update_close").click(function(){
			$("#reserve_update").modal('hide');
		});
		
	   //예약수정완료 했을 때
	   $("#updateForm").submit(function(){
	   	   let max = -1;
	   	   let min = -1;
	   	   let cnt = 0; //한번에 최대 3시간 이용가능
		   $(".check").next().each(function(index,item){
		   		cnt++;
		   		if(index==0){
		   			max=$(this).val();
		   			min=$(this).val();	
		   		}else{
		   			if($(this).val()>max){
		   				max = $(this).val();
		   			}
		   			if($(this).val()<min){
		   				min = $(this).val();
		   			}
		   		}
		   });
		   console.log("max:"+max+",min:"+min);
		   $("#start_time2").val(min);
		   $("#end_time2").val(max);
		   if($("#update_name").val().trim()=="" || $("#insert_id").val().trim()==""){
			   alert("다시 로그인해주세요");
			   location.href="../member/login";
		   }else if($("#update_purpose").val().trim()==""){
			   alert("예약목적을 입력하세요");
			   $("#update_purpose").focus();
			   return false;
		   }else if($("#update_names").val().trim()==""){
			   alert("참여명단을 선택하세요");
			   return false;
		   }else if(min==-1 || max==-1){
		   	   alert("예약 시간을 선택하세요");
		   	   return false;
		   }else if(cnt>6){
		   	   alert("한번에 최대 3시간 예약가능합니다.");
		   	   return false;
		   }else if($("#update_names").val().split(",").length>$(".max_person").val()){ //자원의 최대 인원 수 초과시
		   	   alert("해당 자원의 최대 인원은 "+ $(".max_person").val()+"명 입니다.");
		   	   return false;
		   }
	   });		
//예약수정모달 종료
		
		$("#detail_to_delete").click(function(){//삭제: 예약번호보냄
			if(confirm("정말로 예약을 취소하시겠습니까?")){
				location.href="deleteReservation?num="+$("#detail_num").val();
					
			}
		});
		
		$("#detail_close").click(function(){
			$("#detail_reservation").modal("hide");
		});
//예약확인모달 종료

//예약추가모달 시작
		$(".head_button2").click(function(){
			goinsert = true;
			goupdate = false;
		});
	   //예약자명,예약자아이디를 예약추가모달에 넣음
	   $("#insert_name").val($(".side_userid").next().text());
	   $("#insert_id").val($(".side_userid").text());
	   
	   //예약추가 후 등록했을 때
	   $("#insertForm").submit(function(){
	   	   let max = -1;
	   	   let min = -1;
	   	   let cnt = 0; //한번에 최대 3시간 이용가능
		   $(".check").next().each(function(index,item){
		   		cnt++;
		   		if(index==0){
		   			max=$(this).val();
		   			min=$(this).val();	
		   		}else{
		   			if($(this).val()>max){
		   				max = $(this).val();
		   			}
		   			if($(this).val()<min){
		   				min = $(this).val();
		   			}
		   		}
		   });
		   console.log("max:"+max+",min:"+min);
		   $("#start_time").val(min);
		   $("#end_time").val(max);
		   if($("#insert_name").val().trim()=="" || $("#insert_id").val().trim()==""){
			   alert("다시 로그인해주세요");
			   location.href="../member/login";
		   }else if($("#insert_purpose").val().trim()==""){
			   alert("예약목적을 입력하세요");
			   $("#insert_purpose").focus();
			   return false;
		   }else if($("#insert_names").val().trim()==""){
			   alert("참여명단을 선택하세요");
			   return false;
		   }else if($("#insert_type option:selected").val()==""){
			   alert("자원 종류를 선택하세요");
			   $("#insert_type").focus();
			   return false;
		   }else if($("#insert_resource_name option:selected").val()==""){
			   alert("자원 이름을 선택하세요");
			   $("#insert_resource_name").focus();
			   return false;
		   }else if(min==-1 || max==-1){
		   	   alert("예약 시간을 선택하세요");
		   	   return false;
		   }else if(cnt>6){
		   	   alert("한번에 최대 3시간 예약가능합니다.");
		   	   return false;
		   }else if($("#insert_names").val().split(",").length>$(".max_person").val()){ //자원의 최대 인원 수 초과시
		   	   alert("해당 자원의 최대 인원은 "+ $(".max_person").val()+"명 입니다.");
		   	   return false;
		   }
	   });
	   
	   
		//인원 더보기 클릭 시 더보고, div크기 늘린다.
		$('body').on('click','.etc_name',function(){
			$(this).css('display','none');
			$(".etc_show").css('display','inline-block');
			setTimeout(function(){
				if(goinsert==true){
					$(".wrap_namediv").css('height',$("#insert_namediv").css('height'));
				}else if(goupdate==true){
					$(".wrap_namediv").css('height',$("#update_namediv").css('height'));
				}
				}, 100);
		});
	   
	   
	   //예약추가 모달 자원 종류에 따른 자원명 셀렉트 박스 불러옴 
	   $("#insert_type").change(function(){
	   	   $(".insert_time").css('display','none');
		   let type = $("#insert_type option:selected").text();
		   $.ajax({
				url : "loadResource_ajax",
				type : "post",
				data : {"type" : type},
				dataType : "json",
				async: false,
				beforeSend : function(xhr)
	  			 {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		 },
	    		success : function(rdata){
	    			
	    			$("#insert_resource_name").empty();
	    			//종류에 따른 자원명을 option에 넣음
	    			$("#insert_resource_name").append('<option value="" disabled selected>이름 선택</option>');
	    			$(rdata).each(function(){
	    				let output = "<option value='"+ this +"'>" + this + "</option>";
	    				$("#insert_resource_name").append(output);
	    			});
	    		 }//success
			});//ajax
	   });
	   
	   //자원과 날짜가 입력되어야 시간표시 div가 나오도록
	   $("#insert_resource_name").change(function(){
	   		//입력한 날짜
	   		let dayval = $("#insert_day").val().substring(0,4)+$("#insert_day").val().substring(5,7)+$("#insert_day").val().substring(8,10);
	   		let compare_now = nowyear+nowmonth+nowdate; //현재날짜
	   		
	   		let resource_name = $("#insert_resource_name option:selected").val();
	   		let day = $("#insert_day").val();
	   		if($("#insert_type option:selected").val()=="" && resource_name=="" || compare_now > dayval || day==""){
	    		$(".insert_time").css('display','none');
	   		}else{
	   			modal_loadTime(resource_name,day,dayval,compare_now);
		    	$(".insert_time").css('display','inline-block');
		    	
	   		}
	   });
	   
	   $("#insert_day").change(function(){
	   		//입력한 날짜
	   		let dayval = $("#insert_day").val().substring(0,4)+$("#insert_day").val().substring(5,7)+$("#insert_day").val().substring(8,10);
	   		let compare_now = nowyear+nowmonth+nowdate; //현재날짜
	   		
	   		let resource_name = $("#insert_resource_name option:selected").val();
	   		let day = $("#insert_day").val();
	   		
	   		if($("#insert_type option:selected").val()=="" && resource_name=="" || compare_now > dayval || day==""){
	    		$(".insert_time").css('display','none');
	   		}else{
	   			modal_loadTime(resource_name,day,dayval,compare_now);
		    	$(".insert_time").css('display','inline-block');
		    	
	   		}			
	   });
	   
	   //예약날짜 최소:오늘 , 최대:한달 (예약추가에서)
	   $("#insert_day").attr('min',nowyear+"-"+nowmonth+"-"+nowdate);
	   var after_day = new Date(now.setMonth(now.getMonth()+1));
	   $("#insert_day").attr('max',after_day.getFullYear() + "-"
	   								+ ("0" + (after_day.getMonth()+1).toString()).slice(-2) 
	   								+ "-"+ ("0" + after_day.getDate().toString()).slice(-2));
	  	
	   //선택한 자원 시간에 따른 예약가능 시간표시
	   function modal_loadTime(resource_name,day,dayval,compare_now){
	   		if(goinsert==true){
	   			$("#insert_timediv").css('border','none');
	   			$("#insert_timediv").css('border-radius','0px');
	   	   	 	//기존 체크되어있거나 disabled를 초기화
	    		$(".insert_time").each(function(){
	    			if($(this).attr('class').includes('check')){
	    				$(this).trigger("click");//트리거해야 클릭이벤트발생하여 체크이미지없앰
	    			}else if($(this).attr('class').includes('disabled')){
	    				$(this).removeClass('disabled');
	    				$(this).addClass('can');
	    			}
	    		});	   		
	   		}else if(goupdate==true){
	   			$("#update_timediv").css('border','none');
	   			$("#update_timediv").css('border-radius','0px');
	   	    	//기존 체크되어있거나 disabled를 초기화
	    		$(".update_time").each(function(){
	    			if($(this).attr('class').includes('check')){
	    				$(this).trigger("click");//트리거해야 클릭이벤트발생하여 체크이미지없앰
	    			}else if($(this).attr('class').includes('disabled')){
	    				$(this).removeClass('disabled');
	    				$(this).addClass('can');
	    			}
	    		});	   		
	   		}

	    			
	   		$.ajax({
	   			url: "modal_loadTime_ajax",
	   			type: "post",
	   			data : {"resource_name" : resource_name, "day" : day},
	   			dataType : "json",
	   			async: false,
	   			beforeSend : function(xhr)
	  			 {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		 },
	    		success : function(rdata){
	    			
					//예약된 시간 비활성화
	    			$(rdata).each(function(){
	    				//선택한 자원의 최대 참여명단 수를 제한
		    			$(".max_person").val(this.max_person);
		    			
	    				if(goinsert==true){
		    				$("#insert_timediv input[value='"+this.reserved_time + "']").prev().attr('class', 'insert_time disabled');
	    				}else if(goupdate==true){

	    					if(this.reserved_time >= $("#start_time2").val() && this.reserved_time <= $("#end_time2").val()){
	    						if($("#update_timediv input[value='"+this.reserved_time + "']").prev().attr('class')!='update_time disabled'){
			    					$("#update_timediv input[value='"+this.reserved_time + "']").prev().attr('class','update_time can');
			    					$("#update_timediv input[value='"+this.reserved_time + "']").prev().trigger("click");
			    				}
	    					}else{
			    				$("#update_timediv input[value='"+this.reserved_time + "']").prev().attr('class', 'update_time disabled');
	    					}	
	    				}
	    			});
	    		 }//success
	   		 });//ajax
	   		 
	   		var time = new Date();
			var hours = ('0' + time.getHours()).slice(-2); 
			var minutes = ('0' + time.getMinutes()).slice(-2);
			let now_time = hours+minutes;
	   		 //지난 시간 비활성화 ( 오늘날짜만 )
	   		 if(goinsert==true){
	   		 	if(compare_now==dayval){
	   				 $(".insert_time").each(function(){
	   		 			if($(this).text().replace(":","") < now_time){
	   		 			$(this).attr('class','insert_time disabled');
	   		 			}
	   		 		});	   		
	   		 	} 
	   		 }else if(goupdate==true){
	   		 	if(compare_now==dayval){
	   		 	
	   				 $(".update_time").each(function(){
	   		 			if($(this).text().replace(":","") < now_time){
		   		 		$(this).attr('class','update_time disabled');
	   		 			}
	   		 		});
	   		 	}
	   		 }
	     }// modal_loadTime		
	     
		//예약가능 시간 클릭 시 체크이미지로 바뀜
		$('body').on('click',".can",function(){
			//연속으로 시간예약해야된다. 띄엄띄엄X
			if($('.check').text()){//체크된 것이 있는 경우
				console.log($(this).next().next().attr('class'));
				console.log($(this).prev().prev().attr('class'));
				if(goinsert==true){
					if($(this).next().next().attr('class')=='insert_time check' || $(this).prev().prev().attr('class')=='insert_time check'){
						$(this).removeClass('can');
						$(this).addClass('check');
						$(this).append('<img src="../resources/image/reserve/check.png">');
					}else{ //새로 체크한 것의 좌우 옆옆이 체크한 것이 없으면 경고창!
							alert("연속된 예약시간으로 체크해주세요");
				}				
				}else if(goupdate==true){
					if($(this).next().next().attr('class')=='update_time check' || $(this).prev().prev().attr('class')=='update_time check'){
						$(this).removeClass('can');
						$(this).addClass('check');
						$(this).append('<img src="../resources/image/reserve/check.png">');
					}else{ //새로 체크한 것의 좌우 옆옆이 체크한 것이 없으면 경고창!
						if(updatemodalon==true){
							alert("연속된 예약시간으로 체크해주세요");
						}
					}
				}
			}else{
				$(this).removeClass('can');
				$(this).addClass('check');
				$(this).append('<img src="../resources/image/reserve/check.png">');				
			}
		});
		
		//체크한 시간 다시 클릭 시 체크이미지 삭제
		$('body').on('click',".check",function(){
			let time = $(this).text().substring(0,5);
			if($(".check").text()){
				//체크된 것중 중간에 껴있는 것을 체크해제 했을 땐 경고창
				if($(this).next().next().attr('class')=='insert_time check' && $(this).prev().prev().attr('class')=='insert_time check'){
					alert("끝에서부터 체크를 해제해주세요");
				}else{
					$(this).removeClass('check');
					$(this).addClass("can");
					$(this).text(time);
				}
			}else{
				$(this).removeClass('check');
				$(this).addClass("can");
				$(this).text(time);
			}
		});
		
		//모달닫으면 명단들 사라짐
		$("#insert_close").click(function(){
			$("#insert_namediv").empty();
		});

/// 예약추가모달 관련 끝
		
		
///명단검색모달 시작
		$("body").on('change','input[type="checkbox"]',function(){
			let change_name = $(this).parent().next().text(); //체크된 이름
			if($(this).is(":checked")){//새로 체크되었을 때
				if(!check_name.includes(change_name+",")){ //기존 체크 이름목록에 방금 체크한 유저가 없는 경우 추가
					if(check_name.substr(-1)==',' || check_name.length==0){ //맨마지막이 ,인 경우
						check_name += change_name + ",";
					}else{
						check_name += "," + change_name + ",";
					}
				}
			}else {//체크해제된 경우
				if(check_name.includes(change_name+",")){//기존 체크이름목록에 방금 체크해제된 유저가 포함된 경우 제거
						check_name = check_name.replace(change_name+",","");
				}
			}
			
			console.log("현재체크된 이름="+check_name);
		});
		
		
		$("#msearch_input").keyup(function(){
			name = $(this).val();
			
			$.ajax({
				url : "../pmain/searchMemberList_ajax ",
				type : "post",
				data : { "name" : name},
				dataType : "json",
				async: false,
				beforeSend : function(xhr)
	  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},
	    		success : function(rdata){
					
					let output ='';
					if(rdata!=null){
						output += "<table class='table msearch_table_body'>";
						$(rdata).each(function(){
							if(check_name.includes(this.name+",")){ //check_name에 값이 있다면 자동으로 체크되도록!
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
			if(goinsert==true){
				if($("#insert_names").val()==""){
					check_name = $("#insert_names").val();
				}else{
					check_name = $("#insert_names").val()+",";
				}			
			}else if(goupdate==true){
				if($("#update_names").val()==""){
					check_name = $("#update_names").val();
				}else{
					check_name = $("#update_names").val()+",";
				}				
			}

			$("#msearch_table_div").empty();
			
			$.ajax({
				url : "../pmain/memberlist_ajax",
				type: "post",
				dataType: "json",
				beforeSend : function(xhr)
	  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
	    			xhr.setRequestHeader(header, token);			
	    		},
				success : function(rdata){
					
					let output ='';
					if(rdata!=null){
						output += "<table class='table msearch_table_body'>";
						$(rdata).each(function(){
							if(check_name.includes(this.name+",")){ //명단에 있으면 다시 명단 검색갔을 때 체크되어있다.
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
			
			if(goinsert==true){
				$("#insert_names").val("");//명단 이름
				$("#insert_namediv").empty();
				setTimeout(function(){
					$("#insert_namediv").css('height','50px');
					$(".wrap_namediv").css('height','50px');
					}, 100);
			}else if(goupdate==true){
				$("#update_names").val("");//명단 이름
				$("#update_namediv").empty();
				setTimeout(function(){
					$("#update_namediv").css('height','50px');
					$(".wrap_namediv").css('height','50px');
					}, 100);
			}
		});
		
		//명단검색에서 체크 후 확인 : 모달 명단에 자동입력
		$("#msearch_ok").click(function(){
			$("#msearch_input").val(""); //검색창

			//맨 마지막 쉼표 제거하기 위함
			if(check_name.substr(-1)==','){
				check_name = check_name.substring(0,check_name.length-1);
			}
			console.log("명단확인버튼(이름):"+check_name);
			
			if(goinsert==true){
				//자동으로 개별 이름 div가 생성되도록
				$("#insert_names").val(check_name);
				let insert_name = $("#insert_names").val().split(",");
				$("#insert_namediv").empty();
				let output ="";
			
				if($("#insert_names").val()){ //값이 존재할 때
				
					for(var i=0; i<insert_name.length; i++){
						if(i==7){
							output += '<div class="insert_name etc_name">'+ "·&nbsp;·&nbsp;·"+'</div>';	
							output += '<div class="insert_name etc_show">'+ insert_name[i] +'</div>';	
						}else if(i>7){
							output += '<div class="insert_name etc_show">'+insert_name[i]+'</div>';
						}else{
							output += '<div class="insert_name">'+insert_name[i]+'</div>';
						}
				
					}
					$("#insert_namediv").append(output);
					setTimeout(function(){
						$(".wrap_namediv").css('height',$("#insert_namediv").css('height'));
					}, 100);
				}
			}else if(goupdate==true){
				//자동으로 개별 이름 div가 생성되도록
				$("#update_names").val(check_name);
				let update_name = $("#update_names").val().split(",");
				$("#update_namediv").empty();
				let output ="";
			
				if($("#update_names").val()){ //값이 존재할 때
				
					for(var i=0; i<update_name.length; i++){
						if(i==7){
							output += '<div class="update_name etc_name">'+ "·&nbsp;·&nbsp;·"+'</div>';	
							output += '<div class="update_name etc_show">'+ update_name[i] +'</div>';	
						}else if(i>7){
							output += '<div class="update_name etc_show">'+update_name[i]+'</div>';
						}else{
							output += '<div class="update_name">'+update_name[i]+'</div>';
						}
				
					}
					$("#update_namediv").append(output);
					setTimeout(function(){
						$(".wrap_namediv").css('height',$("#update_namediv").css('height'));
					}, 100);
				}			
			}
			
		});
	
		
   });