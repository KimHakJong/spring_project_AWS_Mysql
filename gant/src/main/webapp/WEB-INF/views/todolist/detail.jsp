<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.1/dist/jquery.min.js"></script>


<head>
<title>todolist 상세보기</title>
<meta name="_csrf" content="${_csrf.token}">
<meta name="_csrf_header" content="${_csrf.headerName}">


<style>
body > div > table > tbody >tr:nth-child(1) {
	text-align: center
}

td:nth-child(1) {
	width: 20%
}

a {
	color: white
}

body > div > table > tbody tr:last-child {
	text-align: center;
}

#myModal {
	display: none
}
.container-fluid.pt-4.px-4{
  margin-bottom : 40px;
  height : 100%;
  width : 55%;
}
textarea{resize:none}

</style>
</head>
<script>
var token = $("meta[name='_csrf']").attr("content");
var header = $("meta[name='_csrf_header']").attr("content");

function deletelist(num, s, p_no) {
	
	
	
	if (confirm('일정을 삭제하시겠습니까?')) {
		var data = {
			"num" : num,	
			"s" : s,
			"p_no" : p_no
		};
		
		console.log(data);
		
		//DB 삭제

		$.ajax({
			url : "${pageContext.request.contextPath}/todolist/delete?num="+num,
			type : "post",
			//data : data,
			//dataType : "text",
			async: false,
			beforeSend : function(xhr)
  			{   //데이터를 전송하기 전에 헤더에 csrf값을 설정합니다.
				xhr.setRequestHeader(header, token);
				
    						
    		},

			success : function(data) {


				
			},
			error : function(data) {
				//alert(xhr.responseText);

			},
			complete: function(){
				alert('할일 삭제 성공입니다.');
				
				if( s == 1 ){
					var url = "${pageContext.request.contextPath}/todolist/send?p_no=" + p_no;	
				}
				else if( s == 0 ){
					var url = "${pageContext.request.contextPath}/todolist/receive?p_no="+p_no;
				}
				
				location.replace(url);
			}
			
		});
		//
	}
}

</script>

<body>

<jsp:include page="../home/side.jsp" />
<div class="content">


<jsp:include page="../home/header2.jsp" />
<div class="container-fluid pt-4 px-4"> 
	<div class="container" id="container">

	<div class="container">
		<table class="table">
			<tr>
				<th colspan="2"><h1>ToDo-List 상세 보기</h1></th>
			</tr>
			<tr>
				<td><div>보낸 사람</div></td>
				<td><div>${todolist.board_id}</div></td>
			</tr>
			<tr>
				<td><div>제목</div></td>
				<td><c:out value="${todolist.board_subject}" /></td>
			</tr>
			<tr>
				<td><div>내용</div></td>
				<td style="padding-right: 0px">
				<textarea class="form-control" rows="5" readOnly>${todolist.board_content }</textarea></td>

			</tr>
			<tr>
				<td><div>기한</div></td>
				<td><input type="date" class="form-control" id="deadline" 
				name="deadline" value="${todolist.deadline }" readOnly></td>

			</tr>
			
			<tr>
				<td>진행 상태</td>
				<c:choose>
					<c:when test="${todolist.state eq 'false'}">
				 		<td>
					      완료 <i class="bi bi-stop-circle" style="color:#DC3545"></i>				
						</td>
					</c:when>
					<c:otherwise>
						<td>
					      진행중 <i class="bi bi-check-circle" style="color:#198754"></i>
						</td>
					</c:otherwise>
				 </c:choose>
			</tr>


			<tr>
				<td colspan="2" class="center">

					
				<sec:authorize access="isAuthenticated()">
    			<sec:authentication property="principal" var="pinfo"/>
    			
    			<a href="modifyView?num=${todolist.board_num}&s=${s}&p_no=${todolist.p_no}">
					<button class="btn btn-success">수정</button>
				</a>
				
				<c:if test="${s == 1 }">	<%-- s가 1이면 send, 0이면 receive --%>
					<c:if test="${todolist.board_id eq pinfo.username || pinfo.username eq todolist.hostid || todolist.admin eq 'true'  }">
					<%-- 보낸사람, 프로젝트 관리자, admin만 삭제가 가능합니다. --%>
					
						<%-- href 주소를 #으로 설정합니다 --%>
						
						<button class="btn btn-danger" onclick="deletelist(${todolist.board_num}, ${s }, ${todolist.p_no })">삭제</button>
						
						
					</c:if>
				</c:if>
				</sec:authorize>
				
				<c:if test="${s == 1 }">	<%-- s가 1이면 send, 0이면 receive --%>
					<button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/todolist/send?p_no=${todolist.p_no}'">목록</button>
				</c:if>
				<c:if test="${s == 0 }">	<%-- s가 1이면 send, 0이면 receive --%>
					<button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/todolist/receive?p_no=${todolist.p_no}'">목록</button>
				</c:if>

		</table>

	</div>
	</div>
	</div>
	</div>


		

	</div>


</body>
</html>