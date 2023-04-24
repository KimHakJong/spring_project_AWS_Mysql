package com.gant.myhome.service;

import java.util.List;

import com.gant.myhome.domain.Members;

public interface MemberService {

	public int idCheck(String id);
	 
	public int insert(Members m);

	public int passUpdate(Members m);
	
	public String findIdCheck(Members m);
	
	public String findPassCheck(Members members);

	public int getMembersCount(String searchfield, String searchword);

	public List<Members> getMembersList(String searchfield, String searchword, int page, int limit);

	public String isAdminHuman(String id);

	public String selectByDname(String department);

	public Members getMemberInfo(String id);

	public String checkCommute(String id);

	public int delete(String listid);

	public List<Members> getMembersList_ajax();

	public List<Members> getSearchMembersList_ajax(String name);

	public Members getMemberInfo2(String name);

	
}
