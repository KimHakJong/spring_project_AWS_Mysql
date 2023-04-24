package com.gant.myhome.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Reservation;
import com.gant.myhome.domain.ReservationCheck;
import com.gant.myhome.domain.ReservationCount;
import com.gant.myhome.domain.ReservationItem;
import com.gant.myhome.service.MemberService;
import com.gant.myhome.service.ReservationCheckService;
import com.gant.myhome.service.ReservationCountService;
import com.gant.myhome.service.ReservationItemService;
import com.gant.myhome.service.ReservationService;

@Controller
@RequestMapping(value="/reserve")
public class ReservationController {
	
	private static final Logger logger = LoggerFactory.getLogger(ProjectController.class);

	private MemberService memberservice;
	private ReservationService reservationservice;
	private ReservationCheckService reservationcheckservice;
	private ReservationItemService reservationitemservice;
	private ReservationCountService reservationcountservice;
	
	@Autowired
	public ReservationController(MemberService memberservice, ReservationService reservationservice, 
						ReservationCheckService reservationcheckservice, ReservationItemService reservationitemservice,
						ReservationCountService reservationcountservice) {
		this.memberservice = memberservice;
		this.reservationservice = reservationservice;
		this.reservationcheckservice = reservationcheckservice;
		this.reservationitemservice = reservationitemservice;
		this.reservationcountservice = reservationcountservice;
	}
	
	
	@GetMapping(value="/main")
	public ModelAndView reserveMain(Principal userPrincipal, ModelAndView mv) {
		//관리자인지아닌지 구별하여 자원추가버튼 활성화
		String id = userPrincipal.getName();
		Members members = memberservice.getMemberInfo(id);
		mv.addObject("admin",members.getAdmin());
		
		//새로운 회원이면 하루당 예약가능 시간 설정을 위해 테이블 로우 insert
		ReservationCount result = reservationcountservice.select(id);
		if(result==null) {
			int add_count = reservationcountservice.insert(id);
			if(add_count==1) {
				mv.addObject("add_count",add_count);
				logger.info("횟수 추가성공");
			}else {
				mv.addObject("message","예약 추가 가능 활성화 실패");
				mv.setViewName("error/error");
				return mv;
			}
		}
		
		//자원종류, 자원명 불러옴 (예약화면 처음 불러올 때: 자원많은 종류가 표시)
		List<String> types = reservationitemservice.getTypeList();
			
		if(types.size()>0) {
		String first_type = types.get(0);
		List<String> resources_by_type = reservationitemservice.getResourcesByType(first_type);
		mv.addObject("types",types);
		mv.addObject("resources_by_type",resources_by_type);
		}
		mv.setViewName("reserve/reserveMain");
		
		return mv;
	}
	
	
	@ResponseBody
	@PostMapping(value="/loadResource_ajax")
	public List<String> loadResource_ajax(String type){
		List<String> resources_by_type = reservationitemservice.getResourcesByType(type);
		
		return resources_by_type;
	}
	
	@ResponseBody
	@PostMapping(value="/loadTime_ajax")
	public List<ReservationCheck> loadTime_ajax(String resource_name, String day){
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("resource_name", resource_name);
		map.put("day", day);
		
		//자원명과 날짜에 해당하는 예약된 시간을 list에 담는다.( 추가로 해당 예약자의 이름도 담음 )
		List<ReservationCheck> list = reservationcheckservice.getTime(map);
		for(ReservationCheck rs_check: list) {
			logger.info("뭐가나와유?:"+rs_check.getId());
			Members m = memberservice.getMemberInfo(rs_check.getId());
			rs_check.setName(m.getName());
		}
		return list;
	}
	
	@GetMapping(value="/insert")
	public String reserveInsert() {
		return "reserve/reserveInsert";
	}
	
	@PostMapping(value="/addResource")
	public String addResource(ReservationItem RItem, RedirectAttributes rattr, Model model) {
		int result = reservationitemservice.insert(RItem);
		if(result==1) {
			rattr.addFlashAttribute("add_item",result);
			return "redirect:main";
		}else {
			model.addAttribute("message","자원등록 실패");
			return "error/error";
		}
	}
	
