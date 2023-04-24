package com.gant.myhome.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.ReservationCount;
import com.gant.myhome.mybatis.mapper.ReservationCountMapper;

@Service
public class ReservationCountServiceImpl implements ReservationCountService {
	
	private ReservationCountMapper dao;

	@Autowired
	public ReservationCountServiceImpl(ReservationCountMapper dao) {
		this.dao = dao;
	}
	
	@Override
	public ReservationCount select(String id) {
		return dao.select(id);
	}
	
	@Override
	public int insert(String id) {
		return dao.insert(id);
	}
	
	@Override
	public int resetCount() {
		return dao.resetCount();
	}

	@Override
	public void update(Map<String, Object> map) {
		dao.update(map);
	}
	
	
}
