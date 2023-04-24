package com.gant.myhome.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Calendar;
import com.gant.myhome.mybatis.mapper.CalendarMapper;



@Service
public class CalendarServiceImpl implements CalendarService {

	private CalendarMapper dao;
	
	
	@Autowired
	public CalendarServiceImpl(CalendarMapper dao) {
		this.dao = dao;
	}
	
	@Override
	public int add(Calendar c) {  
		
		return dao.add(c);
	}
	
	@Override
	public String getadminid(String id) {
		
		String ad = dao.getadminid(id);
		
		return ad;
		
	}

	@Override
	public List<Calendar> getCalList() {
		
		return dao.getCalList();
	}

	@Override
	public int update(Calendar c) {
		return dao.update(c);
	}

	
	@Override
	public int caldelete(String id) {
		return dao.caldelete(id);
		
	}



	

}