	@PostMapping(value="/insertReservation")
	public ModelAndView insertReservation(Reservation rv, ModelAndView mv, RedirectAttributes rattr) {
		//시작,종료시간 값 (시간표시가 안된 데이터)
		int s_value = Integer.parseInt(rv.getStart_time());
		int e_value = Integer.parseInt(rv.getEnd_time());
		
		Map<String,Object> map = new HashMap<String,Object>();
		int use_count = e_value-s_value+1; //예약소진횟수
		
		//남아있는 횟수와 비교
		ReservationCount rv_count = reservationcountservice.select(rv.getId());
		if(rv_count.getPossible() - use_count < 0) { //예약가능횟수 부족한 경우 : 돌아가서 잔여 예약횟수 알려줌
			rattr.addFlashAttribute("lack_of_count",rv_count.getPossible());
			mv.setViewName("redirect:/reserve/main");
			return mv;
		}
		
		//예약잔여 횟수가 충분히 남아있는 경우 
		map.put("use_count", use_count);
		map.put("id", rv.getId());
		reservationcountservice.update(map); //예약차감
		
		int result = reservationservice.insert(rv); //DB에 예약 추가
		int inserted_num = reservationservice.selectRecentInsertion(); //방금 추가한 예약 번호
		logger.info("추가된 번호"+inserted_num);
		
		if(result==0) { //예약 추가 실패
			mv.addObject("message","예약 추가 실패");
			mv.setViewName("error/error");
		}else {

			//예약시간테이블에도 추가
			ReservationCheck rv_check = new ReservationCheck();
			rv_check.setNum(inserted_num);
			rv_check.setResource_name(rv.getResource_name());
			rv_check.setDay(rv.getDay());
			int result2 = 0;
			if(s_value == e_value) { //시작종료시간 같음 = 예약시간을 여러개가 아닌 하나선택
				rv_check.setReserved_time(s_value);
				result2 = reservationcheckservice.insert(rv_check); //예약시간테이블에 한 row만 추가
			}else { //시작종료시간 다름 = 예약시간 여러개 선택
				//예약 시작시간값~ 종료시간값까지 예약시간테이블에 여러row 추가
				for(int i=s_value; i<=e_value;i++) {//
					rv_check.setReserved_time(i);
					result2 = reservationcheckservice.insert(rv_check);
				}
			}
		
			if(result2==0) {
				mv.addObject("message","예약시간 등록 실패");
				mv.setViewName("error/error");
			}else {
				rattr.addFlashAttribute("add_reservation",result);
				rattr.addFlashAttribute("remain_count",rv_count.getPossible() - use_count);
				logger.info("남은개수"+(rv_count.getPossible() - use_count));
				mv.setViewName("redirect:/reserve/main");
			}
		}
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value="/modal_loadTime_ajax")
	public List<ReservationCheck> modal_loadTime_ajax(String resource_name, String day){
		Map<String,String> map = new HashMap<String,String>();
		map.put("resource_name", resource_name);
		map.put("day", day);
		List<ReservationCheck> list = reservationcheckservice.getTimeAndMaxperson(map);
		return list;
	}
	
	@GetMapping(value="/deleteReservation")
	public String deleteReservation(int num, Model model, RedirectAttributes rattr) {
		int result = reservationservice.delete(num);
		if(result==1) {
			rattr.addFlashAttribute("delete",result);
			return "redirect:/reserve/main";
		}else {
			model.addAttribute("message","예약 취소 실패");
			return "error/error";
		}
	}
	
	@ResponseBody
	@PostMapping(value="/loadDetail_ajax")
	public Map<String,Object> loadDetail_ajax(int num, 
							@RequestParam(value="id", defaultValue="", required=false) String id) {
							//예약확인 모달일 때만 id값 존재
		Reservation rs = reservationservice.selectInfo(num);
		Members m = memberservice.getMemberInfo(rs.getId());
		rs.setName(m.getName());
		
		Map<String,Object> map = new HashMap<String,Object>();
		if(!id.equals("")) {
			
		Members m2 = memberservice.getMemberInfo(id); //현재 아이디가 관리자인지 확인
		map.put("admin", m2.getAdmin());
		}
		
		map.put("obj", rs);
		return map;
	}
	
