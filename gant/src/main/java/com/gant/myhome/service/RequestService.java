package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Note;
import com.gant.myhome.domain.Overtime;
import com.gant.myhome.domain.Vacation;

public interface RequestService {
    
	// 참조자 명단 리스트
	List<Members> getMembersList(String id);
    
	//참조자 명단 갯수
	int getMembersCount(String id);
    
	//검색 참조자 명단 리스트
	List<Members> MemberSearchList(String trim);
	
	//초과근무신청서 저장 
	int insertOvertime(Overtime overtime);
    
	//방금 저장한 초과근무신청서의 문서번호를 가져온다. 
	int OvertimePaperNum();
    
	//각각의 참조자들을 overtime_condition테이블에 저장한다.
	int OvertimeConditionreInsert(String reference_person, int select_paper_num);
    	
	//휴가신청서저장
	int insertVacation(Vacation vacation);
    
	//방금 저장한 휴가신청서의 문서번호를 가져온다. 
	int VacationPaperNum();

	//각각의 참조자들을 vacation_condition테이블에 저장한다.
	int VacationConditionreInsert(String reference_person, int select_paper_num);
    
	//id가 참조자로 되어있는 문서번호를 가져온다.
	List<Integer> getPaperNum(String id);
    
	//문서번호에 해당하는 휴가신청서와,초과근무신청서리스트를 List<map<String,Object>>형태로 받아온다.
	List<Map<String, Object>> getPaperList(List<Integer> papernum_list, int page, int limit, String search_name);
    
	//드롭다운으로 휴가신청서 or 초과근무신청서를 신청했을경우
	List<Map<String, Object>> getOnlyPaperList(List<Integer> papernum_list, int page, int limit, String table_name);
    
	//id에 해당하는 초과근무,휴가신청서 리스트 갯수를  가져온다
	int getListCount(String id, String table_name);
	
	//id가 작성자로 되어있는 문서번호를 가져온다.
	List<Integer> getSendPaperNum(String id);
    
	//id에가 작성자에 해당하는 휴가신청서 리스트갯수를 가져온다.
	int getSendListCount(String id, String table_name);
    
	//문서 번호와 id에 해당하는 서류 참조자 테이블에 결재상태(condition)를 가져온다.
	String selectCondition(String classification, int paper_num, String id);
    
	//초과근무신청서 세부사항을 가져온다.
	Overtime selectOvertime(int paper_num);
	
	//List<Map<String, Object>> 형태로 참조자들의 목록을 가져온다.
	List<Map<String, Object>> selectReferencePersonList(int paper_num, String classification);
    
	//휴가신청서 세부사항을 가져온다.
	Vacation selectVacation(int paper_num);
    
	//id와 문서번호에 해당하는 참조자 테이블 (vacation_condition,overtime_condition)에 결재상태(condition)컬럼을
	//대기에서 승인또는 거절으로 변경한다.
	int updateReferencePersonCondition(int paper_num, String id, String classification, String condition);
    
	//문서번호에 해당하는 참조자테이블의 결재상태를 List<String>형태로 가져온다.
	List<String> getConditionList(int paper_num, String classification);
    
	//문서번호에 해당하는 문서테이블의 결재상태를 업데이트한다.
	int updateCondition(int paper_num, String condition, String classification);
     
	//만약 휴가신청서의 경우라면 승인했던 휴가일수만큼 vacation_num테이블에서 연차갯수를 차감한다.(단 , 휴가 종류가 연차였을 경우만)	
	int updateVacationNum(String writer_id, int vacation_date);
    
	//members 테이블에서 해당 id의 부서명과 admin권한을 가져오는 메서드. (인사과,관리자권한을 나누기 위해서)
	Members SelectMember(String id);
    
	//모든 문서번호를 가져온다.
	List<Integer> getAllPaperNum();
    
	//모든 휴가 혹은 초과근무신청서 리스트갯수를 가져온다.
	int getAllListCount(String table_name);
    
	//검색어가 있다면 검색어에 맞춘 게시물 수를 구해야한다.
	int getSearchListCount(String search_name);
	
	//검색어에 해당하는 members 테이블의 id을 List<String> 형태로 받아온다.
	List<String> getSearchId(String search_name);
    
	//해당 문서번호에 해당하는 문서를 삭제한다.
	int delete(int paper_num, String classification);
    
	

	
	

	
	
    
	

}
