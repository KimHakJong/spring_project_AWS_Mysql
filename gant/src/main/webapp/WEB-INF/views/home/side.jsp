<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ include file="../memo/memolist.jsp" %>
<!DOCTYPE html>
<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">


    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/home/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="${pageContext.request.contextPath}/resources/css/home/style.css" rel="stylesheet">
<style>
.logo{width:100%;text-align:center}
.leftside::-webkit-scrollbar {
    width: 5px; /*스크롤바의 너비*/
}
.leftside::-webkit-scrollbar-thumb {
    height: 1%; /* 스크롤바의 길이 */
    background: transparent; /* 스크롤바의 색상 */
    
    border-radius: 10px;
}

.leftside::-webkit-scrollbar-track {
    background-color: transparent;  /*스크롤바 뒷 배경 색상*/
} 

    </style>
   <script>

	$(document).ready(function(){
		
	//현재 프로젝트명 뒤 경로
	let pagestart = window.location.pathname.substring(6);
	let index = pagestart.indexOf('/');
	let page = pagestart.substring(0,index);
	//메뉴 클릭하면 해당 메뉴에 active 클래스를 생성하여 다른 색으로 칠해지기 위한 코드입니다.
	let pagename = ["pmain", "att", "board","calendar", "reserve","member","note","request"];
	for(var i=0; i<pagename.length; i++){
		$('.sidemenu>a').each(function(){
		if(page==pagename[i]){
				let thisstart = $(this).attr('href').substring(6);
				let thisindex = $(this).attr('href').substring(6).indexOf('/');
				let thispage = thisstart.substring(0,thisindex);
				if(thispage==pagename[i]){
					$(this).addClass('active');
				}else{
					$(this).removeClass('active');
				}				
		}
		})
	}
	});
	
   
   </script>    
</head>

<body>
	<!-- isAnonymous() : 익명 사용자인 경우 로그인 페이지로 이동하도록 합니다. -->
	<sec:authorize access="isAnonymous()">
		<script>
			location.href = "${pageContext.request.contextPath}/member/login";
		</script>
	</sec:authorize>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="leftside sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="${pageContext.request.contextPath}/pmain/view" class="navbar-brand mx-4 mb-3 logo">
                    <h3 class="text-primary">GANT</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
					<c:if test="${empty profileimg}">
	    				<img class="rounded-circle" src="${pageContext.request.contextPath}/resources/image/home/defaultprofile.png"  alt="" style="width: 40px; height: 40px;">
	    			</c:if>
	    			<c:if test="${!empty profileimg}">
	    				<img class="rounded-circle" src="${pageContext.request.contextPath}/resources/image/memberupload/${profileimg}"  alt="" style="width: 40px; height: 40px;">
	    			</c:if>                    	                    
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                    <sec:authorize access="isAuthenticated()">
	   				 <sec:authentication property="principal" var="pinfo"/>
                        <h6 class="mb-0 side_userid">${pinfo.username}</h6>
                    </sec:authorize>
                        <span>${name}</span>
                    </div>
                </div>
                <div class="sidemenu navbar-nav w-100">
                    <a href="${pageContext.request.contextPath}/pmain/view" class="nav-item nav-link active"><i class="fas fa-folder-open me-2"></i>프로젝트</a>
                    <a href="${pageContext.request.contextPath}/att/main" class="nav-item nav-link"><i class="fas fa-user-clock me-2"></i>근태관리</a>
                    <a href="${pageContext.request.contextPath}/board/main" class="nav-item nav-link"><i class="fas fa-th-list me-2"></i>게시판</a> <!-- 
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>프로젝트 게시판</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="button.html" class="dropdown-item">Buttons</a>
                            <a href="typography.html" class="dropdown-item">Typography</a>
                            <a href="element.html" class="dropdown-item">Other Elements</a>
                        </div>
                    </div>
                     -->
                    <a href="${pageContext.request.contextPath}/calendar/list" class="nav-item nav-link"><i class="far fa-calendar-alt me-2"></i>캘린더</a>
                    <a href="${pageContext.request.contextPath}/reserve/main" class="nav-item nav-link"><i class="fas fa-clock me-2"></i>예약</a>
                    <a href="${pageContext.request.contextPath}/member/list" class="nav-item nav-link"><i class="fa fa-address-book me-2"></i>주소록</a>
                    <a href="${pageContext.request.contextPath}/note/getMian" class="nav-item nav-link"><i class="far fa-envelope me-2"></i>쪽지</a>
                    <a href="${pageContext.request.contextPath}/request/getMian" class="nav-item nav-link"><i class="fas fa-file me-2"></i>전자결재</a>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->
        
	    <!-- JavaScript Libraries -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/chart/chart.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/easing/easing.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="${pageContext.request.contextPath}/resources/js/home/main.js"></script>
</body>

</html>