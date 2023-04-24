package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.ReservationCheck;
import com.gant.myhome.mybatis.mapper.ReservationCheckMapper;

@Service
public class ReservationCheckServiceImpl implements ReservationCheckService {
	
	private ReservationCheckMapper dao;

	@Autowired
	public ReservationCheckServiceImpl(ReservationCheckMapper dao) {
		this.dao = dao;
	}


	@Override
	public List<ReservationCheck> getTime(Map<String, String> parameter_map) {
		return dao.getTime(parameter_map);
	}




	@Override
	public int insert(ReservationCheck rv_check) {
		return dao.insert(rv_check);
	}


	@Override
	public int deletePastData(String yesterday) {
		return dao.deletePastData(yesterday);
	}


	@Override
	public int delete(int num) {
		return dao.delete(num);
	}


	@Override
	public List<ReservationCheck> getTimeAndMaxperson(Map<String, String> map) {
		return dao.getTimeAndMaxperson(map);
	}
	
}
