package com.gant.myhome.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.ProjectCalendar;
import com.gant.myhome.mybatis.mapper.ProjectCalendarMapper;




@Service
public class ProjectCalendarServicelmpl implements ProjectCalendarService {

	private ProjectCalendarMapper dao;
	
	
	@Autowired
	public ProjectCalendarServicelmpl(ProjectCalendarMapper dao) {
		this.dao = dao;
	}
	
	@Override
	public int add(ProjectCalendar c) {  
		
		return dao.add(c);
	}
	
	@Override
	public String getadminid(String id) {
		
		String ad = dao.getadminid(id);
		
		return ad;
		
	}
	
	@Override
	public String gethostid(String p_no) {
		
		String host = dao.gethostid(p_no);
		
		return host;
		
	}

	@Override
	public List<ProjectCalendar> getCalList(String p_no) {
		
		return dao.getCalList(p_no);
	}

	@Override
	public int update(ProjectCalendar c) {
		return dao.update(c);
	}

	
	@Override
	public int caldelete(String id, String p_no){
		
		return dao.caldelete(id, p_no);
		
	}



	

}
