package com.gant.myhome.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Attendance;




/*
 Mapper 인터페이스란 매퍼 파일에 기재된 SQL을 호출하기 위한 인터페이스 입니다.
 Mybatis-Spring은 Mapper 인터페이스를 이용해서 실제 SQL 처리가 되는 클래스를 자동으로 생성합니다. 
 */

@Mapper
public interface AttMapper {

	int Vacationselect(String id);

	String gethiredate(String id);

	void Vacation_num_insert(Map<String, Object> map);

	int Update_vacation_num();

	int SelectVacation_num(String id);

	int AttendanceSelect(String id);

	void attendance_insert(String id);

	Attendance selectCommuteRecord(Map<String, Object> map);

	int Resetwork_week();

	int startTimeUpdate(Attendance att);

	int insert_commute_record(Attendance att);

	int endTimeUpdate(Attendance att);

	int Update_commute_record(Map<String, Object> map);

	int getrecordCount(String id);

	List<Attendance> getrecordList(Map<String, Object> map);

	int getSearchCount(Map<String, Object> map);

	List<Attendance> getSearchList(Map<String, Object> map);

	Attendance selectAttendance(String id);
	
	

	
	
	
	
		
		
}
