package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Members;
import com.gant.myhome.mybatis.mapper.MembersMapper;

@Service
public class MemberServicelmpl implements MemberService {

	private MembersMapper dao;
	
	
	@Autowired
	public MemberServicelmpl(MembersMapper dao) {
		this.dao = dao;
	}
	
	@Override
	public int idCheck(String id) {
		Members member = dao.idCheck(id);
		return (member==null) ? 0 : 1 ;  //0은 아이디가 존재하지 않는경우
	                                      //1은 아이디가 존재하는 경우
	} 

	@Override
	public int insert(Members m) {  
		return dao.insert(m);
	}

	@Override
	public String findIdCheck(Members m) {
		Members member = dao.findIdCheck(m);
		if(member==null) { // 이름에 대한 정보가 없음
			return "";
		}else {
			if (member.getEmail().equals(m.getEmail())) {
				return member.getId();
			}else {
				return "noemail";
			}
		}
	}
	
	@Override
	public String findPassCheck(Members members) {
		Members m = dao.findPassCheck(members.getId());
		if(m==null) {
			return "noid";
		}else {
			if(m.getName().equals(members.getName()) && m.getEmail().equals(members.getEmail())) {
				return m.getPassword();
			}else if (m.getName().equals(members.getName()) && !m.getEmail().equals(members.getEmail())) {
				return "noemail";
			}else {
				return "noname";
			}
		}
	}

	@Override
	public int passUpdate(Members m) {
		return dao.passUpdate(m);
	}
	
	@Override
	public int getMembersCount(String searchfield, String searchword) {
		HashMap<String,String> map = new HashMap<String,String>();
		if(!searchfield.equals("")) {
			map.put("searchfield", searchfield);
			map.put("searchword", searchword);
		}
		
		return dao.getMembersCount(map);
	}

	@Override
	public List<Members> getMembersList(String searchfield, String searchword, int page, int limit) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		int startrow = (page-1)*limit+1;
		int endrow = startrow+limit-1;
		
		if(!searchfield.equals("")) {
			map.put("searchfield", searchfield);
			map.put("searchword",searchword);
		}
		
		map.put("start", startrow);
		map.put("end", endrow);
		
		return dao.getMembersList(map);
	}

	@Override
	public String isAdminHuman(String id) {
		Members m = dao.isAdminHuman(id);
		if(m.getAdmin().equals("true") || m.getDepartment().equals("인사부")) {
			return "true";
		}else {
			return "false";
		}
	}

	@Override
	public String selectByDname(String department) {
		List<String> list = dao.selectByDname(department);
		
		String names ="";
		for(String name : list) {
			names += name + ",";
		}
		return names;
	}

	@Override
	public Members getMemberInfo(String id) {
		return dao.getMemberInfo(id);
	}

	@Override
	public String checkCommute(String id) {
		return dao.checkCommute(id);
	}

	@Override
	public int delete(String listid) {
		return dao.delete(listid);
	}

	@Override
	public List<Members> getMembersList_ajax() {
		return dao.getMembersList_ajax();
	}

	@Override
	public List<Members> getSearchMembersList_ajax(String name) {
		return dao.getSearchMembersList_ajax(name);
	}

	@Override
	public Members getMemberInfo2(String name) {
		return dao.getMemberInfo2(name);
	}



	

}
