package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Reservation;
import com.gant.myhome.mybatis.mapper.ReservationMapper;

@Service
public class ReservationServiceImpl implements ReservationService {
	
	private ReservationMapper dao;

	@Autowired
	public ReservationServiceImpl(ReservationMapper dao) {
		this.dao = dao;
	}

	@Override
	public int insert(Reservation rv) {
		
		//넘어온 값 18->09:00 , 19:09:30 , 20->10:00 시간으로 표시하기위한 코드
		int s_hour_before = Integer.parseInt(rv.getStart_time())/2;
		int s_min_before = Integer.parseInt(rv.getStart_time())%2;
		String s_hour;
		String s_min ;
		if(s_hour_before<10) {
			s_hour = "0"+ s_hour_before;
		}else {
			s_hour = "" + s_hour_before;
		}
		
		if(s_min_before==1) {
			s_min = "30";
		}else {
			s_min = "00";
		}
		rv.setStart_time(s_hour+":"+s_min);
		
		//종료시간은 +30분더해야하기에 값+1 해서 표시한다.
		int e_hour_before = (Integer.parseInt(rv.getEnd_time())+1) / 2;
		int e_min_before = (Integer.parseInt(rv.getEnd_time())+1) % 2;
		
		String e_hour;
		String e_min;
		if(e_hour_before<10) {
			e_hour = "0"+ e_hour_before;
		}else {
			e_hour = ""+e_hour_before;
		}
		
		if(e_min_before==1) {
			e_min = "30";
		}else {
			e_min = "00";
		}
		rv.setEnd_time(e_hour+":"+e_min);
		
		return dao.insert(rv);
	}

	@Override
	public int selectRecentInsertion() {
		return dao.selectRecentInsertion();
	}

	@Override
	public int deletePastData(String yesterday) {
		return dao.deletePastData(yesterday);
	}

	@Override
	public Reservation selectInfo(int num) {
		return dao.selectInfo(num);
	}

	@Override
	public int delete(int num) {
		return dao.delete(num);
	}

	@Override
	public int update(Reservation rs) {
		//넘어온 값 18->09:00 , 19:09:30 , 20->10:00 시간으로 표시하기위한 코드
		int s_hour_before = Integer.parseInt(rs.getStart_time())/2;
		int s_min_before = Integer.parseInt(rs.getStart_time())%2;
		String s_hour;
		String s_min ;
		if(s_hour_before<10) {
			s_hour = "0"+ s_hour_before;
		}else {
			s_hour = "" + s_hour_before;
		}
		
		if(s_min_before==1) {
			s_min = "30";
		}else {
			s_min = "00";
		}
		rs.setStart_time(s_hour+":"+s_min);
		
		//종료시간은 +30분더해야하기에 값+1 해서 표시한다.
		int e_hour_before = (Integer.parseInt(rs.getEnd_time())+1) / 2;
		int e_min_before = (Integer.parseInt(rs.getEnd_time())+1) % 2;
		
		String e_hour;
		String e_min;
		if(e_hour_before<10) {
			e_hour = "0"+ e_hour_before;
		}else {
			e_hour = ""+e_hour_before;
		}
		
		if(e_min_before==1) {
			e_min = "30";
		}else {
			e_min = "00";
		}
		rs.setEnd_time(e_hour+":"+e_min);
				
		return dao.update(rs);
	}

	@Override
	public List<Reservation> selectById(String start_day, String end_day, String id, int page) {
		Map<String,Object> map = new HashMap<String,Object>();
		int start = 1;
		int end = 5*page;
		if(!start_day.equals("")) {
			map.put("start_day", start_day);
		}
		if(!end_day.equals("")) {
			map.put("end_day", end_day);
		}
		map.put("id", id);
		map.put("start", start);
		map.put("end", end);
		return dao.selectById(map);
	}
	
	@Override
	public int selectCountById(String start_day, String end_day, String id) {
		Map<String,Object> map = new HashMap<String,Object>();
		if(!start_day.equals("")) {
			map.put("start_day", start_day);
		}
		if(!end_day.equals("")) {
			map.put("end_day", end_day);
		}
		map.put("id", id);
		return dao.selectCountById(map);
	}
	
	
}
