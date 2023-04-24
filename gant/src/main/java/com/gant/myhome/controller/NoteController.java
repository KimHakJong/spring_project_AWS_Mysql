package com.gant.myhome.controller;


import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Note;
import com.gant.myhome.domain.NoteSaveFolder;
import com.gant.myhome.service.NoteService;
import com.gant.myhome.service.RequestService;







@Controller
@RequestMapping(value = "/note")//http://localhost:8088/myhome4/board/ 로 시작하는 주소 맴핑
public class NoteController {
	
	private static final Logger logger = LoggerFactory.getLogger(NoteController.class);
	
	private NoteService noteService;
	private RequestService requestservice;
	private NoteSaveFolder noteSavefolder;
	
	@Autowired
	public NoteController(NoteService noteService,RequestService requestservice,NoteSaveFolder noteSavefolder) {
		this.noteService = noteService;
		this.requestservice = requestservice;
		this.noteSavefolder = noteSavefolder;
	}
	
	    //response에 PrintWriter를 사용하여 스크립트를 사기위한 메서드
		public static void init(HttpServletResponse response) {
	        response.setContentType("text/html; charset=utf-8");
	        response.setCharacterEncoding("utf-8");
	    }
		
		
	
	
	//받은 쪽지함이동
	@RequestMapping(value = "/getMian" , method = RequestMethod.GET)
	public ModelAndView getMian(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "search_subject", defaultValue = "", required = false) String search_subject,
			Principal principal,
			ModelAndView mv)  {
		
		String id = principal.getName();
		 		 
		//id가 참조자로 되어있는 받은쪽지함 테이블의 갯수를 가져온다.
		String delete_table = "no"; //  note_delete 테이블에서 delete_table = 'no' 인값이 휴지통에 들어가지않은 받은쪽지들이다.
		int listcount =  noteService.getNoteNum(id,search_subject,delete_table);
			
	    //  한 화면에 출력할 로우 갯수
	    int limit = 10; //  한 화면에 출력할 로우 갯수
			
	    //총 페이지 수
		int maxpage = (listcount + limit - 1) / limit;
					
		//현재 페이지에 보여줄 시작 페이지 수 (1, 11 , 21 등....)
		int startpage = ((page - 1) / 10) * 10 + 1 ;
					
		// 현재 페이지에 보여줄 마지막 페이지 수 (10 , 20 , 30 등....)
		int endpage = startpage + 10 - 1 ;
					
		if(endpage > maxpage) {
			endpage = maxpage;
			}
		
		// id에 해당하는 받은 쪽지 List을 가져온다. 
		List<Note> note_list = noteService.getNoteList(id,page,limit,search_subject,delete_table);
		
	        
		mv.setViewName("note/getmain");
		mv.addObject("note_list",note_list);
		mv.addObject("page", page);
		mv.addObject("maxpage" , maxpage);
		mv.addObject("startpage" , startpage);
		mv.addObject("endpage" , endpage);
		mv.addObject("search_subject" , search_subject);			
		return mv;
	}
	
	//보낸 쪽지함 이동
	@RequestMapping(value = "/sendMian" , method = RequestMethod.GET)
	public ModelAndView sendMian(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "search_subject", defaultValue = "", required = false) String search_subject,
			Principal principal,
			ModelAndView mv)  {
		
		String id = principal.getName();
		 		 
		//id가 보낸사람을 되어있는 되어있는 보낸쪽지함 테이블(note)의 갯수를 가져온다.
		String delete_table = "no"; //  note_delete 테이블에서 delete_table = 'no' 인값이 휴지통에 들어가지않은 받은쪽지들이다.
		int listcount =  noteService.sendNoteNum(id,search_subject,delete_table);
			
	    //  한 화면에 출력할 로우 갯수
	    int limit = 10; //  한 화면에 출력할 로우 갯수
			
	    //총 페이지 수
		int maxpage = (listcount + limit - 1) / limit;
					
		//현재 페이지에 보여줄 시작 페이지 수 (1, 11 , 21 등....)
		int startpage = ((page - 1) / 10) * 10 + 1 ;
					
		// 현재 페이지에 보여줄 마지막 페이지 수 (10 , 20 , 30 등....)
		int endpage = startpage + 10 - 1 ;
					
		if(endpage > maxpage) {
			endpage = maxpage;
			}
		
		// id에 해당하는 보낸 쪽지 List을 가져온다. 
		List<Note> note_list = noteService.sendNoteList(id,page,limit,search_subject,delete_table);
		
		for(Note notes : note_list) {
			// id,id,id.. 형태를 "," 을 기준으로 문자 배열로 변환시킨다. 
			String to_ids = notes.getTo_id();
			String[] to_id = to_ids.split(",");
			    //보낸 사람이 1명이 아니라면 보낸사람에 "이름 외0명" 이라고 표시한다.
				if(to_id.length != 1) {
				String name = "";
	
				//id에 해당하는 이름을 members테이블에서 가져온다.
				name += noteService.selectName(to_id[0]);			
				name += " 외"+ (to_id.length-1) + "명";
	            			
				notes.setTo_name(name);
				}else {
					notes.setTo_name(to_id[0]);	
				}
		}
	        
		mv.setViewName("note/sendmain");
		mv.addObject("note_list",note_list);
		mv.addObject("page", page);
		mv.addObject("maxpage" , maxpage);
		mv.addObject("startpage" , startpage);
		mv.addObject("endpage" , endpage);
		mv.addObject("search_subject" , search_subject);			
		return mv;
	}

	@RequestMapping(value = "/write" , method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView write(
			@RequestParam(value = "subject", defaultValue = "", required = false) String subject,
			@RequestParam(value = "content", defaultValue = "", required = false) String content,
			@RequestParam(value = "writer", defaultValue = "", required = false) String writer,
			Principal principal,
			ModelAndView mv)  {
		String id = principal.getName();
		int membercount = requestservice.getMembersCount(id);
		List<Members> memberlist = requestservice.getMembersList(id);
			
		mv.setViewName("note/write");	
		mv.addObject("memberlist",memberlist);
		mv.addObject("membercount",membercount);			
		mv.addObject("subject",subject);
		mv.addObject("content",content);
		mv.addObject("writer",writer);
		return mv;
	}
	
	
	@RequestMapping(value = "/writeAction" , method = RequestMethod.POST)
	public ModelAndView writeAction(
			Principal principal,
			Note note,
			ModelAndView mv) throws IllegalStateException, IOException  {
	
		String id = principal.getName();
		note.setId(id);
		
		int result = 0;
		int file_num = 0; //파일번호
		/* 파일 테이블 insert과정 
	     * MultipartFile 클래스는 웹 애플리케이션에서 파일 업로드를 처리하는 방법을 제공하는 Spring Framework 웹 모듈의 일부입니다.
	     *  HTTP 요청의 일부로 서버에 전송된 업로드된 파일을 나타냅니다.
	     */
		 MultipartFile uploadfile = note.getUploadfile();	
		
	    if(!uploadfile.isEmpty()) {
	    	String originalfileName = uploadfile.getOriginalFilename();//원래 파일명
	    	
            
	    	//업로드 파일 저장 경로
	    	String saveFolder = noteSavefolder.getSavefolder();
	    	
	    	//중복방지를 위한 파일명과 경로를 만들어준다.
	    	note = fileDBName(originalfileName , saveFolder , note);
	    	
	    	String fileDBName = note.getSave_folder();
	    	
	    	// transferTo(Flie path) : 업로드한 파일을 매개변수의 경로에 저장합니다.
	    	//import java.io.File;
	    	uploadfile.transferTo(new File(saveFolder + fileDBName));
	    	logger.info("transferTo path = " + saveFolder + fileDBName);
            
	    	//파일 테이블에(notefile)insert 한다. 
	    	result = noteService.insertNoteFile(note); 
	    	
	    	//insert 처리 실패한 경우
			 if(result == 0) {
				 logger.info("쪽지파일 테이블 생성 실패");
				 mv.setViewName("error/error");
				 mv.addObject("message" , "쪽지파일 테이블 생성 실패");		
			 }
			
			 logger.info("쪽지파일 테이블 생성 성공");
			 
			 //방금생성한 파일번호를 가져온다.
			 file_num = noteService.selectFileNum();
	    }
		
	  	//파일이 없다면 0    
	    note.setFile_num(file_num);
	    
		
		//쪽지휴지통(삭제전 임시보관함) 테이블을 생성
		//보낸쪽지함의 휴지통 테이블 생성
		String table_kind = "from";
		 result =  noteService.insertNoteDelete(table_kind);
		
		 //insert 처리 실패한 경우
		 if(result == 0) {
			 logger.info("보낸쪽지함 휴지통테이블 생성 실패");
			 mv.setViewName("error/error");
			 mv.addObject("message" , "휴지통테이블 생성 실패");		  
		 }
		 
		 logger.info("보낸쪽지함 휴지통테이블 생성 성공");
		
		//방금 생성한 휴지통 테이블의 휴지통 번호를 가져온다.
		int delete_num = noteService.selectDeleteNum();
		
		note.setDelete_num(delete_num);
		
		//보낸 쪽지함 테이블(note)에 insert
		result =  noteService.insertNote(note);
		
		//insert 처리 실패한 경우
		 if(result == 0) {
			 logger.info("보낸쪽지함 테이블 생성 실패");
			 mv.setViewName("error/error");
			 mv.addObject("message" , "보낸쪽지함 테이블 생성 실패");		
		 }
		
		 logger.info("보낸쪽지함 테이블 생성 성공");
		 
		 //방금 생성한 보낸쪽지함 테이블의 쪽지번호를 가져온다.
		 int note_num = noteService.selectNoteNum();
		 
		 note.setNote_num(note_num);
		 
		 //받는사람의 명단을 배열로 나열한다.
		 String to_ids  = note.getTo_id();
		 logger.info("받는사람 명당" + to_ids);
		 
		 String[] to_id = to_ids.split(",");
		 
		 //배열로나열한 받는사람명단에 각각의 휴지통 테이블과 , 받은 쪽지함 테이블을 생성한다.
		 for(String to : to_id) {
			 
			 logger.info("받는사람 id = " + to);
			 note.setTo_id(to);
			 
			    //쪽지휴지통(삭제전 임시보관함) 테이블을 생성
				//받은쪽지함의 휴지통 테이블 생성
				 table_kind = "to";
				 result =  noteService.insertNoteDelete(table_kind);
				
				 //insert 처리 실패한 경우
				 if(result == 0) {
					 logger.info("받은쪽지함 휴지통테이블 생성 실패");
					 mv.setViewName("error/error");
					 mv.addObject("message" , "휴지통테이블 생성 실패");		  
				 }
				 
				 logger.info("받은쪽지함 휴지통테이블 생성 성공");
				
				//방금 생성한 휴지통 테이블의 휴지통 번호를 가져온다.
				delete_num = noteService.selectDeleteNum();
				
				note.setDelete_num(delete_num);				
				
				//받은 쪽지함 테이블(note_to)에 insert
				result =  noteService.insertNoteTo(note);
				
				//insert 처리 실패한 경우
				 if(result == 0) {
					 logger.info("받은쪽지함 테이블 생성 실패");
					 mv.setViewName("error/error");
					 mv.addObject("message" , "받은쪽지함 테이블 생성 실패");		
				 }
				
				 logger.info("받은쪽지함 테이블 생성 성공");	 
			 
		 }

	
		mv.setViewName("redirect:/note/getMian");	
					
		return mv;
	}
	
	//새로운 파일을 저장할 파일 경로 + 중복 방지를 위해 새로운 파일명 을 만들어주는 메서드
	private Note fileDBName(String originalfileName, String saveFolder ,Note note) {
		
		// 새로운 폴더 이름 : 오늘 년+월+일 
		// 날마다 저장 폴더를 다르게 구분하도록 한다.
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR); //오늘 년도 구합니다.
		int month = c.get(Calendar.MONTH);//오늘 월도 구합니다.
		int date = c.get(Calendar.DATE);//오늘 일 구합니다.
		
		String homedir = saveFolder + "/" + year + "-" + month + "-" + date;

		File path1 = new File(homedir);
		if(!(path1.exists())) { // 폴더의 유무 확인
			path1.mkdir(); //폴더가 없다면 새로운 폴더를 생성
		}
		
		//난수를 구합니다.
		Random r = new Random();
		int random = r.nextInt(100000000);
		
		/*** 확장자 구하기 시작  ***/
		int index = originalfileName.lastIndexOf(".");
		/* 문자열에서 특정 문자열의 위치 값(index)를 반환합니다.
		 * indexof가 처음 발견되는 문자열에 대한 index를 반환하는 반면,
		 * lastIndexOf는 마지막으로 발견되는 문자열의 index를 반환합니다.
		 * (파일명에 점에 여려개 있을경우 맨 마지막에 발견되는 문자열의 위치를 리턴합니다. 
		 */
	
		
		String fileExtension = originalfileName.substring(index+1);
		
		String fileName = originalfileName.substring(0,index);
		
		//확장자 저장
		note.setExtension(fileExtension);
		
		//오리지널파일명 저장
		note.setOriginal_filename(fileName);
		
		
		/*** 확장자 구하기 끝  ***/
		
		//새로운 파일명
		String refileName = "note" + year + month + date + random + "." + fileExtension;
		
		//오라클 디비에 저장될 save_folder 컬럼의 데이터이다.
		//String fileDBName = "/" + year + "-" + month + "-" + date + "/" + refileName; 
		//File.separator 는 파일 시스템별 디렉터리 구분 문자를 나타내는 공용 정적 필드입니다.  즉 "/"을 나타낸다.
		String fileDBName = File.separator + year + "-" + month + "-" + date + File.separator + refileName; 
		logger.info("fileDBName = "+ fileDBName);
		
		//파일경로 + 중복방지파일이름 저장 
		note.setSave_folder(fileDBName);
		
		return note;
	}
	
	
	
    //받은쪽지함 상세페이지 
	@RequestMapping(value = "/getDetail" , method = RequestMethod.GET)
	public ModelAndView getDetail(
			@RequestParam(value = "note_num", defaultValue = "0", required = false) int note_num,
			@RequestParam(value = "read_check", required = false) String read_check,
			@RequestParam(value = "type", required = false) String type, //normal 이면 받은쪽지함 상세보기 , basket이면 휴지통의 받은쪽지함 상세보기
			@RequestParam(value = "file_num",defaultValue = "0", required = false) int file_num,
			Principal principal,
			ModelAndView mv)  {
		String id = principal.getName();
		
		//만약 읽음표시가 flase이면 true으로 변경하여준다.
		if(read_check.equals("false")) {
			noteService.ReadCheck(note_num,id);
		}
		
		
		//note_num에 파일이테이블이 있는지 없는지 확인 없으면 0 , 있으면 1
		int notefile = noteService.selectNotefile(file_num);
		
		//note_num 과 id에 해당하는 받은 쪽지테이블(note_to)의 데이터를 가져온다.
		Map<String,Object> note= noteService.selectNoteTo(note_num,id,notefile);
		
		
		
		// 날짜형태를 2023/03/21 -> 2023년 03월 21일 으로 변경한다.
		String write_date =(String) note.get("WRITE_DATE");
		
		String[] dates = write_date.split("/");
		
		String new_date = dates[0]+"년 "+dates[1]+"월 "+dates[2]+"일"; 
		
		note.put("WRITE_DATE" , new_date);
		
		mv.setViewName("note/getdetail");	
		mv.addObject("note",note);
		mv.addObject("type",type);
		return mv;
	}
	
	
	    //보낸쪽지함 상세페이지 
		@RequestMapping(value = "/sendDetail" , method = RequestMethod.GET)
		public ModelAndView sendDetail(
				@RequestParam(value = "note_num", defaultValue = "0", required = false) int note_num,
				@RequestParam(value = "type", required = false) String type, //normal 이면 받은쪽지함 상세보기 , basket이면 휴지통의 받은쪽지함 상세보기
				@RequestParam(value = "file_num",defaultValue = "0", required = false) int file_num,
				Principal principal,
				ModelAndView mv)  {
					
			//note_num에 파일이테이블이 있는지 없는지 확인 없으면 0 , 있으면 1
			int notefile = noteService.selectNotefile(file_num);
			
			//note_num에 해당하는 보낸 쪽지테이블(note)의 데이터를 가져온다.
			Map<String,Object> note= noteService.selectNote(note_num,notefile);
									
			// 날짜형태를 2023/03/21 -> 2023년 03월 21일 으로 변경한다.
			String write_date =(String) note.get("WRITE_DATE");
			
			String[] dates = write_date.split("/");
			
			String new_date = dates[0]+"년 "+dates[1]+"월 "+dates[2]+"일"; 
			
			note.put("WRITE_DATE" , new_date);
			
			// id,id,id.. 형태를 "," 을 기준으로 문자 배열로 변환시킨다. 
			String ids = (String) note.get("TO_ID");  
			
			String[] to_id = ids.split(",");
				
			//각각의 id에 해당하는 이름/부서/직급을 members 테이블에서 가져오고 List에 담는다.
			List<String> name_list = new ArrayList<String>();			
			for(String toid : to_id) {
				//id에 해당하는 이름/부서/직급을 members테이블에서 가져온다.
				Members memberdata = noteService.selectMembersdata(toid);
				
				// 이름 (부서/지급) 형태의 문자열로 만든다.
				String data = memberdata.getName()+ " ("+memberdata.getDepartment()+"/"+memberdata.getPosition()+")";
				name_list.add(data);			
			}
				
			
			mv.setViewName("note/sendDetail");	
			mv.addObject("note",note);
			mv.addObject("name_list",name_list);
			mv.addObject("type",type);
			return mv;
		}
	
	
	
	        //파일 다운로드
			@ResponseBody
			@PostMapping(value = "/down") 
			public byte[] BoardFileDown(
									String save_folder,
									HttpServletRequest request,
									String original_filename,
									HttpServletResponse response
									) throws Exception{

				
			String saveFolder = noteSavefolder.getSavefolder();
			String sFilePath = saveFolder + save_folder;
			
			File file = new File(sFilePath);
			
			// Spring에서 지원하는 메서드
			byte[] bytes = FileCopyUtils.copyToByteArray(file);
			
			String sEncoding = new String(original_filename.getBytes("utf-8"), "ISO-8859-1");
			
			//Content-Disposition : attachment: 브라우저는 해당 Content를 처리하지 않고 , 다운로드하게 됩니다.
			response.setHeader("Content-Disposition","attachment;filename=" + sEncoding);
			
			response.setContentLength(bytes.length);
			return bytes;
			}
			
	//받은쪽지함 보낸쪽지함의 쪽지를 휴지통으로 이동
	@RequestMapping(value = "/getBasket" , method = RequestMethod.GET)
	public ModelAndView getDetail(
			@RequestParam(value = "note_num", defaultValue = "0", required = false) int note_num,
			@RequestParam(value = "note_nums", defaultValue = "0", required = false) int[] note_nums,
			@RequestParam(value = "type", defaultValue = "", required = false) String type,
			Principal principal,
			HttpServletResponse response,
			ModelAndView mv) throws IOException  {
		
		String id = principal.getName();
		
		int result = 0;
		
		//받은쪽지함 상세페지에서 삭제했을때
		if(note_num != 0) {
		
		//휴지통 note_delete(테이블의) delete_table 컬럼을 'yes'으로 변경
		result = noteService.getBasket(note_num,id,type);
		
		}else { //받은쪽지함에서 체크박스를 통해 삭제했을떄
			
			for(int notenum : note_nums) {
				logger.info("배열 쪽지 번호 : " + notenum);				
				result += noteService.getBasket(notenum,id,type);
			}
			
		}
				
		if(result == 0) {
			 logger.info("휴지통 이동 실패");
			 mv.setViewName("error/error");
			 mv.addObject("message" , "휴지통 이동 실패");		
		 }
		
		init(response);
		PrintWriter out = response.getWriter();
		out.println("<script>");
		out.println("alert('휴지통으로 이동되었습니다.')");
		if(type.equals("get")) {
		out.println("location.href='getMian'");
		}else if(type.equals("send")) {
		out.println("location.href='sendMian'");	
		}
		out.println("</script>");
		out.flush();
		
		
		return mv;
	}
			
	   //받은쪽지함 휴지통페이지 이동
		@RequestMapping(value = "/getBasketMian" , method = RequestMethod.GET)
		public ModelAndView getBasketMian(
				@RequestParam(value = "page", defaultValue = "1", required = false) int page,
				@RequestParam(value = "search_subject", defaultValue = "", required = false) String search_subject,
				Principal principal,
				ModelAndView mv)  {
			
			String id = principal.getName();
			 		 
			//id가 참조자로 되어있는 받은쪽지함 테이블의 갯수를 가져온다.
			String delete_table = "yes"; //  note_delete 테이블에서 delete_table = 'yes' 인값이 휴지통에 들어간 받은쪽지들이다.
			int listcount =  noteService.getNoteNum(id,search_subject,delete_table);
				
		    //  한 화면에 출력할 로우 갯수
		    int limit = 10; //  한 화면에 출력할 로우 갯수
				
		    //총 페이지 수
			int maxpage = (listcount + limit - 1) / limit;
						
			//현재 페이지에 보여줄 시작 페이지 수 (1, 11 , 21 등....)
			int startpage = ((page - 1) / 10) * 10 + 1 ;
						
			// 현재 페이지에 보여줄 마지막 페이지 수 (10 , 20 , 30 등....)
			int endpage = startpage + 10 - 1 ;
						
			if(endpage > maxpage) {
				endpage = maxpage;
				}
			
			// id에 해당하는 받은 쪽지 List을 가져온다. 
			List<Note> note_list = noteService.getNoteList(id,page,limit,search_subject,delete_table);
			
		        
			mv.setViewName("note/getbasket");
			mv.addObject("note_list",note_list);
			mv.addObject("page", page);
			mv.addObject("maxpage" , maxpage);
			mv.addObject("startpage" , startpage);
			mv.addObject("endpage" , endpage);
			mv.addObject("search_subject" , search_subject);			
			return mv;
		}
	
		//보낸 쪽지함 휴지통 이동
		@RequestMapping(value = "/sendBasketMian" , method = RequestMethod.GET)
		public ModelAndView sendBasketMian(
				@RequestParam(value = "page", defaultValue = "1", required = false) int page,
				@RequestParam(value = "search_subject", defaultValue = "", required = false) String search_subject,
				Principal principal,
				ModelAndView mv)  {
			
			String id = principal.getName();
			 		 
			//id가 보낸사람을 되어있는 되어있는 보낸쪽지함 테이블(note)의 갯수를 가져온다.
			String delete_table = "yes"; //  note_delete 테이블에서 delete_table = 'yes' 인값이 휴지통에 들어간 보낸쪽지들이다.
			int listcount =  noteService.sendNoteNum(id,search_subject,delete_table);
				
		    //  한 화면에 출력할 로우 갯수
		    int limit = 10; //  한 화면에 출력할 로우 갯수
				
		    //총 페이지 수
			int maxpage = (listcount + limit - 1) / limit;
						
			//현재 페이지에 보여줄 시작 페이지 수 (1, 11 , 21 등....)
			int startpage = ((page - 1) / 10) * 10 + 1 ;
						
			// 현재 페이지에 보여줄 마지막 페이지 수 (10 , 20 , 30 등....)
			int endpage = startpage + 10 - 1 ;
						
			if(endpage > maxpage) {
				endpage = maxpage;
				}
			
			// id에 해당하는 보낸 쪽지 List을 가져온다. 
			List<Note> note_list = noteService.sendNoteList(id,page,limit,search_subject,delete_table);
			
			for(Note notes : note_list) {
				// id,id,id.. 형태를 "," 을 기준으로 문자 배열로 변환시킨다. 
				String to_ids = notes.getTo_id();
				String[] to_id = to_ids.split(",");
				    //보낸 사람이 1명이 아니라면 보낸사람에 "이름 외0명" 이라고 표시한다.
					if(to_id.length != 1) {
					String name = "";
		
					//id에 해당하는 이름을 members테이블에서 가져온다.
					name += noteService.selectName(to_id[0]);			
					name += " 외"+ (to_id.length-1) + "명";
		            			
					notes.setTo_name(name);
					}else {
						notes.setTo_name(to_id[0]);	
					}
			}
		        
			mv.setViewName("note/sendbasket");
			mv.addObject("note_list",note_list);
			mv.addObject("page", page);
			mv.addObject("maxpage" , maxpage);
			mv.addObject("startpage" , startpage);
			mv.addObject("endpage" , endpage);
			mv.addObject("search_subject" , search_subject);			
			return mv;
		}
	
	
		//영구삭제
		@RequestMapping(value = "/delete" , method = RequestMethod.GET)
		public ModelAndView delete(
				@RequestParam(value = "note_num", defaultValue = "0", required = false) int note_num,
				@RequestParam(value = "note_nums", defaultValue = "0", required = false) int[] note_nums,
				@RequestParam(value = "type", defaultValue = "", required = false) String type,
				Principal principal,
				HttpServletResponse response,
				ModelAndView mv) throws IOException  {
			
			String id = principal.getName();
			
			int result = 0;
			
			//받은쪽지함 상세페지에서 삭제했을때
			if(note_num != 0) {
				
				// note(보낸쪽지테이블) 또는 note_to (받은 쪽지테이블) 의 delete_num을 가져온다.
				int delete_num = noteService.selectDeleteNums(note_num,id,type);
				
				logger.info("삭제할 delete_num :" + delete_num);
				
				//휴지통 note_delete(테이블) 삭제 -> note_delete테이블 삭제시 note(보낸쪽지테이블) 또는 note_to (받은 쪽지테이블) 이 같이 삭제  
				result = noteService.Delete(delete_num);
				
				
				
			
			}else { //받은쪽지함에서 체크박스를 통해 삭제했을떄
				
				for(int notenum : note_nums) {
					logger.info("배열 쪽지 번호 : " + notenum);	
					
					int delete_num = noteService.selectDeleteNums(notenum,id,type);
					
					logger.info("삭제할 delete_num :" + delete_num); 
					
					result = noteService.Delete(delete_num);
				}
				
			}
			
			if(result == 0) {
				 logger.info("쪽지 영구삭제 실패");
				 mv.setViewName("error/error");
				 mv.addObject("message" , "쪽지 영구삭제 실패");		
			 }
			
			init(response);
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('영구삭제되었습니다.')");
			if(type.equals("get")) {
			out.println("location.href='getBasketMian'");
			}else if(type.equals("send")) {
			out.println("location.href='sendBasketMian'");	
			}
			out.println("</script>");
			out.flush();
          
			return mv;
		}
		
		
		
		//휴지통의 쪽지를 받은쪽지함 보낸쪽지함으로 이동 (복구)
		@RequestMapping(value = "/restore" , method = RequestMethod.GET)
		public ModelAndView restore(
				@RequestParam(value = "note_num", defaultValue = "0", required = false) int note_num,
				@RequestParam(value = "type", defaultValue = "", required = false) String type,
				Principal principal,
				HttpServletResponse response,
				ModelAndView mv) throws IOException  {
			
			String id = principal.getName();
			
			int result = 0;
			
			
			//휴지통 note_delete(테이블의) delete_table 컬럼을 'no'으로 변경
			result = noteService.restore(note_num,id,type);
			
			
					
			if(result == 0) {
				 logger.info("복구 실패");
				 mv.setViewName("error/error");
				 mv.addObject("message" , "복구 실패");		
			 }
			
			init(response);
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('복구되었습니다.')");
			if(type.equals("get")) {
			out.println("location.href='getBasketMian'");
			}else if(type.equals("send")) {
			out.println("location.href='sendBasketMian'");	
			}
			out.println("</script>");
			out.flush();
			
			
			return mv;
		}
	
}
