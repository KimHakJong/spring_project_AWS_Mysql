package com.gant.myhome.service;

import java.util.List;

import com.gant.myhome.domain.Attendance;


public interface AttService {
    
	//Vacation_num 테이블 유무 확인
	int Vacationselect(String id);

	//member 테이블에서 입사일자 가져오기
	String gethiredate(String id);
    
	//Vacation_num 테이블 insert
	void Vacation_num_insert(String id, int vacation_num);
    	
	//새로운 해에 연차 15일 추가
	int Update_vacation_num();
    
	//id에 해당하는 휴가 갯수 가져오기
	int SelectVacation_num(String id);
    
	//attendance 테이블 유무 확인 
	int Attselect(String id);
    
	//attendance 테이블 insert
	void attendance_insert(String id);
    
	//id에 해당하는 DB에 저장되어있는 정보를 가져온다.
	Attendance selectCommuteRecord(String id,String now_Day);
    
	//월요일에는 모든 사원들의 주간 총 근무시간을 리셋한다.
	int Resetwork_week();
    
	// 데이터를 넣는다. // checkbutton 을 true로 변경 // 출근버튼 비활성화
	int startTimeUpdate(Attendance att);
	
	//출퇴근을 기록한다. attendance테이블의 경우 출퇴근시간을 매번 리셋하기 때문에 출퇴근 시간을 기록하는용도로 생성
	int insert_commute_record(Attendance att);
    
	//퇴근 시간 저장 checkbutton 을 false로 변경 // 퇴근버튼 비활성화
	int endTimeUpdate(Attendance att);
	
	//출퇴근을 기록한다. attendance테이블의 경우 출퇴근시간을 매번 리셋하기 때문에 출퇴근 시간을 기록하는용도로 생성
	int Update_commute_record(String now_Day, String startTime1, String endTime,String id, String work_today);
    
	//id 에 해당하는 출퇴근 기록 갯수
	int getrecordCount(String id);
    
	//id에 해당하는 출퇴그 기록 리스트
	List<Attendance> getrecordList(int page, int limit, String id);
	
	//검색날짜에 포함되어있는 출퇴근 기록의 수 
	int getSearchCount(String date_Search, String id);
    
	//검색날짜에 포함되어있는 출퇴근 리스트
	List<Attendance> getSearchList(int page, int limit, String date_Search, String id);
    
	// id에 해당하는 DB에 저장되어있는 정보를 가져온다.
	Attendance selectAttendance(String id);
    

    
	
	
	
}
