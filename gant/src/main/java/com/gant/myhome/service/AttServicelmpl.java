package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Attendance;
import com.gant.myhome.mybatis.mapper.AttMapper;




@Service
public class AttServicelmpl implements AttService {

	private AttMapper dao;
		
	@Autowired
	public AttServicelmpl(AttMapper dao) {
		this.dao = dao;
	}
    
	
	//id에 해당하는 vacation_num 테이블 유무 확인 
	@Override
	public int Vacationselect(String id) {	
		return dao.Vacationselect(id);
	}

    //members 테이블에서 해당 id의 입사날짜를 가져온다. 
	@Override
	public String gethiredate(String id) {
		return dao.gethiredate(id);
	}

	//Vacation_num 테이블 insert
	@Override
	public void Vacation_num_insert(String id, int vacation_num) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("vacation_num",vacation_num);
		dao.Vacation_num_insert(map);
	}

	//새로운 해에 연차 15일 추가
	@Override
	public int Update_vacation_num() {		
		return dao.Update_vacation_num();
	}

    //id에 해당하는 휴가 갯수 가져오기
	@Override
	public int SelectVacation_num(String id) {
		return dao.SelectVacation_num(id);
	}

	//attendance 테이블 유무 확인 
	@Override
	public int Attselect(String id) {
		return dao.AttendanceSelect(id);
	}

    //attendance 테이블 insert
	@Override
	public void attendance_insert(String id) {
		dao.attendance_insert(id);
	}

	// id에 해당하는 DB에 저장되어있는 정보를 가져온다.
	@Override
	public Attendance selectCommuteRecord(String id,String now_Day) {	
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("now_Day",now_Day);				
		return dao.selectCommuteRecord(map);
	}

	//월요일에는 모든 사원들의 주간 총 근무시간을 리셋한다.
	@Override
	public int Resetwork_week() {
		return dao.Resetwork_week();
	}

	// 데이터를 넣는다. // checkbutton 을 true로 변경 // 출근버튼 비활성화
	@Override
	public int startTimeUpdate(Attendance att) {
	  return dao.startTimeUpdate(att);
	}

	//출퇴근을 기록한다. attendance테이블의 경우 출퇴근시간을 매번 리셋하기 때문에 출퇴근 시간을 기록하는용도로 생성
	@Override
	public int insert_commute_record(Attendance att) {
		return dao.insert_commute_record(att);
	}

	//퇴근 시간 저장 checkbutton 을 falsetrue로 변경 // 퇴근버튼 비활성화
	@Override
	public int endTimeUpdate(Attendance att) {
		return dao.endTimeUpdate(att);
	}

	//출퇴근을 기록한다. attendance테이블의 경우 출퇴근시간을 매번 리셋하기 때문에 출퇴근 시간을 기록하는용도로 생성
	@Override
	public int Update_commute_record(String now_Day, String startTime1, String endTime,String id,String work_today) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("now_Day",now_Day);
		map.put("startTime",startTime1);
		map.put("endTime",endTime);		
		map.put("work_today",work_today);	
		return dao.Update_commute_record(map);
	}

	//id 에 해당하는 출퇴근 기록 갯수
	@Override
	public int getrecordCount(String id) {
		return dao.getrecordCount(id);
	}

	//id에 해당하는 출퇴그 기록 리스트
	@Override
	public List<Attendance> getrecordList(int page, int limit, String id) {
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("start",startrow);
		map.put("end",endrow);
		
		return dao.getrecordList(map);
	}

	//검색날짜에 포함되어있는 출퇴근 기록의 수 
	@Override
	public int getSearchCount(String date_Search, String id) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("date_Search",date_Search);
		return dao.getSearchCount(map);
	}

	//검색날짜에 포함되어있는 출퇴근 리스트
	@Override
	public List<Attendance> getSearchList(int page, int limit, String date_Search, String id) {
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;
		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("start",startrow);
		map.put("end",endrow);
		map.put("date_Search",date_Search);
		
		return dao.getSearchList(map);
	}

	// id에 해당하는 DB에 저장되어있는 정보를 가져온다.
	@Override
	public Attendance selectAttendance(String id) {
		return dao.selectAttendance(id);
	}
    
	

    
	
	


	
}
