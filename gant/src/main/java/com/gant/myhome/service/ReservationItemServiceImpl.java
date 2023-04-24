package com.gant.myhome.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.ReservationItem;
import com.gant.myhome.mybatis.mapper.ReservationItemMapper;

@Service
public class ReservationItemServiceImpl implements ReservationItemService {
	
	private ReservationItemMapper dao;

	@Autowired
	public ReservationItemServiceImpl(ReservationItemMapper dao) {
		this.dao = dao;
	}

	
	@Override
	public int insert(ReservationItem rItem) {
		return dao.insert(rItem);
	}

	@Override
	public List<String> getTypeList() {
		return dao.getTypeList();
	}
	
	@Override
	public List<String> getResourcesByType(String type) {
		return dao.getResourcesByType(type);//타입별 자원명을 ,로 구분해서 가져옴
	}


	@Override
	public int getMaxPerson(String resource_name) {
		return dao.getMaxPerson(resource_name);
	}


	
	
}
