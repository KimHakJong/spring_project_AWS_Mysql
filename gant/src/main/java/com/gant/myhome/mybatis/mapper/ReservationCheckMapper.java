package com.gant.myhome.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.ReservationCheck;

@Mapper
public interface ReservationCheckMapper {

	public List<ReservationCheck> getTime(Map<String, String> parameter_map);

	public int insert(ReservationCheck rv_check);

	public int deletePastData(String yesterday);

	public int delete(int num);

	public List<ReservationCheck> getTimeAndMaxperson(Map<String, String> map);

}
