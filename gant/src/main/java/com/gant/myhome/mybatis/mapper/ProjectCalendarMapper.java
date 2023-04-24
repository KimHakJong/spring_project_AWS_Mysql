package com.gant.myhome.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.ProjectCalendar;



@Mapper
public interface ProjectCalendarMapper {

		
		
		public List<ProjectCalendar> getCalList(String p_no);
		
		public int add(ProjectCalendar c);
		
		public String getadminid(String id);
		
		public String gethostid(String p_no);
		
		public int update(ProjectCalendar c);

		public int caldelete(String id, String p_no);

	
}
