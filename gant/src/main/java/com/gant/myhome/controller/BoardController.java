package com.gant.myhome.controller;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;

import java.util.List;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gant.myhome.domain.Board;
import com.gant.myhome.domain.BoardSaveFolder;
import com.gant.myhome.service.BoardLikeService;
import com.gant.myhome.service.BoardService;
import com.gant.myhome.service.CommentService;






@Controller
@RequestMapping(value = "/board")//http://localhost:8088/myhome4/board/ 로 시작하는 주소 맴핑
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	private BoardSaveFolder  boardsavefolder;
	private BoardService  boardService;
	private BoardLikeService  boardlikeService;
	private CommentService commentService;
	
		
	@Autowired
	public BoardController(BoardService boardService ,
			CommentService  commentService,
			BoardSaveFolder  boardsavefolder,
			BoardLikeService  boardlikeService
			) {
	this.boardService = boardService;
	this.commentService = commentService;
	this.boardsavefolder = boardsavefolder;
	this.boardlikeService = boardlikeService;
	}
	
	//response에 PrintWriter를 사용하여 스크립트를 사기위한 메서드
	public static void init(HttpServletResponse response) {
        response.setContentType("text/html; charset=utf-8");
        response.setCharacterEncoding("utf-8");
    }
	

	@RequestMapping(value = "/main" , method = RequestMethod.GET)
	public ModelAndView boardlist(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "search_name", defaultValue = "", required = false) String search_name,
			ModelAndView mv) {
		List<Board> boardlist = new ArrayList<Board>();
			
		int limit = 10; //  한 화면에 출력할 로우 갯수
		
		//개시물 갯수
		int listcount = 0 ; 
		
		
		//검색어가 없는경우
        if(search_name == null || search_name.equals("")) {	
        	//총 리스트 수를 받아옵니다.
			listcount = boardService.getListCount();
			
			//리스트를 받아옵니다.
			//일반게시물 리스트
			boardlist = boardService.getBoardList(page,limit);
				
		}else {// 검색어가있는경우

			//검색어에 포함되어있는 게시글 수 
			listcount = boardService.getSearchListCount(search_name);
			
			//리스트를 받아옵니다.
			//검색어에 포함되어있는 게시글 리스트
			boardlist = boardService.getSearchBoardList(page,limit,search_name);
			
		}
		
        
		//총 페이지 수
		int maxpage = (listcount + limit - 1) / limit;
		
		//현재 페이지에 보여줄 시작 페이지 수 (1, 11 , 21 등....)
		int startpage = ((page - 1) / 10) * 10 + 1 ;
		
		// 현재 페이지에 보여줄 마지막 페이지 수 (10 , 20 , 30 등....)
		int endpage = startpage + 10 - 1 ;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		

		mv.setViewName("board/boardList");
		mv.addObject("page", page);
		mv.addObject("maxpage" , maxpage);
		mv.addObject("startpage" , startpage);
		mv.addObject("endpage" , endpage);
		mv.addObject("listcount" , listcount);
		mv.addObject("boardlist" , boardlist);
		mv.addObject("limit" , limit);
		
		return mv;
	}
	
	//글쓰기
	@GetMapping(value = "/write") 
	//@RequestMapping(value = "/write" , method = RequestMethod.GET)
	public ModelAndView write(Principal principal,
                              ModelAndView mv ) {			
    String id = principal.getName();
    String admin = boardService.getadmindate(id);
    mv.setViewName("board/boardWrite");
	mv.addObject("admin", admin);
	mv.addObject("id", id);
	 return mv;
	}
	
      //글등록
		/*
		 * 스프링 컨테이너는 매개변수 Board객체를 생성하고
		 * Board객체의 setter 메서드들을 호출하여 사용자 입력값을 설정합니다.
		 * 매개변수의 이름과 setter의 property가 일치하면 됩니다.
		 */
		@PostMapping(value = "/add") 
		//@RequestMapping(value = "/add" , method = RequestMethod.POST)
		public String add(Board board ,
				          HttpServletRequest request,
				          @RequestParam(value = "noticebox",defaultValue = "false" ,required = false) String noticebox,
				          @RequestParam(value = "board_pass",defaultValue = "1" ,required = false) String board_pass // 비밀글 설정을 안했다면 1을 넣어준다.   
				         )
		                   throws Exception{
		    /*
		     * MultipartFile 클래스는 웹 애플리케이션에서 파일 업로드를 처리하는 방법을 제공하는 Spring Framework 웹 모듈의 일부입니다.
		     *  HTTP 요청의 일부로 서버에 전송된 업로드된 파일을 나타냅니다.
		     */
		    MultipartFile uploadfile = board.getUploadfile();	
			
		    if(!uploadfile.isEmpty()) {
		    	String fileName = uploadfile.getOriginalFilename();//원래 파일명
		    	board.setBoard_original(fileName); //원래 파일명 저장
                
		    	//업로드 파일 저장 경로
		    	String saveFolder = boardsavefolder.getSavefolder();
		    	
		    	String fileDBName = fileDBName(fileName , saveFolder);
		    	
		    	// transferTo(Flie path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
		    	//import java.io.File;
		    	uploadfile.transferTo(new File(saveFolder + fileDBName));
		    	logger.info("transferTo path = " + saveFolder + fileDBName);
		    	//바뀐 파일명으로 저장
		    	board.setBoard_file(fileDBName);
		    }
		    
		    // 공지게시글 체크 여부는 admin 계정만 할 수 있다. 만약 noticebox값이 null이라면 "false"(일반글) 로 값을 넣어준다.
		    board.setBoard_notice(noticebox);
		    // 비밀글 설정을 안했다면 1
		    board.setBoard_pass(board_pass);
		        
			boardService.insertBoard(board); // 정의한 메서드 호출
			logger.info(board.toString()); // selectKey로 정의한 BOARD_NUM 값 확인해 봅니다.
			return "redirect:main";
		}
	
		
		private String fileDBName(String fileName, String saveFolder) {
			// 새로운 폴터 이름 : 오늘 년+월+일
			Calendar c = Calendar.getInstance();
			int year = c.get(Calendar.YEAR); //오늘 년도 구합니다.
			int month = c.get(Calendar.MONTH);//오늘 월도 구합니다.
			int date = c.get(Calendar.DATE);//오늘 일 구합니다.
			
			String homedir = saveFolder + "/" + year + "-" + month + "-" + date;

			File path1 = new File(homedir);
			if(!(path1.exists())) { // 폴더의 유무 확인
				path1.mkdir(); // 새로운 폴더를 생성
			}
			
			//난수를 구합니다.
			Random r = new Random();
			int random = r.nextInt(100000000);
			
			/*** 확장자 구하기 시작  ***/
			int index = fileName.lastIndexOf(".");
			/* 문자열에서 특정 문자열의 위치 값(index)를 반환합니다.
			 * indexof가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
			 * lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
			 * (파일명에 점에 여려개 있을경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다. 
			 */
			
			String fileExtension = fileName.substring(index+1);
			/*** 확장자 구하기 끝  ***/
			
			//새로운 파일명
			String refileName = "bbs" + year + month + date + random + "." + fileExtension;
			
			//오라클 디비에 저장될 파일 명
			//String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName; 
			//File.separator 는 파일 시스템별 디렉터리 구분 문자를 나타내는 공용 정적 필드입니다.  즉 "/"을 나타낸다.
			String fileDBName = File.separator + year + "-" + month + "-" + date + File.separator + refileName; 
			logger.info("fileDBName = "+ fileDBName);
			return fileDBName;
		}
		
		
		//상세페이지 이동
		//detail?num=9요청시 파라미터 num의 값을 int num에 저장합니다.
		@RequestMapping(value="/detail" , method = {RequestMethod.GET, RequestMethod.POST})
		public ModelAndView Detail(
				Principal principal,
				@RequestParam(value = "board_pass",defaultValue = "1" ,required = false) String board_pass,
				@RequestParam(value = "input_pass",required = false) String input_pass,
				int board_num,			
				ModelAndView mv,
				HttpServletRequest request,
				HttpServletResponse response,
				//현재 페이지 오기 전  URL정보
				@RequestHeader(value = "referer", required = false) String beforeURL)
				throws IOException {
			
			String id = principal.getName();
			
			//board_pass 가 1이면 일반글 아니면 비밀글
			//비밀글이 경우 입력한 비밀번호가 맞는지 확인한다.
			if(!board_pass.equals("1")) {  
				    // input_pass 와 board_pass 가 다르다면 다시 리스트 화면으로 가게한다
				    if(!board_pass.equals(input_pass)) {	
				    	init(response);
						PrintWriter out = response.getWriter();
						out.println("<script>");
						out.println("alert('비밀번호가 다릅니다.')");
						out.println("history.back(-1);");
						out.println("</script>");
						out.flush();
						return null;
				    }      
				}
	
			/*  
			 1. String beforeURL = request.getHeader("referer"); 의미로
			 어느 주소에서 detail로 이동했는지 header의 정보 중에서 "referer"를 통해 알 수 있습니다.
			 2. 수정 후 이곳에서 이동하는 경우 조회수는 증가하지 않도록 합니다.
			 3.gant/board/main에서 제목을 클릭한 경우 조회수가 증가하도록 합니다.
			 4.detail을 새로고침 하는 경우 referer는 header에 존재하지 않아 오류 발생하므로
			  required = false로 설정합니다. 이 경우에는  beforeURL 의 값은 null입니다.
			 * */
			logger.info("referer:"+beforeURL);
			if(beforeURL != null && beforeURL.endsWith("main")) {
				boardService.setReadCountUpdate(board_num);
			}
			
			
			//boardLike 테이블이있는지 확인 select으로 확인 
			//selectlike 1이면 있고 0이면 없음
			int selectlike = boardlikeService.selectLike(id,board_num);
			String like_check = ""; 
			if(selectlike == 0) {
				boardlikeService.insertLike(id,board_num);
				mv.addObject("like_check","false");
			}else if(selectlike == 1) {
				like_check =  boardlikeService.selectLikeCheck(id,board_num);
				mv.addObject("like_check",like_check);
			}
			
				
			Board board = boardService.getDetail(board_num);
			board.setId_profileimg(boardService.getprofileimg(board.getBoard_name()));
		   
			if(board.getId_profileimg() == null || board.getId_profileimg().equals("") ) {
				board.setId_profileimg("people.png");
			}
				logger.info("상세보기 성공");
				String admin = boardService.getadmindate(id);
				mv.setViewName("board/boardView");
				mv.addObject("boarddata",board);				
				mv.addObject("admin",admin);			
				mv.addObject("id",id);				
			return mv;
			
		}
		
		@GetMapping(value = "/delete") 
		public String BoardDeleteAction(
				int board_num,
				Model mv,
				HttpServletResponse response
				) throws IOException{
		
		 
		 //비밀번호 일치하는 경우 삭제 처리 합니다.
		 int result = boardService.boardDelete(board_num);

		 //삭제 처리 실패한 경우
		 if(result == 0) {
			logger.info("상세보기 실패");
			mv.addAttribute("message","삭제 실패");
			return "error/error";
		 }
		    logger.info("게시판 삭제 성공");
		    init(response);
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('삭제되었습니다.')");
			out.println("location.href='main';");
			out.println("</script>");
			out.close();
			return null;
		 
		}
		
		
		@GetMapping(value = "/likecheck") 
		public String likecheck(
				Principal principal,
				String like_check,
				int board_num,
				Model mv,
				HttpServletResponse response) throws IOException
		                   {
			String id = principal.getName();
			
			if(like_check.equals("true")) {
				// like_check 를 false에서 true으로 변경
				int result = boardlikeService.updateLike(id,board_num,like_check);
				if(result == 0){
					logger.info("좋아요 업데이트 실패");
					mv.addAttribute("message","좋아요 업데이트 실패");
					return "error/error";
				 }
				// board BOARD_LIKE(좋아요수) 를 1 증가시킨다.
				boardService.BoardupdateLike(board_num,1);
			}else if(like_check.equals("false")) {
				// like_check 를 false에서 true으로 변경
				int result = boardlikeService.updateLike(id,board_num,like_check);
				if(result == 0){
					logger.info("좋아요 업데이트 실패");
					mv.addAttribute("message","좋아요 업데이트 실패");
					return "error/error";				 }
				// board BOARD_LIKE(좋아요수) 를 1 감소시킨다.
				boardService.BoardupdateLike(board_num,-1);
			}
			    init(response);
				PrintWriter out = response.getWriter();
				out.println("Success");
				out.close();
				return null;
		}
		
		
		@GetMapping(value = "/reply") 
		public ModelAndView BoardReplyView(
				                  int num,
				                  ModelAndView mv,
				                  HttpServletRequest request
				                  ) {
		  Board boarddata = boardService.getDetail(num);
		  
		  //글 내용 불러오기 실패한 경우
		  if(boarddata == null) {
			  mv.setViewName("error/error");
			  mv.addObject("message" , "게시판 답변글 가져오기 실패");		  
		  }else {
			  mv.addObject("boarddata",boarddata);
			  mv.setViewName("board/boardReply");  
		  }

			return mv;
		}
		
		
		@PostMapping(value = "/replyAction") 
		public ModelAndView BoardReplyAction(
				@RequestParam(value = "board_pass",defaultValue = "1" ,required = false) String board_pass, // 비밀글 설정을 안했다면 1을 넣어준다.   
				Board board,
				ModelAndView mv
				){
		// 비밀글 설정을 안했다면 1
		board.setBoard_pass(board_pass);
		
		int result = boardService.boardReply(board);	
		if(result == 0 ) {	//답글달기 실패 시
	      mv.setViewName("error/error");
		  mv.addObject("message" , "수정보기 실패입니다.");
		}else { // 답글달기 성공 시 
		  mv.setViewName("redirect:main");
		}			
			return mv;
		}
		
		
		//파일 다운로드
		@ResponseBody
		@PostMapping(value = "/down") 
		public byte[] BoardFileDown(
								String filename,
								HttpServletRequest request,
								String original,
								HttpServletResponse response
								) throws Exception{

			
		String saveFolder = boardsavefolder.getSavefolder();
		String sFilePath = saveFolder + filename;
		
		File file = new File(sFilePath);
		
		// Spring에서 지원하는 메서드
		byte[] bytes = FileCopyUtils.copyToByteArray(file);
		
		String sEncoding = new String(original.getBytes("utf-8"), "ISO-8859-1");
		
		//Content-Disposition : attachment: 브라우저는 해당 Content를 처리하지 않고 , 다운로드하게 됩니다.
		response.setHeader("Content-Disposition","attachment;filename=" + sEncoding);
		
		response.setContentLength(bytes.length);
		return bytes;
		}
				
		
		
		@GetMapping(value = "/modify") 
		public ModelAndView BoardmodifyView(
				                  int num,
				                  ModelAndView mv,
				                  HttpServletRequest request
				                  ) {
		  Board boarddata = boardService.getDetail(num);
		  
		  //글 내용 불러오기 실패한 경우
		  if(boarddata == null) {
			  logger.info("수정 보기 실패");
			  mv.setViewName("error/error");
			  mv.addObject("message" , "수정보기 실패입니다.");
			  return mv;		  
		  }
		  
		  String admin = boardService.getadmindate(boarddata.getBoard_name());
		  
		  logger.info("(수정)상세보기 보기 성공");
		  //수정 폼 페이지로 이동할 때 원문 글 내용을 보여주기 때문에 boarddata 객체를 
		  // ModelAndView 객체에 저장합니다.
		  mv.addObject("boarddata" , boarddata);
		  mv.addObject("admin", admin);
		  //글 수정 폼 페이지로 이동하기 위해 경로를 설정합니다.
		  mv.setViewName("board/boardModify");
			return mv;
		}
		
		
		
		
		@PostMapping(value = "/modifyAction") 
		public String BoardModifyAction(
				Board boarddata,
				String check, Model mv,
				@RequestParam(value = "noticebox",defaultValue = "false" ,required = false) String noticebox,
				@RequestParam(value = "board_pass",defaultValue = "1" ,required = false) String board_pass, // 비밀글 설정을 안했다면 1을 넣어준다.   
				HttpServletRequest request
				) throws Exception {
			 
			 boarddata.setBoard_notice(noticebox);
			 
			 boarddata.setBoard_pass(board_pass);
	         
			 MultipartFile uploadfile = boarddata.getUploadfile();	
	       
			 
	         if(check != null && !check.equals("")) { //기존 파일 그대로 사용하는 경우입니다.
	        	 //기존의 파일을 그대로 사용
	        	 boarddata.setBoard_original(check);

	         }else {
	        	 //답변글의 경우 파일 첨부에 대한 기능이 없습니다.
	        	 //만약 답변글을 수정할 경우
	        	 //<input type="file" id="upfile" name="uploadfile">엘리먼트가 존재하지 않아
	        	 // private MultipartFile uploadfile; 에서 uploadfile은 null입니다.
	        	 if(uploadfile != null && !uploadfile.isEmpty()) {
	        		logger.info("파일 변경되었습니다.");
	        		 
	        		String fileName = uploadfile.getOriginalFilename();//원래 파일명
	        		boarddata.setBoard_original(fileName); //원래 파일명 저장
	        		
	        		String saveFolder = boardsavefolder.getSavefolder();
	     	    	String fileDBName = fileDBName(fileName , saveFolder);

	     	    	
	     	    	// transferTo(Flie path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
	     	    	uploadfile.transferTo(new File(saveFolder + fileDBName));

	     	    	//바뀐 파일명으로 저장
	     	    	boarddata.setBoard_file(fileDBName);
	        	 }else {// 기존 파일이 없는데 파일 선택하지 않은 경우 또는 기존 파일이 있었는데 삭제한 경우
	        		 logger.info("선택된 파일이 없습니다.");
	        		// <input type="hidden" name="BOARD_FILE" value="${boarddata.BOARD_FILE}">
	        	    // 위 태그에 값이  있다면 ""로 값을 변경합니다.
	        		 boarddata.setBoard_file("");//""로 초기화 합니다.
	        		 boarddata.setBoard_original("");//""로 초기화 합니다.
	        	 } // else end        	 
	         } // else end
	         
	         //DAO에서 수정 메서드 호출하여 수정합니다.
	         int result = boardService.boardModify(boarddata);
	         String url = "";
	         //수정에 실패한 경우
	         if(result == 0) {
	        	 logger.info("게시파 수정 실패");
	   		     mv.addAttribute("message" , "게시판 수정 실패");
	   		     url = "error/error";
	         }else { // 수정 성공의 경우
	        	 logger.info("게시판 수정 완료");
	        	 //수정한 글 내용을 보여주기 위해 글 내용 보기 보기 페이지로 이동하기위해 경로를 설정합니다.
	        	 url = "redirect:main";
	         }         
			return url;
		}
		
		
		
	
	
	
	


}
