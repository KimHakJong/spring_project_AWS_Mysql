function go(page) {
	const limit = 10;
	const data = `limit=${limit}&state=ajax&page=${page}`; //el이 아닌 백틱 (js에서만 사용추천)
	ajax(data);
}

//총 2페이지 페이징 처리된 경우
//이전 1 2 다음
//현재 페이지가 1페이지인 경우 아래와 같은 페이징 코드가 필요
//<li class="page-item"><a class="page-link gray">이전&nbsp;</a></li>
//<li class="page-item active"><a class="page-link">1</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(2)">2</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(2)">다음&nbsp;</a></li>

//현재 페이지가 2페이지인 경우 아래와 같은 페이징 코드가 필요
//<li class="page-item"><a class="page-link" href="javascript:go(1)">이전&nbsp;</a></li>
//<li class="page-item"><a class="page-link" href="javascript:go(1)">1</a></li>
//<li class="page-item active"><a class="page-link">2</a></li>
//<li class="page-item"><a class="page-link gray">다음&nbsp;</a></li>

function setPaging(href,digit){
	let active="";
	let gray="";
	if(href==""){ //href가 빈문자열인 경우
		if(isNaN(digit)){//이전&nbsp; 또는 다음&nbsp;
			gray="gray";
		}else{
			active="active";
		}
	}
	let output = '<li class="page-item ${active}">';
	//let anchor = "<a class='page-link " + gray + "'" + href + ">" + digit + "</a></li>";
	
	let anchor = `<a class='page-link ${gray}' ${href}>${digit}</a></li>`;
	output += anchor;
	return output;
}

function ajax(sdata){
	console.log(sdata)
	let token = $("meta[name='_csrf']").attr("content");
	let header = $("meta[name='_csrf_header']").attr("content");
	
	$.ajax({ //줄보기로 개수 바꾸면 그거에 맞게 새로고침안하고 변하게 하기 위해서 ajax쓴다.
		type : "POST",
		data : sdata,
		url : "list_ajax",
		dataType : "json",
		cache : false,
		beforeSend : function(xhr)
        {   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
        	xhr.setRequestHeader(header, token);			
        },
		success : function(data){
			$("#viewcount").val(data.limit);
			$("thead").find("font").text("글 개수 : " + data.listcount);
			
			
			if (data.listcount > 0) {//총 개수가 0보다 큰 경우
				$("tbody").remove();
				
				console.log(data.listcount);
				
				console.log(data.page);
				
				console.log(data.limit);
				
								
				let num = data.listcount - (data.page - 1) * data.limit; //글나올 때 번호 위에서부터 1씩 감소
				
				console.log(data);
				console.log(num);
				
				let output = "<tbody>";
				
				$(data.boardlist).each(
					
					function(index, item){
						
						output += "<tr><td>" + (num--) + "</td>";
						
						const blank_count = item.board_RE_LEV * 2 + 1;
						
						let blank = '&nbsp;'; //답글일 때 들여쓰기
						
						for (let i = 0; i<blank_count; i++){
							blank += '&nbsp;&nbsp';
						}
						
						let img="";
						if (item.board_RE_LEV > 0){
							img="<img src='..resources/image/line.gif'>";
						}
						
						let subject=item.board_SUBJECT.replace(/</g,'&lt')
						subject = subject.replace(/</g,'&gt')
						
						
						

						
						output += "<td><div>" + blank + img
						output += '<a href="detail?num='+item.board_NUM + '">'
						
						output += subject + '<span class="gray small">['+item.cnt+']</span></a></div></td>';
						output += "<td><div>" + item.board_NAME+"</div></td>"
						output += "<td><div>" + item.board_DATE+"</div></td>"
						output += "<td><div>" + item.board_READCOUNT+"</div></td></tr>"
					})
					output += "</tbody>"
					
					console.log(output);
					$('table').append(output) //table 완성
					
					$(".pagination").empty(); //페이징 처리 영역 내용 제거
					output = "";
					
					let digit = '이전&nbsp;'
					let href="";
					if(data.page > 1){
						href = 'href=javascript:go(' + (data.page-1) + ')';
					}
					output += setPaging(href, digit);
					
					for (let i = data.startpage; i <= data.endpage; i++){
						digit = i;
						href ="";
						if ( i != data.page){
							href = 'href=javascript:go(' + i + ')';
						}
						output += setPaging(href, digit);
					}
					
					digit = '다음&nbsp;';
					href="";
					if (data.page < data.maxpage) {
						href = 'href=javascript:go(' + (data.page + 1) + ')';
					}
					output += setPaging(href,digit);
					
					$('.pagination').append(output);
				}//if(data.listcount>0)
				
			}, //success end
			error : function() {
				console.log('에러');
			}
	})//ajax end
}//function ajax end


$(function(){
   $('.btn btn-primary').click(function(){
      location.href="write";
   });
   
});

