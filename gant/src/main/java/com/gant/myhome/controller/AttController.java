package com.gant.myhome.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
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

import com.gant.myhome.domain.Attendance;
import com.gant.myhome.service.AttService;





@Controller
@RequestMapping(value = "/att")//http://localhost:8088/myhome4/board/ 로 시작하는 주소 맴핑
public class AttController {
	
	private static final Logger logger = LoggerFactory.getLogger(AttController.class);
	
	private AttService attService;
	
	@Autowired
	public AttController(AttService attService) {
		this.attService = attService;
	}
	
	    //response에 PrintWriter를 사용하여 스크립트를 사기위한 메서드
		public static void init(HttpServletResponse response) {
	        response.setContentType("text/html; charset=utf-8");
	        response.setCharacterEncoding("utf-8");
	    }
	
	
	@RequestMapping(value = "/main" , method = RequestMethod.GET)
	public ModelAndView main(
			Principal principal,
			ModelAndView mv)  {
		
		 String id = principal.getName();
		 Attendance att = new Attendance();
		 
		    //휴가 갯수 데이터 가져오기
			//selectVacation == 0 // DB에 id에 해당하는 vacation_num 테이블이 없음을 뜻한다. ->insert
			// select == 1 // 기존에 데이터를 가져온다. -> 
			int selectVacation =  attService.Vacationselect(id);
			
			// 현재 날짜/시간 // 연차의 갯수를 정하기 위해 현재 날짜를 가져온다. 또한 1월1일이 되면 연차가 리셋된다.
	        Date now = new Date();
	        // 포맷팅 정의
			SimpleDateFormat Day = new SimpleDateFormat("yyyyMMdd");
			 // 포맷팅 적용
			String now_Day = Day.format(now); // 현재 년월일이다.
			
			
			//현재 년도구하기
			String now_year = now_Day.substring(0,4);
					
			String hiredate =  attService.gethiredate(id); // member테이블에서 입사일을 가져온다.
			
			String hiredate_year = hiredate.substring(0,4); // 년도만 가져오기
			
			int vacation_num; // 휴가 갯수
			if(selectVacation == 0 ) { // DB에 id에 해당하는 데이터가 없음을 뜻한다. ->insert

					//입사년도와 현재 년도가 같다면 연차는 1달에 1개만 적용이 될것이다. 아니라면 15개 적용
					if(hiredate_year.equals(now_year)) {
						String hiredate_month_day = hiredate.substring(4); // 입사년 월/일 가져오기

						int hiredate_month =Integer.parseInt(hiredate.substring(4,6)); //월가져오기

							  //만약 입사일이 1월1일이면 월차는 그 달을 포함하여 계산하여준다.
							if(hiredate_month_day.equals("0101")) {
								vacation_num = 12-hiredate_month+1; // 1년에12달이기 때문에 12번에서 입사달을 빼주고 그 달은 포함시키기 때문에 +1을 해준다.
							}else {
								vacation_num = 12-hiredate_month; //입사일이 01월01일이 아니라면 입사 달은 연차에서 뺀다.
							}
						
						attService.Vacation_num_insert(id,vacation_num);	// 휴가 날짜를 insert한다.
						mv.addObject("vacation_num",vacation_num); //휴가갯수를 attmain.jsp에 넘겨준다.
					}else {
						attService.Vacation_num_insert(id,15);	// 입사년도와 현재 년도가 다르다면 휴가는 15개이다.
						mv.addObject("vacation_num","15");// 휴가 15개로 넘겨준다.
					}
				
				
			}else if(selectVacation == 1) {  // DB에 id에 해당하는 휴가테이블 데이터가 있을때
					   
				vacation_num = attService.SelectVacation_num(id);
				
				mv.addObject("vacation_num",vacation_num); //DB에 저장되어있는 휴가 갯수를 보낸다.
			}
			
	
			// select == 0 // attendance DB에 id에 해당하는 데이터가 없음을 뜻한다. ->insert
			// select == 1 // 기존에 데이터를 가져온다. -> getselect()	
					int select =  attService.Attselect(id);
					if(select == 0) {
						attService.attendance_insert(id);	
						mv.addObject("work_week","00:00:00");
						mv.addObject("checkbutton","false");
						mv.addObject("work_week_hours","00");
					}else if(select == 1) {
						att = attService.selectAttendance(id); // id에 해당하는 DB에 저장되어있는 정보를 가져온다.
						mv.addObject("work_week",att.getWork_week()); // 월요일이 아니라면 기존의 주간 총 근무시간을 가져온다.
					    mv.addObject("work_week_hours",att.getWork_week().split(":")[0]);
						mv.addObject("checkbutton",att.getCheckbutton()); // 출/퇴근 버튼 활성화 비활성화를 위한 값 
					}
			
					mv.setViewName("att/attmain");
					mv.addObject("id",id);
		return mv;
	}
   
	
	@RequestMapping(value = "/TimeUpdate" , method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> TimeUpdate(
			@RequestParam(value = "startTime",required = false) String startTime,
			@RequestParam(value = "checkbutton",required = false) String checkbutton,
			@RequestParam(value = "endTime",required = false) String endTime,
			@RequestParam(value = "work_week",required = false) String work_week,
			Principal principal,
			HttpServletResponse response
			) throws IOException  {
		String id = principal.getName();
		Map<String,Object> map = new HashMap<String, Object>();
        Attendance att = null;
		
		if(checkbutton.equals("startbutton")) { // start버튼 클릭시 수행 
		
		 	 att = new Attendance();
			 att.setId(id);
			 att.setStartTime(startTime);
			 
			 int result = attService.startTimeUpdate(att); // 데이터를 넣는다. // checkbutton 을 false로 변경 // 출근버튼 비활성화
			 int result2 = attService.insert_commute_record(att); //출퇴근을 기록한다. attendance테이블의 경우 출퇴근시간을 매번 리셋하기 때문에 출퇴근 시간을 기록하는용도로 생성
			 
			 if(result == 0 || result2 == 0){
				 logger.info("출근등록실패");
				    init(response);
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('출근등록 실패')");
					out.println("</script>");
					out.flush();
					return null;  
			 }

			 
			 map.put("success","출근등록되었습니다.");
			 
			
		}else if(checkbutton.equals("endbutton")) { // 퇴근버튼
			logger.info("퇴근시간:"+endTime);
			logger.info("업데이트 전 주간 총 근무시간:"+work_week);
			
			//오늘 날짜 구하기
			Date now = new Date();
	        // 포맷팅 정의
			SimpleDateFormat Day = new SimpleDateFormat("yyyyMMdd");
			 // 포맷팅 적용
			
			// 현재 년월일.
			String now_Day = Day.format(now); 
			
			
			att = new Attendance(); // DAO에서 가져온 데이터 저장 
			att = attService.selectCommuteRecord(id,now_Day);  // select을 이용하여 출근시간을 가져온다.->= 하루 총 근무시간 = 퇴근시간 - 출근시간 
			String startTime1 = att.getStartTime(); // 출근시간 
			
			//만약 현재날짜에 출근시간이 없다면 출근시간은 00:00:00으로 설정해준다.
			if(startTime1.equals("") || startTime1 == null) {
				startTime1 = "00:00:00";
			}
			
			logger.info("출근시간:"+startTime1);
			
			try {
				
		    // ---------하루근무시간 구하기------------------	
			SimpleDateFormat f = new SimpleDateFormat("HH:mm:ss", Locale.KOREA); // Locale.KOREA ->지역설정을 한국어로 해야 mon요일, tue요일 등 방지할 수 있음!
			//SimpleDateFormat class의parse() 메서드를 이용하여   String 에서 날짜 객체로 변경
			Date end = f.parse(endTime);
			Date start = f.parse(startTime1);
			// 밀리초로 변경하여 계산 // GMT 기준 한국 시간이 문제가 있어 -32400000ms가더해진 값이 나온다. 그래서 각 ms 값에 32400000을 더해준다. 
			long todaywork = (end.getTime()+32400000) - (start.getTime()+32400000);
			
			//만약 당일에 퇴근버튼을 클릭하지 않고 다음날 퇴근버튼을 클릭했다면 출근시간보다 퇴근시간이 빨라 ms가 음수 (-) 형태로 나올 가능성이 있다.
			//또한 오늘날짜와 출근 날짜가 다르다면 그것또한 퇴근버튼을 클릭하지 않은것이다. 이럴때는 퇴근날짜를 클릭하지 않은 날은 0시간으로 누적되게 한다.
			
			//출근을 클릭했을때 년 월일
			String last_Work_date = att.getWork_date();
			
			//만약 현재날짜에 출근날짜가 없다면 출근날짜는은 00000000으로 설정해준다.
			if(last_Work_date.equals("") || last_Work_date == null) {
				startTime1 = "00000000";
			}
						
			// 퇴근을 클릭했을때 날짜가 다르다면 하루 근무시간은 0으로 한다.
			if(!last_Work_date.equals(now_Day)) {
				todaywork = 0;
			}
			
			long hours = (todaywork / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
			long minutes = (todaywork / 1000) / 60 % 60; //밀리초를 분으로 계산
			long seconds = (todaywork / 1000) % 60; //밀리초를 초로 계산			
			
			
			// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01)
	   	    
			String th; // 문자열로 형변환 
	   	    String tm;
	   	    String ts;
	   	  
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
	   	    if(seconds < 10){
	   	     ts = "0" + seconds;
	   	    }else {
	   	    ts = "" + seconds;	 
		   	   }
	   	      
	   	    
	        String work_today = th + ":" + tm + ":" + ts; // 시:분:초
			System.out.println("하루근무시간 :" + work_today);
			
			// ---------하루근무시간 구하기 끝------------------
			
			
	       // --------- 주간 총 근무시간시간 = 기존의 주간 총 근무시간시간 + 하루근무시간 구하기------------------
			
			SimpleDateFormat t = new SimpleDateFormat("HH:mm:ss", Locale.KOREA); // Locale.KOREA ->지역설정을 한국어로 해야 mon요일, tue요일 등 방지할 수 있음!
			//SimpleDateFormat class의parse() 메서드를 이용하여   String 에서 날짜 객체로 변경
			Date week = t.parse(work_week); // 누적된 주간 총 근무시간
			// 밀리초로 변경하여 계산 // GMT 기준 한국 시간이 문제가 있어 -32400000ms가더해진 값이 나온다. 그래서 각 ms 값에 32400000을 더해준다. 
			long weekwork = (week.getTime()+32400000) + todaywork;
			
			
			//밀리초를 시간 형태로 변경 00:00:00
			hours = (weekwork / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
			minutes = (weekwork / 1000) / 60 % 60; //밀리초를 분으로 계산
			seconds = (weekwork / 1000) % 60; //밀리초를 초로 계산
			
			// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01) 
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
	   	    if(seconds < 10){
	   	     ts = "0" + seconds;
	   	    }else {
	   	    ts = "" + seconds;	 
		   	   }
	   	      
	        String new_work_week = th + ":" + tm + ":" + ts; // 시:분:초
			System.out.println("주간 총 근무시간+하루근무시간 :" + new_work_week);
			
			// ---------주간 총 근무시간시간 + 하루근무시간 구하기 끝------------------
			
			
			// ---------초과근무시간 구하기 ------------------
			
			//todaywork = 하루 총 근무시간을 밀리초로 나타낸 값이다. 9시간 = 32400000 ms 이다 점심시간을 포함하여 9이상 근무시 초가근무 시간이 들어간다.
			String overTime; // 초가 근무시간
			if(todaywork >= 32400000) {
				long over = todaywork - 32400000;
				
				//밀리초를 시간 형태로 변경 00:00:00				                                       
				hours = (over / 1000) / 60 / 60 % 24; //밀리초를 시간으로 계산
				minutes = (over / 1000) / 60 % 60; //밀리초를 분으로 계산
				seconds = (over / 1000) % 60; //밀리초를 초로 계산;

				// 시간,분,초 가 10미만이면 앞에 0이붙어야한다.(01:01:01)
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
		   	    if(seconds < 10){
		   	     ts = "0" + seconds;
		   	    }else {
		   	    ts = "" + seconds;	 
			   	   }
		   	      
		        overTime = th + ":" + tm + ":" + ts; // 시:분:초
		        logger.info("초가 근무시간 :" + overTime);	
			}else {
				overTime = "00:00:00";
				logger.info("초가 근무시간 :" + overTime);
			}
			
			// ---------초과근무시간 구하기 끝 ------------------
			
			
		 	 att = new Attendance();
		 	 att.setId(id);
			 att.setEndTime(endTime);
			 att.setWork_today(work_today);//work_week
			 att.setWork_week(new_work_week);
			 att.setOverTime(overTime);
			 
			 int result = attService.endTimeUpdate(att); // 데이터를 넣는다.
			 
			 //출근을 클릭했을때와 퇴근을 클릭했을때 날짜가 다르다면 commute_record(출퇴근 기록 테이블)에 퇴근 기록을 남기지 않는다.
			 if(last_Work_date.equals(now_Day)){
				 int result2 = attService.Update_commute_record(now_Day,startTime1,endTime,id,work_today); //출퇴근을 기록한다. attendance테이블의 경우 출퇴근시간을 매번 리셋하기 때문에 출퇴근 시간을 기록하는용도로 생성	 
			 
				 if(result2 == 0){
					 logger.info("퇴근기록 등록실패");
					    init(response);
						PrintWriter out = response.getWriter();
						out.println("<script>");
						out.println("alert('퇴근기록등록 실패')");
						out.println("</script>");
						out.flush();
						return null;  
				 }

			 }
			 
          			 
			 if(result == 0){
				 logger.info("퇴근등록실패");
				    init(response);
					PrintWriter out = response.getWriter();
					out.println("<script>");
					out.println("alert('퇴근등록 실패')");
					out.println("</script>");
					out.flush();
					return null;  
			 }

			 att = attService.selectAttendance(id);  // select을 이용하여 주간 총 근무시간 , 초과근무시간, 하루 총 근무시간을 가져온다.
			 
			 map.put("overTime",att.getOverTime());
			 map.put("work_today",att.getWork_today());
			 map.put("work_week",att.getWork_week());
			 map.put("work_week_hours",att.getWork_week().split(":")[0]);
			 
			
		   // try end
			}catch (ParseException ex) {
				ex.getMessage();
				logger.info("근무시간 구하기 실패입니다." );
			}catch (Exception e) {
				e.getMessage();
			} // catch end
	
		}//else if(checkbutton.equals("endbutton"))
		
		return map;
	}
	
	//근태기록 클릭 시
	@RequestMapping(value = "/commute_record" , method = RequestMethod.GET)
	public ModelAndView boardlist(
			@RequestParam(value = "page", defaultValue = "1", required = false) int page,
			@RequestParam(value = "Date_Search", defaultValue = "", required = false) String Date_Search,
			ModelAndView mv,
			Principal principal) {
		
		String id = principal.getName();
		
		List<Attendance> recordlist = new ArrayList<Attendance>();
			
		int limit = 5; //  한 화면에 출력할 로우 갯수
		
		//개시물 갯수
		int recordcount = 0 ; 
		
		
		//검색어가 없는경우
        if(Date_Search == null || Date_Search.trim().equals("")) {	
        	
        	//총 리스트 수를 받아옵니다.
        	recordcount = attService.getrecordCount(id);
			
			//리스트를 받아옵니다.
			recordlist = attService.getrecordList(page,limit,id);
				
		}else {// 검색어가있는경우

			//검색날짜에 포함되어있는 출퇴근 기록의 수  
			recordcount = attService.getSearchCount(Date_Search,id);
						
			//검색날짜에 포함되어있는 출퇴근 리스트
			recordlist = attService.getSearchList(page,limit,Date_Search,id);
			
		}
		
        
		//총 페이지 수
		int maxpage = (recordcount + limit - 1) / limit;
		
		//현재 페이지에 보여줄 시작 페이지 수 (1, 11 , 21 등....)
		int startpage = ((page - 1) / 10) * 10 + 1 ;
		
		// 현재 페이지에 보여줄 마지막 페이지 수 (10 , 20 , 30 등....)
		int endpage = startpage + 10 - 1 ;
		
		if(endpage > maxpage) {
			endpage = maxpage;
		}
		

		mv.setViewName("att/commute_record");
		mv.addObject("page", page);
		mv.addObject("maxpage" , maxpage);
		mv.addObject("startpage" , startpage);
		mv.addObject("endpage" , endpage);
		mv.addObject("recordcount" , recordcount);
		mv.addObject("recordlist" , recordlist);
		mv.addObject("limit" , limit);
		
		return mv;
	}
	
}
