package com.gant.myhome.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Calendar;

@Mapper
public interface CalendarMapper {

		
		
		public List<Calendar> getCalList();
			   
		
			   
		public String getadminid(String id);
				
		public int update(Calendar c);

		public int add(Calendar c);
		
		public int caldelete(String id);




}
