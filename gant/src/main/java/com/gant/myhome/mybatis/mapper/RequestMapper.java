package com.gant.myhome.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Overtime;
import com.gant.myhome.domain.Vacation;



/*
 Mapper 인터페이스란 매퍼 파일에 기재된 SQL을 호출하기 위한 인터페이스 입니다.
 Mybatis-Spring은 Mapper 인터페이스를 이용해서 실제 SQL 처리가 되는 클래스를 자동으로 생성합니다. 
 */

@Mapper
public interface RequestMapper {

	List<Members> getMembersList(String id);

	int getMembersCount(String id);

	List<Members> MemberSearchList(String search_name);

	int insertOvertime(Overtime overtime);

	int OvertimePaperNum();

	int OvertimeConditionreInsert(Map<String,Object> map);

	int insertVacation(Vacation vacation);

	int VacationPaperNum();

	int VacationConditionreInsert(Map<String, Object> map);

	List<Integer> getPaperNum(String id);

	List<Map<String, Object>> getPaperList(Map<String, Object> map);

	List<Map<String, Object>> getOnlyPaperList(Map<String, Object> map);

	int getListCount(Map<String, Object> map);

	List<Integer> getSendPaperNum(String id);

	int getSendListCount(Map<String, Object> map);

	String selectCondition(Map<String, Object> map);

	Overtime selectOvertime(int paper_num);

	List<Map<String, Object>> selectReferencePersonList(Map<String, Object> map);

	Vacation selectVacation(int paper_num);

	int updateReferencePersonCondition(Map<String, Object> map);

	List<String> getConditionList(Map<String, Object> map);

	int updateCondition(Map<String, Object> map);

	int updateVacationNum(Map<String, Object> map);

	Members SelectMember(String id);

	List<Integer> getAllPaperNum();

	int getAllListCount(String table_name);

	int getSearchListCount(String search_name);

	List<String> getSearchId(String search_name);

	int delete(Map<String, Object> map);



	

	
}
