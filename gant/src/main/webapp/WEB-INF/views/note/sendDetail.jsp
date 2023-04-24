<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
 <head>
    <meta charset="utf-8">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> 
    <title>쪽지상세보기</title>
    
    <style>
    .border-bottom{
    border-bottom:1px solid #9e9e9e73
    }
     .border-top{
    border-top:1px solid #9e9e9e73
    }
    
    .table{
    margin-top:3%; 
    font-weight:    
    }
    
    #list{
    font-weight:bold;
    padding-left: 0px
    }
    
    .font-color{
    color: #757575
    }
    h4{
     padding-top:1.5%;
    }
    
    .p-3.my-3.border{
    padding-top: 0px;
    }
    
    .float-right{
    float: right;
    }
    #imgsub{
			width:30px;
			vertical-align:middle;
		}
		
     .box{
     height: 50px;
     width: 30%;
    padding-top:9px !important;
    padding-left:10px !important;
     }
    #content{
    margin-top:10px !important
}
#originalname{
    font-size:small;
    
}

 </style>
    
    <script>
    $(function(){
	
    	
    	
    	//첨부파일 글씨를 클릭하면 첨부파일이 사라지고 , 다시클릭하면 보인다.
    	$('#flie').click(function(){
    		
    		let file = $('#flie').text();
    		
    		if(file == '∧ 첨부파일'){
    			$('.box').hide();
    			$('#flieborder').addClass('border-bottom');
    			$('#flie').text('∨ 첨부파일');
    			
       	 }else if(file == '∨ 첨부파일'){
       		$('.box').show();
			$('#flieborder').removeClass('border-bottom');
			$('#flie').text('∧ 첨부파일');
       	 }
    	});
    	
    	$('#basket').click(function(){
    		
    	if(confirm("휴지통으로 이동합니다. 일주일 뒤 자동으로 삭제됩니다."))
    		location.href='getBasket?note_num=${note.NOTE_NUM}&type=send'
    	});
    	
    	
           $('#DeletePermanently').click(function(){
    		
        	if(confirm("영구삭제 시 복구가 불가능합니다. 그래도 삭제하시겠습니까?"))
        		location.href='delete?note_num=${note.NOTE_NUM}&type=send'
        	});
    	
           
           $('#restore').click(function(){
       		
           	if(confirm("복구하시겠습니까?"))
           		location.href='restore?note_num=${note.NOTE_NUM}&type=send'
           	});
    	
	});
    </script>
  </head>
  <body>
  <jsp:include page="../home/side.jsp" />
  

  <div class="content">
  <jsp:include page="../home/header2.jsp" />
    
    <div class="container">
     
      <table class="table table-borderless">
         
          <c:if test="${type == 'normal' }">
		     <tr>
		        <th class="border-bottom">		        
		        <button type="button" class="btn" id="list"  onClick="location.href='sendMian'" >〈 목록</button>
		        <div class="float-right">
		        <button type="button" class="btn btn-outline-danger btn-sm" id="basket">삭제</button>		        		        
		        </div>
		        </th>
		     </tr>
		  </c:if>   
		  
		 <c:if test="${type == 'basket' }">
		     <tr>
		        <th class="border-bottom">		        
		        <button type="button" class="btn" id="list"  onClick="location.href='sendBasketMian'" >〈 목록</button>
		        <div class="float-right">
		        <button type="button" class="btn btn-outline-danger btn-sm" id="DeletePermanently">영구삭제</button>
		        <button type="button" class="btn btn-outline-primary btn-sm" id="restore">복구</button>			        		       
		        </div>
		        </th>
		     </tr>
		     
		</c:if>     
		    
		    
		    <tr>
		        <th>
		        <h4 class="font-color">&nbsp;${note.SUBJECT}</h4>		         
		        </th>
		    </tr>
		    

		    
		    <tr id="to_name">
		        <th>
		        &nbsp;<span>받은사람</span>
		         
		         <c:forEach var="name" items="${name_list}" varStatus="loopStatus">
				    <c:if test="${loopStatus.index < 5}">
				        <span class="badge rounded-pill bg-primary">${name}</span>
				    </c:if>
				    <c:if test="${loopStatus.index == 5}">
				        <span class="badge rounded-pill bg-primary">...</span>
				    </c:if>
				</c:forEach>
		               
		        </th>
		    </tr>
		    
		    <tr class="border-bottom">
		        <th>
		        <span class="badge border-secondary border-1 text-secondary">${note.WRITE_DATE}</span>        
		        </th>
		    </tr>
		    
		   <c:if test="${not empty note.ORIGINAL_FILENAME}">		
		    
		    <tr>
		        <th>
		        &nbsp;<span id="flie">∧ 첨부파일</span>     
		        </th>
		    </tr>
		    
		    <tr id="flieborder">
		        <th>
		        	<div class="border box">
		        	
					       <form method="post" action="down">
				             <input type="hidden" value="${note.SAVE_FOLDER}" name="save_folder">
				             <input type="hidden" value="${note.ORIGINAL_FILENAME}.${note.EXTENSION}" name="original_filename">
				             <div id ="submitname">
				             <input type="image" src="${pageContext.request.contextPath}/resources/image/note/download.png" id="imgsub">
				               <span id="originalname">
				               ${note.ORIGINAL_FILENAME}.${note.EXTENSION}
				               </span>
				              </div>
				              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				          </form>
		        	
		        	</div>
		        </th>
		    </tr>
		    
		    </c:if>
		    
		    <tr>
		      <td>
			      <div id="content">
			       ${note.CONTENT}
			      </div> 
		      </td>
	        </tr>
	    
	    </table>
     
     
     
    </div> <%-- container end --%>
                       
     </div>  <%-- content end --%>



    
    

   
    
    <footer>
		<jsp:include page="../home/bottom.jsp" />
	</footer>
    
  </body>
</html>