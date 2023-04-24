package com.gant.myhome.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Overtime;
import com.gant.myhome.domain.Vacation;
import com.gant.myhome.service.RequestService;


@Controller
@RequestMapping(value = "/request")//http://localhost:8088/myhome4/board/ 로 시작하는 주소 맴핑
public class RequestController {
	
	private static final Logger logger = LoggerFactory.getLogger(RequestController.class);
	
	private RequestService requestservice;
	
	@Autowired
	public RequestController(RequestService requestservice) {
		this.requestservice = requestservice;
	}
	
	
	//response에 PrintWriter를 사용하여 스크립트를 사기위한 메서드
	public static void init(HttpServletResponse response) {
	       response.setContentType("text/html; charset=utf-8");
	       response.setCharacterEncoding("utf-8");
	   }
	
	
	//members 테이블에서 해당 id의 부서명과 admin권한을 가져오는 메서드. (인사과,관리자권한을 나누기 위해서)
	public Members SelectMember(String id) {	        			
				return requestservice.SelectMember(id);				
		  }
	

		

	//받은 결재함 이동
	@RequestMapping(value = "/getMian" , method = RequestMethod.GET)
	public ModelAndView getmain(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "search_name", defaultValue = "", required = false) String search_name,
			@RequestParam(value = "only", defaultValue = "", required = false) String only,
			Principal principal,
			ModelAndView mv)  {
		
		String id = principal.getName();
		
		//id가 참조자로 되어있는 문서번호를 가져온다.
		List<Integer> papernum_list =  requestservice.getPaperNum(id);
		
		//개시물 갯수 구하기
		int listcount = 0;
		
		String table_name = "";
		//드롭다운으로 전체를 선택했을경우
		if(only.equals("")) {	
			listcount = papernum_list.size();				 
		}else if(only.equals("휴가신청서")) { //휴가신청서를 선택했을경우		
			table_name = "vacation";					
			//휴가신청서 리스트갯수를 가져온다.
			listcount = requestservice.getListCount(id,table_name);
					
		}else if(only.equals("초과근무신청서")) {//초과근무신청서를 선택했을경우
			
			table_name = "overtime";					
			//초과근무신청서 리스트갯수를 가져온다.
			listcount = requestservice.getListCount(id,table_name);
		}
		
		
		//검색어가 있다면 검색어에 맞춘 게시물 수를 구해야한다.
		if(!search_name.equals("")) {
			
		//검색어에 해당하는 members 테이블의 id을 List<String> 형태로 받아온다.
		List<String> id_list =  requestservice.getSearchId(search_name);
		
		int count = 0;//검색어에 해당하는 게시물수 
		
		for(String ids : id_list) {
			count += requestservice.getSearchListCount(ids);				
		}
		
		listcount = count;
			
		logger.info("검색어가 있을때 listcount = "+ listcount);
		}
		
		
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
		
		
		
		//문서번호에 해당하는 휴가신청서와,초과근무신청서리스트를 List<map<String,Object>>형태로 받아온다.
		List<Map<String, Object>> paper_list = null;
		
		//드롭다운으로 전체를 선택했을경우
		if(only.equals("")) {	
		 paper_list = requestservice.getPaperList(papernum_list,page,limit,search_name);
		 
		}else if(only.equals("휴가신청서")) { //휴가신청서를 선택했을경우
			paper_list = requestservice.getOnlyPaperList(papernum_list,page,limit,table_name);
						
		}else if(only.equals("초과근무신청서")) {//초과근무신청서를 선택했을경우
			paper_list = requestservice.getOnlyPaperList(papernum_list,page,limit,table_name);

		}
		
				
		System.out.println("paper_list =" +paper_list);	
		
		Members member = SelectMember(id);
		String department = member.getDepartment();
		String admin = member.getAdmin();
		
	    
		mv.setViewName("request/getmain");
		mv.addObject("paper_list",paper_list);
		mv.addObject("page", page);
		mv.addObject("maxpage" , maxpage);
		mv.addObject("startpage" , startpage);
		mv.addObject("endpage" , endpage);
		mv.addObject("search_name" , search_name);
		mv.addObject("only" ,only);
		mv.addObject("department" ,department);
		mv.addObject("admin" ,admin);
		return mv;
	}
	
	
	    //보낸 결재함 이동
		@RequestMapping(value = "/sendMain" , method = RequestMethod.GET)
		public ModelAndView sendMain(
				@RequestParam(value = "page", defaultValue = "1", required = false) int page,
				@RequestParam(value = "search_name", defaultValue = "", required = false) String search_name,
				@RequestParam(value = "only", defaultValue = "", required = false) String only,
				Principal principal,
				ModelAndView mv)  {
			
			String id = principal.getName();
			
			//id가 작성자로 되어있는 문서번호를 가져온다.
			List<Integer> papernum_list =  requestservice.getSendPaperNum(id);
			
			//개시물 갯수 구하기
			int listcount = 0;
			
			String table_name = "";
			//드롭다운으로 전체를 선택했을경우
			if(only.equals("")) {	
				listcount = papernum_list.size();				 
			}else if(only.equals("휴가신청서")) { //휴가신청서를 선택했을경우		
				table_name = "vacation";					
				//id에가 작성자에 해당하는 휴가신청서 리스트갯수를 가져온다.
				listcount = requestservice.getSendListCount(id,table_name);
						
			}else if(only.equals("초과근무신청서")) {//초과근무신청서를 선택했을경우				
				table_name = "overtime";					
				//id에가 작성자에 해당하는 초과근무신청서 리스트갯수를 가져온다.
				listcount = requestservice.getSendListCount(id,table_name);
			}
			
			//검색어가 있다면 검색어에 맞춘 게시물 수를 구해야한다.
			if(!search_name.equals("")) {
				
			//검색어에 해당하는 members 테이블의 id을 List<String> 형태로 받아온다.
			List<String> id_list =  requestservice.getSearchId(search_name);
			
			int count = 0;//검색어에 해당하는 게시물수 
			
			for(String ids : id_list) {
				count += requestservice.getSearchListCount(ids);				
			}
			
			listcount = count;
				
			logger.info("검색어가 있을때 listcount = "+ listcount);
			}
			
			
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
			
			
			
			//문서번호에 해당하는 휴가신청서와,초과근무신청서리스트를 List<map<String,Object>>형태로 받아온다.
			List<Map<String, Object>> paper_list = null;
			
			//드롭다운으로 전체를 선택했을경우
			if(only.equals("")) {	
			 paper_list = requestservice.getPaperList(papernum_list,page,limit,search_name);
			 
			}else if(only.equals("휴가신청서")) { //휴가신청서를 선택했을경우
				paper_list = requestservice.getOnlyPaperList(papernum_list,page,limit,table_name);
							
			}else if(only.equals("초과근무신청서")) {//초과근무신청서를 선택했을경우
				paper_list = requestservice.getOnlyPaperList(papernum_list,page,limit,table_name);

			}
			
					
			System.out.println("paper_list =" +paper_list);	
			
			Members member = SelectMember(id);
			String department = member.getDepartment();
			String admin = member.getAdmin();
			
				
			mv.setViewName("request/sendmain");
			mv.addObject("paper_list",paper_list);
			mv.addObject("page", page);
			mv.addObject("maxpage" , maxpage);
			mv.addObject("startpage" , startpage);
			mv.addObject("endpage" , endpage);
			mv.addObject("search_name" , search_name);
			mv.addObject("only" ,only);
			mv.addObject("department" ,department);
			mv.addObject("admin" ,admin);
			return mv;
		}
	
	
	
    
    // 초과근무신청서 이동
	@RequestMapping(value = "/writeOvertime" , method = RequestMethod.GET)
	public ModelAndView writeOvertime(
			Principal principal,
			ModelAndView mv
			)  {
		String id = principal.getName();
		int membercount = requestservice.getMembersCount(id);
		List<Members> memberlist = requestservice.getMembersList(id);
		
		Members member = SelectMember(id);
		String department = member.getDepartment();
		String admin = member.getAdmin();
	
		mv.setViewName("request/overtime");
		mv.addObject("memberlist",memberlist);
		mv.addObject("membercount",membercount);
		mv.addObject("department" ,department);
		mv.addObject("admin" ,admin);
		return mv;
	}
	
	
	//휴가신청서 이동
	@RequestMapping(value = "/writeVacation" , method = RequestMethod.GET)
	public ModelAndView writeVacation(
			Principal principal,
			ModelAndView mv
			)  {
		String id = principal.getName();
		int membercount = requestservice.getMembersCount(id);
		List<Members> memberlist = requestservice.getMembersList(id);
		
		Members member = SelectMember(id);
		String department = member.getDepartment();
		String admin = member.getAdmin();
	
		mv.setViewName("request/vacation");
		mv.addObject("memberlist",memberlist);
		mv.addObject("membercount",membercount);
		mv.addObject("department" ,department);
		mv.addObject("admin" ,admin);
		return mv;
	}
	
	
	//관리자 이동
		@RequestMapping(value = "/getAdmin" , method = RequestMethod.GET)
		public ModelAndView getAdmin(
				@RequestParam(value = "page", defaultValue = "1", required = false) int page,
				@RequestParam(value = "search_name", defaultValue = "", required = false) String search_name,
				@RequestParam(value = "only", defaultValue = "", required = false) String only,
				Principal principal,
				ModelAndView mv)  {
			
			String id = principal.getName();
			
			//모든 문서번호를 가져온다.
			List<Integer> papernum_list =  requestservice.getAllPaperNum();
			
						
			//개시물 갯수 구하기
			int listcount = 0;
			
			String table_name = "";
			//드롭다운으로 전체를 선택했을경우
			if(only.equals("")) {	
				listcount = papernum_list.size();				 
			}else if(only.equals("휴가신청서")) { //휴가신청서를 선택했을경우		
				table_name = "vacation";					
				//휴가신청서 리스트갯수를 가져온다.
				listcount = requestservice.getAllListCount(table_name);
						
			}else if(only.equals("초과근무신청서")) {//초과근무신청서를 선택했을경우
				
				table_name = "overtime";					
				//초과근무신청서 리스트갯수를 가져온다.
				listcount = requestservice.getAllListCount(table_name);
			}
			
			//검색어가 있다면 검색어에 맞춘 게시물 수를 구해야한다.
			if(!search_name.equals("")) {
				
			//검색어에 해당하는 members 테이블의 id을 List<String> 형태로 받아온다.
			List<String> id_list =  requestservice.getSearchId(search_name);
			
			int count = 0;//검색어에 해당하는 게시물수 
			
			for(String ids : id_list) {
				count += requestservice.getSearchListCount(ids);				
			}
			
			listcount = count;
				
			logger.info("검색어가 있을때 listcount = "+ listcount);
			}
			
			
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
			
			
			
			//문서번호에 해당하는 휴가신청서와,초과근무신청서리스트를 List<map<String,Object>>형태로 받아온다.
			List<Map<String, Object>> paper_list = null;
			
			//드롭다운으로 전체를 선택했을경우
			if(only.equals("")) {	
			 paper_list = requestservice.getPaperList(papernum_list,page,limit,search_name);
			 
			}else if(only.equals("휴가신청서")) { //휴가신청서를 선택했을경우
				paper_list = requestservice.getOnlyPaperList(papernum_list,page,limit,table_name);
							
			}else if(only.equals("초과근무신청서")) {//초과근무신청서를 선택했을경우
				paper_list = requestservice.getOnlyPaperList(papernum_list,page,limit,table_name);

			}
			
					
			System.out.println("paper_list =" +paper_list);	
			
			Members member = SelectMember(id);
			String department = member.getDepartment();
			String admin = member.getAdmin();
			
		    
			mv.setViewName("request/adminmain");
			mv.addObject("paper_list",paper_list);
			mv.addObject("page", page);
			mv.addObject("maxpage" , maxpage);
			mv.addObject("startpage" , startpage);
			mv.addObject("endpage" , endpage);
			mv.addObject("search_name" , search_name);
			mv.addObject("only" ,only);
			mv.addObject("department" ,department);
			mv.addObject("admin" ,admin);
			return mv;
		}
		
		
		
	
	//참조자 명단 검색 시 ajax
	@ResponseBody
	@RequestMapping(value = "/searchMemberList" , method = RequestMethod.GET)
	public List<Members> searchMemberList(
			ModelAndView mv,
			@RequestParam(value = "name", defaultValue = "", required = false) String search_name
			)  {
		
		List<Members> memberlist = requestservice.MemberSearchList(search_name.trim());
		   
		return memberlist;
	}
	
	//초과근무신청서 작성내용 저장  
	@RequestMapping(value = "/overtimeAction" , method = RequestMethod.POST)
	public ModelAndView overtimeAction(
			Principal principal,
			HttpServletResponse response,
			ModelAndView mv,
			Overtime overtime,
			@RequestParam(value = "start_time", defaultValue = "", required = false) String start_time,
			@RequestParam(value = "end_time", defaultValue = "", required = false) String end_time
			) throws IOException  {
		String id = principal.getName();
		overtime.setId(id);
		logger.info("초과근무시작시간 : " + start_time);
		logger.info("초과근무끝난시간 : " + end_time);
		String over_time = "";//초과근무시간 
		
		//초과근무시간 구하기
		try {
		    // ---------초과근무시간 = 초과근무 근무 종료시간 - 초가근무 시작 시간 ------------------	
			SimpleDateFormat f = new SimpleDateFormat("HH:mm", Locale.KOREA); // Locale.KOREA ->지역설정을 한국어로 해야 mon요일, tue요일 등 방지할 수 있음!
			//SimpleDateFormat class의 parse()메서드를 이용하여 String 에서 날짜 객체로 변경
			Date end = f.parse(end_time);
			Date start = f.parse(start_time);
			
			// 밀리초로 변경하여 계산
			// GMT 기준 한국 시간이 문제가 있어 -32400000ms 더해진 값이 나온다. 그래서 각 ms 값에 32400000을 더해준다. 
			//만약 종료시간의 ms가 시작시간 ms 보다 작다면 시간을 다시 입력하도록 한다. -> 종료시간보다 시작이간이 더 늦은경우
			if((start.getTime()+32400000)>(end.getTime()+32400000)) {
				init(response);
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('초과근무 시작시간과 종료시간을 다시 확인하여 주세요.')");
				out.println("history.back(-1);");
				out.println("</script>");
				out.flush();
				return null;
			}
			
			long todaywork = (end.getTime()+32400000) - (start.getTime()+32400000);
			
			//밀리초를 시간 형태로 변경			
			long hours = (todaywork / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
			long minutes = (todaywork / 1000) / 60 % 60; //밀리초를 분으로 계산		
						
			// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01)	   	    
			String th; // 문자열로 형변환 
	   	    String tm;

	   	  
	   	    if(hours<10){ 
	   	     th = "0" + hours;
	   	     }else { // 10의 자리라면 ""을 이용하여 형 변환만 해준다.
	   	    	th = ""+ hours;	 
	   	     }
	   	    if(minutes < 10){
	   	     tm = "0" + minutes;
	   	    }else {
	   	    	tm = "" + minutes;	 
	   	     }
	   	    	   	    
	   	    over_time = th + ":" + tm + ":00"; // 시:분:초
	   	    logger.info("초과근무시간 :" + over_time);
	   	    
	   	    //초과근무시간 Overtime객체에 저장 
	   	    overtime.setOver_time(over_time);
	   	    
			// ---------초과근무시간 구하기 끝------------------

			// try end
			}catch (ParseException ex) {
				  mv.setViewName("error/error");
				  mv.addObject("message" , "초과근무신청 실패입니다.");
			}catch (Exception e) {
				e.getMessage();
			} // catch end
	    
		//초과근무신청서 저장 
		int insert_result = requestservice.insertOvertime(overtime);
		
		if(insert_result == 0) {
			init(response);
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('초과근무신청서 저장실패.')");
			out.println("history.back(-1);");
			out.println("</script>");
			out.flush();
			return null;
		}
		logger.info("초과근무신청서저장 성공");
		
		//방금 저장한 초과근무신청서의 문서번호를 가져온다.
		//문서번호는 시퀀스로 저장하기 때문에 가장 큰 숫자를 가진 문서번호를 가져온다.
		int select_paper_num = requestservice.OvertimePaperNum();
		
		//참조자들 id을 배열로 만든다.
		String[] reference_person = overtime.getReference_person().split(",");
		
	   //각각의 참조자들을 overtime_condition테이블에 저장한다.
	   int insert_check = 0; //insert가 잘 되었는지 체크한다.
	   
	   for(int i=0 ; i < reference_person.length ; i++ ) {
		   
		 int result  = requestservice.OvertimeConditionreInsert(reference_person[i],select_paper_num);
		 
		 if(result == 1) {
			 insert_check++ ;
		 }
		   
	   }
	   
	   //insert_check의 값과 reference_person.length의 길이가 다르다면 overtime_condition테이블 insert실패
	   if(insert_check != reference_person.length) {
		   init(response);
		   PrintWriter out = response.getWriter();
		   out.println("<script>");
			out.println("alert('참조자 저장실패')");
			out.println("history.back(-1);");
			out.println("</script>");
			out.flush();
			return null;
	   }
	   
	   logger.info("참조자저장 성공");
	   
		mv.setViewName("redirect:sendMain");  
		return mv;
	}
	
	
	//휴가신청서 작성내용 저장  
	@RequestMapping(value = "/vacationAction" , method = RequestMethod.POST)
	public ModelAndView vacationAction(
			Principal principal,
			HttpServletResponse response,
			ModelAndView mv,
			Vacation vacation,
			@RequestParam(value = "division_direct", defaultValue = "", required = false) String division_direct,
			@RequestParam(value = "emergency_one", defaultValue = "", required = false) String emergency_one,
			@RequestParam(value = "emergency_two", defaultValue = "", required = false) String emergency_two,
			@RequestParam(value = "emergency_three", defaultValue = "", required = false) String emergency_three
				) throws IOException  {
		
			String id = principal.getName();
			vacation.setId(id);
			
			//비상연락망 저장
			String emergency =emergency_one+"-"+emergency_two+"-"+emergency_three;
			vacation.setEmergency(emergency);
			

			
			//만약 휴가 종류 선택창인 <select>에서 직접입력을 선택했다면 직접입력한 값이 휴가 종류로 들어간다.
			if(vacation.getDivision().equals("direct")) {
				vacation.setDivision(division_direct);
			}
			
			
			
			//휴가 일수 구하기
			long vacation_date = 0; //휴가일수 
			// 휴가 종료일 - 휴가 시작일 -> 휴가 일수
			try {
			 DateFormat format = new SimpleDateFormat("yyyyMMdd");

			 /* Date타입으로 변경 */
			 Date end = format.parse( vacation.getEnd_date() );
			 Date start = format.parse( vacation.getStart_date() );
			 
			 // 밀리초로 변경하여 일수 차 계산
			 long Sec = (end.getTime() - start.getTime()) / 1000; // 초
	         
			 //밀리초를 일 형태로 변경	
			 long Days = Sec / (24*60*60); // 일자수
		        

			 // 일차이 + 1일 해줘야한다. 시작일은 포함하여야하기 때문이다.			 
			 // 휴가 일수이다. 최종 휴가 일수  
			 vacation_date = Days+1; 
			 
			 logger.info("휴가 일수 = " +vacation_date);
			 
			 //만약 휴가 일수가 음수라면 history.back(-1)
			 if(0 > vacation_date) {
				 init(response);
				   PrintWriter out = response.getWriter();
				   out.println("<script>");
					out.println("alert('휴가 날짜를 다시한번 입력하여 주세요.')");
					out.println("history.back(-1);");
					out.println("</script>");
					out.flush();
					return null;
				}
			 
			 
			}catch (ParseException ex) {
				 mv.setViewName("error/error");
				 mv.addObject("message" , "휴가신청 실패입니다.");
			}catch (Exception e) {
				e.getMessage();
			} // catch end
			
			//휴가일수 저장
		    vacation.setVacation_date(Math.toIntExact(vacation_date));
			 
		    
				//휴가신청서 저장 
				int insert_result = requestservice.insertVacation(vacation);
				
				if(insert_result == 0) {
					init(response);
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('휴가신청서 저장실패.')");
					out.println("history.back(-1);");
					out.println("</script>");
					out.flush();
					return null;
				}
				logger.info("휴가신청서저장 성공");
				
				//방금 저장한 휴가신청서의 문서번호를 가져온다.
				//문서번호는 시퀀스로 저장하기 때문에 가장 큰 숫자를 가진 문서번호를 가져온다.
				int select_paper_num = requestservice.VacationPaperNum();
				
				//참조자들 id을 배열로 만든다.
				String[] reference_person = vacation.getReference_person().split(",");
				
			   //각각의 참조자들을 overtime_condition테이블에 저장한다.
			   int insert_check = 0; //insert가 잘 되었는지 체크한다.
			   
			   for(int i=0 ; i < reference_person.length ; i++ ) {
				   
				 int result  = requestservice.VacationConditionreInsert(reference_person[i],select_paper_num);
				 
				 if(result == 1) {
					 insert_check++ ;
				 }
				   
			   }
			   
			   //insert_check의 값과 reference_person.length의 길이가 다르다면 overtime_condition테이블 insert실패
			   if(insert_check != reference_person.length) {
				   init(response);
				   PrintWriter out = response.getWriter();
				   out.println("<script>");
					out.println("alert('참조자 저장실패')");
					out.println("history.back(-1);");
					out.println("</script>");
					out.flush();
					return null;
			   }
			   
			   logger.info("참조자저장 성공");
			   
		
		mv.setViewName("redirect:sendMain");  
		return mv;	
	}
	
	    //공통 상세페이지
		@RequestMapping(value = "/getDetail" , method = RequestMethod.GET)
		public ModelAndView getDetail(
				@RequestParam(value = "paper_num", required = false) int paper_num,
				@RequestParam(value = "classification", defaultValue = "", required = false) String classification,
				@RequestParam(value = "send", defaultValue = "", required = false) String send,
				@RequestParam(value = "admin_delete", defaultValue = "", required = false) String admin_delete,
				Principal principal,
				ModelAndView mv)  {
			
			String id = principal.getName();
						
			//이미 결재한 서류인지 확인하기 위한 체크
			//이미 결재한 서류는 결재 버튼이 없다.
			//문서 번호와 id에 해당하는 서류 참조자 테이블에 결재상태(condition)를 가져온다.
			String condition_check = requestservice.selectCondition(classification,paper_num,id);
			
			
			//만약 보낸메일함에서 상세보기를 클릭한다면 String send 값은 send이다.
			//만약 send값이 send라면 condition_check 값은 send으로 변경한다.
			//보낸메일함의 경우 결재를 할 수 없기때문에 버튼이 필요없다.
			if(send.equals("send")) {
				condition_check = "send";
			}
			
			
			//List<Map<String, Object>> 형태로 참조자들의 목록을 가져온다.
			 List<Map<String, Object>> reference_person_list =null;
			
			//초과근무신청서 상세보기
			if(classification.equals("초과근무신청서")) {
			
			//초과근무신청서 세부사항을 가져온다.	
			Overtime overtime = requestservice.selectOvertime(paper_num);
			
			if(overtime == null) {
			 mv.setViewName("error/error");
			 mv.addObject("message" , "초과근무 세부사항가져오기 실패.");
			}
			
			//List<Map<String, Object>> 형태로 참조자들의 목록을 가져온다.
			reference_person_list = requestservice.selectReferencePersonList(paper_num,classification);
			
			  mv.setViewName("request/overtimeDetail");
			  
			  //근무시간의 00:00:00 형태를 00시간00분 형태로 변경
			  String[] over_time = overtime.getOver_time().split(":");
			  String new_over_time = over_time[0]+"시간 "+over_time[1] +"분";
			  overtime.setOver_time(new_over_time);
			  
			  //근무날짜 00000000 형태를 0000/00/00형태로 변경
			  String overtime_date = overtime.getOvertime_date();
			  String new_overtime_date = overtime_date.substring(0, 4) + "/" + overtime_date.substring(4, 6) + "/" + overtime_date.substring(6, 8);
			  overtime.setOvertime_date(new_overtime_date);
			  
			  mv.addObject("overtime",overtime);
			}else if(classification.equals("휴가신청서")) { // 휴가신청서 상세보기
				
				//휴가신청서 세부사항을 가져온다.	
				Vacation vacation = requestservice.selectVacation(paper_num);
				
				if(vacation == null) {
				 mv.setViewName("error/error");
				 mv.addObject("message" , "휴가신청서 상세보기 실패.");
				}
					
				//List<Map<String, Object>> 형태로 참조자들의 목록을 가져온다.
				reference_person_list = requestservice.selectReferencePersonList(paper_num,classification);
				
				//휴가 시작일 종료일 00000000 형태를 0000/00/00형태로 변경
				String start_date =  vacation.getStart_date();
				String new_start_date = start_date.substring(0, 4) + "/" + start_date.substring(4, 6) + "/" + start_date.substring(6, 8);
				vacation.setStart_date(new_start_date);
				
				String end_date =  vacation.getEnd_date();
				String new_end_date = end_date.substring(0, 4) + "/" + end_date.substring(4, 6) + "/" + end_date.substring(6, 8);
				vacation.setEnd_date(new_end_date);
				
			  mv.setViewName("request/vacationDetail");	
			  mv.addObject("vacation",vacation);
			}
			
			mv.addObject("reference_person_list",reference_person_list);
			mv.addObject("condition_check",condition_check);
			mv.addObject("admin_delete",admin_delete);
			return mv;
		}
		
		
		//승인 혹은 거절버튼을 눌렀을때 
		//받은 결재함 이동
		@RequestMapping(value = "/approval" , method = RequestMethod.GET)
		public ModelAndView approval(
				HttpServletResponse response,
				@RequestParam(value = "paper_num", defaultValue = "0", required = false) int paper_num,
				@RequestParam(value = "classification", defaultValue = "", required = false) String classification,
				@RequestParam(value = "condition", defaultValue = "", required = false) String condition,
				@RequestParam(value = "writer_id", defaultValue = "1", required = false) String writer_id,
				@RequestParam(value = "division", defaultValue = "", required = false) String division, //휴가종류
				@RequestParam(value = "vacation_date", defaultValue = "0", required = false) int vacation_date, //휴가갯수				
				Principal principal,
				ModelAndView mv) throws IOException  {
			
			String id = principal.getName();
			 
			//승인을 클릭했을때
			if(condition.equals("approval")) {
				
				condition = "승인";
				
				//id와 문서번호에 해당하는 참조자 테이블 (vacation_condition,overtime_condition)에 결재상태(condition)컬럼을
				//대기에서 승인으로 변경한다.
				int result = requestservice.updateReferencePersonCondition(paper_num,id,classification,condition);
				
				if(result == 0) {
					 mv.setViewName("error/error");
					 mv.addObject("message" , "승인 실패");
					 logger.info("참조자테이블 업데이트 실패");
				}
				
				logger.info("참조자테이블 업데이트 성공");
				
				//문서번호(paper_num)에 해당하는 참조자 테이블들의 결재상태를 확인한다. 만약 모두 승인이라면 
				//문서테이블의 결재상태를 승인으로 변경한다.
				//만약 하나라도 거절 혹은 대기가 있다면 업데이트 하지 않는다.
				
				//문서번호에 해당하는 참조자테이블의 결재상태를 List<String>형태로 가져온다.
				List<String> condition_list = requestservice.getConditionList(paper_num,classification);
				
				if(condition_list.size() == 0) {
					 mv.setViewName("error/error");
					 mv.addObject("message" , "승인 실패");
					 logger.info("참조자테이블 결재상태 가져오기 실패");
				}
				
				//참조자테이블에서 승인이 나오면 +1을 한다.
				int check_conditions = 0;
				
				for (String conditions : condition_list) {
					 
			          if(conditions.equals("승인")) {
			        	  check_conditions++;
			          }			        
				}
				
				
				//만약 condition_list.size() 와 check_conditions의 값이 같다면 문서번호에 해당하는 문서테이블의
				//결재상태를 승인으로 변경한다. (참조자 모두가 승인을 해야 문서승인이 된다)
				if(condition_list.size() == check_conditions) {
					
				int result2 = requestservice.updateCondition(paper_num,condition,classification);					
				
						if(result2 == 0) {
							 mv.setViewName("error/error");
							 mv.addObject("message" , "승인 실패");
							 logger.info("문서테이블 업데이트 실패");
						}
						
						logger.info("문서테이블 결재상태 승인 성공");
					
						//만약 휴가신청서의 경우라면 승인했던 휴가일수만큼 vacation_num테이블에서 연차갯수를 차감한다.(단 , 휴가 종류가 연차였을 경우만)	
						if(division.equals("연차")) {
							int result3 = requestservice.updateVacationNum(writer_id,vacation_date);
							
							if(result3 == 0) {
								 mv.setViewName("error/error");
								 mv.addObject("message" , "휴가업데이트 실패");
								 logger.info("휴가 업데이트 실패");
							}
						}
			
				}
				
				init(response);
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('승인처리되었습니다.')");
				out.println("history.back(-1);");
				out.println("</script>");
				out.flush();
				return null;
				
	
			}else if(condition.equals("refusal")) {//거절을 클릭했을 때
				
				condition = "거절";
				
				//id와 문서번호에 해당하는 참조자 테이블 (vacation_condition,overtime_condition)에 결재상태(condition)컬럼을
				//대기에서 거절으로 변경한다.
				int result = requestservice.updateReferencePersonCondition(paper_num,id,classification,condition);
				
				if(result == 0) {
					 mv.setViewName("error/error");
					 mv.addObject("message" , "승인 실패");
					 logger.info("참조자테이블 업데이트 실패");
				}
				
				logger.info("참조자테이블 업데이트 성공");
				
				//문서의경우 참조자가 한명이라도 거절을 클릭했다면 결재상태는 거절이된다.
				int result2 = requestservice.updateCondition(paper_num,condition,classification);					
				
				if(result2 == 0) {
					 mv.setViewName("error/error");
					 mv.addObject("message" , "승인 실패");
					 logger.info("문서테이블 업데이트 실패");
				}
				
				  logger.info("문서테이블 결재상태 승인 성공");
				  
				    init(response);
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('거절처리되었습니다.')");
					out.println("history.back(-1);");
					out.println("</script>");
					out.flush();
					return null;
				  
				  
			}
			
			
			
			return mv;
		}
	
		
				//문서삭제
				@RequestMapping(value = "/delete" , method = RequestMethod.GET)
				public ModelAndView delete(
						HttpServletResponse response,
						@RequestParam(value = "paper_num", defaultValue = "0", required = false) int paper_num,
						@RequestParam(value = "classification", defaultValue = "", required = false) String classification,												
						ModelAndView mv) throws IOException {
					
					int result = requestservice.delete(paper_num,classification);
					
					  if(result == 1) {
					    init(response);
						PrintWriter out = response.getWriter();
						out.println("<script>");
						out.println("alert('삭제처리되었습니다.')");
						out.println("location.href='getAdmin'");
						out.println("</script>");
						out.flush();
						return null;
					}
					  mv.setViewName("error/error");
					 mv.addObject("message" , "문서 삭제에 실패하였습니다.");
					 logger.info("문서삭제 실패");
					return mv;
				}
	
	
	
	
	
	
	
	
	
	
}