	@PostMapping(value="/updateReservation")
	public ModelAndView updateReservation(Reservation rs, int before_time, RedirectAttributes rattr, ModelAndView mv) {
		//시작,종료시간 값 (시간표시가 안된 데이터)
		int s_value = Integer.parseInt(rs.getStart_time());
		int e_value = Integer.parseInt(rs.getEnd_time());
		
		int update_count = e_value-s_value+1; //예약소진횟수
		int change_count = update_count - before_time; //수정해서 차감될 예약소진횟수
				
		//남아있는 횟수와 비교
		ReservationCount rs_count = reservationcountservice.select(rs.getId());
		if(rs_count.getPossible() - change_count < 0) { //예약가능횟수 부족한 경우 : 돌아가서 잔여 예약횟수 알려줌
			rattr.addFlashAttribute("lack_of_count",rs_count.getPossible());
			mv.setViewName("redirect:/reserve/main");
			return mv;
		}
				
		Map<String,Object> map = new HashMap<String,Object>();
				//예약잔여 횟수가 충분히 남아있는 경우 
				map.put("use_count", change_count);
				map.put("id", rs.getId());
				reservationcountservice.update(map); //예약차감
				
				int result = reservationservice.update(rs); //DB에 예약 수정
				if(result==0) { //예약 수정 실패
					mv.addObject("message","예약 수정 실패");
					mv.setViewName("error/error");
				}else {
					//예약시간테이블에도 수정
					ReservationCheck rs_check = new ReservationCheck();
					rs_check.setNum(rs.getNum());
					rs_check.setResource_name(rs.getResource_name());
					rs_check.setDay(rs.getDay());
					logger.info("check:"+rs_check.getResource_name());
					logger.info("re:"+rs.getResource_name());
					int result2 = 0;
					reservationcheckservice.delete(rs.getNum()); // 기존 예약시간 제거
					
					if(s_value == e_value) { //시작종료시간 같음 = 예약시간을 여러개가 아닌 하나선택
						rs_check.setReserved_time(s_value);
						result2 = reservationcheckservice.insert(rs_check); //예약시간테이블에 한 row만 추가
					}else { //시작종료시간 다름 = 예약시간 여러개 선택
						//예약 시작시간값~ 종료시간값까지 예약시간테이블에 여러row 추가
						for(int i=s_value; i<=e_value;i++) {//
							rs_check.setReserved_time(i);
							result2 = reservationcheckservice.insert(rs_check);
						}
					}
				
					if(result2==0) {
						mv.addObject("message","예약시간 수정 실패");
						mv.setViewName("error/error");
					}else {
						rattr.addFlashAttribute("update_reservation",result);
						rattr.addFlashAttribute("remain_count",rs_count.getPossible() - change_count);
						logger.info("남은개수"+(rs_count.getPossible() - change_count));
						mv.setViewName("redirect:/reserve/main");
					}
				}
				
				return mv;		
	}
	
	@GetMapping(value ="/mylist")
	public ModelAndView myList(Principal userPrincipal, ModelAndView mv,
							@RequestParam(value="start_day", defaultValue="", required=false) String start_day,
							@RequestParam(value="end_day", defaultValue="", required=false) String end_day,
							@RequestParam(value="page", defaultValue="1", required=false) int page) {
		
		String id = userPrincipal.getName();
		Members m = memberservice.getMemberInfo(id);
		List<Reservation> list = reservationservice.selectById(start_day, end_day, id, page);
		int count = reservationservice.selectCountById(start_day, end_day, id);
		for(Reservation rs : list) {
			rs.setName(m.getName());
			String[] name = rs.getNames().split(",");
			String ids = "";
			String profileimgs = "";
			
			//참여명단에 대한 프로필사진과 아이디를 넘겨받음
			for(int i =0; i<name.length; i++) {
				 String comma = ",";
				 Members m2 = memberservice.getMemberInfo2(name[i]);
				 if(i==name.length-1) {
					 comma = "";
				 }
				 
				 ids += m2.getId() + comma;
				 profileimgs += m2.getProfileimg() + comma;
			}
			rs.setIds(ids);
			rs.setProfileimgs(profileimgs);
			logger.info("ids는?"+rs.getIds());
			logger.info("profileimgs는?"+rs.getProfileimgs());
		}
		mv.addObject("list",list);
		mv.addObject("start_day",start_day);
		mv.addObject("end_day",end_day);
		mv.addObject("count",count);
		mv.setViewName("reserve/myList");
		
		return mv;
	}
	
	@ResponseBody
	@PostMapping(value="/mylist_ajax")
	public List<Reservation> myList_ajax(Principal userPrincipal, String start_day, String end_day, int page){
		String id = userPrincipal.getName();
		logger.info("조회시작날:"+start_day+"종료날:"+end_day+"아이디:"+id+"페이지:"+page);
		Members m = memberservice.getMemberInfo(id);
		List<Reservation> list = reservationservice.selectById(start_day, end_day, id, page);
		
		for(Reservation rs : list) {
			rs.setName(m.getName());
			String[] name = rs.getNames().split(",");
			String ids = "";
			String profileimgs = "";
			
			//참여명단에 대한 프로필사진과 아이디를 넘겨받음
			for(int i =0; i<name.length; i++) {
				 String comma = ",";
				 Members m2 = memberservice.getMemberInfo2(name[i]);
				 if(i==name.length-1) {
					 comma = "";
				 }
				 
				 ids += m2.getId() + comma;
				 profileimgs += m2.getProfileimg() + comma;
			}
			rs.setIds(ids);
			rs.setProfileimgs(profileimgs);
		}
		return list;
	}
	
	@ResponseBody
	@PostMapping(value="/rmemberdetail")
	public List<Members> rMemberDetail(String names){
		String[] name = names.split(",");
		List<Members> list = new ArrayList<Members>();
		for(int i=0; i<name.length; i++) {
			Members m = memberservice.getMemberInfo2(name[i]);
			list.add(m);
		}
		return list;
	}
	
}