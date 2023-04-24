package com.gant.myhome.service;



import java.util.List;

import com.gant.myhome.domain.Calendar;


public interface CalendarService {
	
	public int add(Calendar c);
		
	public List<Calendar> getCalList();
		   
	
		   
	public String getadminid(String id);
			
	public int update(Calendar c);
	
	public int caldelete(String id);
	
}
