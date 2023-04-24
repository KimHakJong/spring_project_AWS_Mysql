package com.gant.myhome.mybatis.mapper;


import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Members;

@Mapper
public interface MembersMapper {

	public Members idCheck(String id);
	 
	public int insert(Members m);

	public int passUpdate(Members m);
	
	public int getMembersCount(HashMap<String, String> map);

	public List<Members> getMembersList(HashMap<String, Object> map);

	public Members isAdminHuman(String id);

	public List<String> selectByDname(String department);

	public Members findIdCheck(String name);

	public Members findPassCheck(String id);

	public Members getMemberInfo(String id);

	public String checkCommute(String id);

	public int delete(String listid);

	public List<Members> getMembersList_ajax();

	public List<Members> getSearchMembersList_ajax(String name);

	public Members getMemberInfo2(String name);


	 
}
