package com.gant.myhome.service;



import java.util.List;

import com.gant.myhome.domain.ProjectCalendar;


public interface ProjectCalendarService {
	
	public int add(ProjectCalendar c);
		
	public List<ProjectCalendar> getCalList(String p_no);
			   
	public String getadminid(String id);
	
	
			
	public int update(ProjectCalendar c);
	
	

	public String gethostid(String p_no);

	public int caldelete(String id, String p_no);
	
}
