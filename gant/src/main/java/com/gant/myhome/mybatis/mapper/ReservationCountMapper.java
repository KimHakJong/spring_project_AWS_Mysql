package com.gant.myhome.mybatis.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.ReservationCount;

@Mapper
public interface ReservationCountMapper {

	public ReservationCount select(String id); //남은 예약가능시간 조회

	public int insert(String id); //예약시간 할당

	public int resetCount(); //매일 12시 예약가능시간 초기화

	public void update(Map<String, Object> map); //예약추가 시 예약가능시간 차감

	
}
