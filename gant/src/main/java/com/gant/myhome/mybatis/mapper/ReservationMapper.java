package com.gant.myhome.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Reservation;

@Mapper
public interface ReservationMapper {

	public int insert(Reservation rv);

	public int selectRecentInsertion();

	public int deletePastData(String yesterday);

	public Reservation selectInfo(int num);

	public int delete(int num);

	public int update(Reservation rs);

	public List<Reservation> selectById(Map<String, Object> map);

	public int selectCountById(Map<String, Object> map);
	
}
