package com.gant.myhome.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Note;
import com.gant.myhome.domain.Overtime;
import com.gant.myhome.domain.Vacation;
import com.gant.myhome.mybatis.mapper.RequestMapper;


@Service
public class RequestServicelmpl implements RequestService {


	private RequestMapper dao;
		
	@Autowired
	public RequestServicelmpl(RequestMapper dao) {
		this.dao = dao;
	}
    
	
	
	//참조자 명단 리스트
	@Override
	public List<Members> getMembersList(String id) {
		return dao.getMembersList(id);
		
	}


    // 참조자 명단 갯수
	@Override
	public int getMembersCount(String id) {
		return dao.getMembersCount(id);
	}


	@Override
	public List<Members> MemberSearchList(String search_name) {
		return  dao.MemberSearchList(search_name);
	}


	//초과근무신청서 저장 
	@Override
	public int insertOvertime(Overtime overtime) {
		return dao.insertOvertime(overtime);
	}


	//방금 저장한 초과근무신청서의 문서번호를 가져온다.
	@Override
	public int OvertimePaperNum() {
		return dao.OvertimePaperNum();
	}


	//각각의 참조자들을 overtime_condition테이블에 저장한다.
	@Override
	public int OvertimeConditionreInsert(String reference_person, int select_paper_num) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("reference_person",reference_person);
		map.put("select_paper_num",select_paper_num);
		return dao.OvertimeConditionreInsert(map);
	}


    //휴가신청서 저장
	@Override
	public int insertVacation(Vacation vacation) {
		return dao.insertVacation(vacation);
	}


	//방금 저장한 휴가신청서의 문서번호를 가져온다. 
	@Override
	public int VacationPaperNum() {
		return dao.VacationPaperNum();
	}


	//각각의 참조자들을 vacation_condition테이블에 저장한다.
	@Override
	public int VacationConditionreInsert(String reference_person, int select_paper_num) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("reference_person",reference_person);
		map.put("select_paper_num",select_paper_num);
		return dao.VacationConditionreInsert(map);
	}


	//id가 참조자로 되어있는 문서번호를 가져온다.
	@Override
	public List<Integer> getPaperNum(String id) {
		return dao.getPaperNum(id);
	}


	//문서번호에 해당하는 휴가신청서와,초과근무신청서리스트를 List<map<String,Object>>형태로 받아온다.
	@Override
	public List<Map<String, Object>> getPaperList(List<Integer> papernum_list, int page, int limit, String search_name) {	
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;	
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("papernum_list", papernum_list);
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("search_name", search_name);
		return dao.getPaperList(map);
	}


	//드롭다운으로 휴가신청서 or 초과근무신청서를 신청했을경우
	@Override
	public List<Map<String, Object>> getOnlyPaperList(List<Integer> papernum_list, int page, int limit, String table_name) {
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;	
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("papernum_list", papernum_list);
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("table_name", table_name);
		return dao.getOnlyPaperList(map);
	}


	//id에 해당하는 초과근무,휴가신청서 리스트 갯수를  가져온다
	@Override
	public int getListCount(String id, String table_name) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("table_name", table_name);
		return dao.getListCount(map);
	}


	//id가 작성자로 되어있는 문서번호를 가져온다.
	@Override
	public List<Integer> getSendPaperNum(String id) {		
		return dao.getSendPaperNum(id);
	}


	//id에가 작성자에 해당하는 휴가신청서 리스트갯수를 가져온다.
	@Override
	public int getSendListCount(String id, String table_name) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("table_name", table_name);
		return dao.getSendListCount(map);
	}


	//문서 번호와 id에 해당하는 서류 참조자 테이블에 결재상태(condition)를 가져온다.
	@Override
	public String selectCondition(String classification, int paper_num, String id) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("paper_num", paper_num);
		map.put("classification", classification);		
		return dao.selectCondition(map);
	}


	//초과근무신청서 세부사항을 가져온다.
	@Override
	public Overtime selectOvertime(int paper_num) {		
		return dao.selectOvertime(paper_num);
	}


	//List<Map<String, Object>> 형태로 참조자들의 목록을 가져온다.
	@Override
	public List<Map<String, Object>> selectReferencePersonList(int paper_num, String classification) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("classification", classification);
		map.put("paper_num", paper_num);
		return dao.selectReferencePersonList(map);
	}


	//휴가신청서 세부사항을 가져온다.
	@Override
	public Vacation selectVacation(int paper_num) {
		return dao.selectVacation(paper_num);
	}


	//id와 문서번호에 해당하는 참조자 테이블 (vacation_condition,overtime_condition)에 결재상태(condition)컬럼을
	//대기에서 승인또는 거절으로 변경한다.
	@Override
	public int updateReferencePersonCondition(int paper_num, String id, String classification, String condition) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("classification", classification);
		map.put("paper_num", paper_num);
		map.put("condition", condition);
		
		return dao.updateReferencePersonCondition(map);
	}


	//문서번호에 해당하는 참조자테이블의 결재상태를 List<String>형태로 가져온다.
	@Override
	public List<String> getConditionList(int paper_num, String classification) {		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("classification", classification);
		map.put("paper_num", paper_num);
				
		return dao.getConditionList(map);
	}


	//문서번호에 해당하는 문서테이블의 결재상태를 업데이트한다.
	@Override
	public int updateCondition(int paper_num, String condition, String classification) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("classification", classification);
		map.put("paper_num", paper_num);
		map.put("condition", condition);
		
		return dao.updateCondition(map);
	}


	//만약 휴가신청서의 경우라면 승인했던 휴가일수만큼 vacation_num테이블에서 연차갯수를 차감한다.(단 , 휴가 종류가 연차였을 경우만)	
	@Override
	public int updateVacationNum(String writer_id, int vacation_date) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("writer_id", writer_id);
		map.put("vacation_date", vacation_date);
		return dao.updateVacationNum(map);
	}


	//members 테이블에서 해당 id의 부서명과 admin권한을 가져오는 메서드. (인사과,관리자권한을 나누기 위해서)
	@Override
	public Members SelectMember(String id) {
		return dao.SelectMember(id);
	}


	//모든 문서번호를 가져온다.
	@Override
	public List<Integer> getAllPaperNum() {
		return dao.getAllPaperNum();
	}


	//모든 휴가 혹은 초과근무신청서 리스트갯수를 가져온다.
	@Override
	public int getAllListCount(String table_name) {		
		return dao.getAllListCount(table_name);
	}


	//검색어가 있다면 검색어에 맞춘 게시물 수를 구해야한다.
	@Override 
	public int getSearchListCount(String search_name) {
		return dao.getSearchListCount(search_name);
	}


	//검색어에 해당하는 members 테이블의 id을 List<String> 형태로 받아온다.
	@Override
	public List<String> getSearchId(String search_name) {
		return dao.getSearchId(search_name);
	}


	//해당 문서번호에 해당하는 문서를 삭제한다.
	@Override
	public int delete(int paper_num, String classification) {	
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("paper_num", paper_num);
		map.put("classification", classification);
		return dao.delete(map);
	}








	

    
	


	
}
