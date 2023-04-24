package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import com.gant.myhome.domain.ReservationCheck;

public interface ReservationCheckService {
	
	//테이블에 자원,날짜별 예약가능 시간 표시
	public List<ReservationCheck> getTime(Map<String, String> parameter_map);

	public int insert(ReservationCheck rv_check); //예약된 시간 추가

	public int deletePastData(String yesterday);// 지난시간 삭제

	public int delete(int num); //예약수정할 때 기존에있던 시간 제거

	public List<ReservationCheck> getTimeAndMaxperson(Map<String, String> map);

}
