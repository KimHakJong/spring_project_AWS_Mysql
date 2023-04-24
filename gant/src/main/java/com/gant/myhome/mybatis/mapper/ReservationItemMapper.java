package com.gant.myhome.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.ReservationItem;

@Mapper
public interface ReservationItemMapper {

	public int insert(ReservationItem rItem);

	public List<String> getTypeList();

	public List<String> getResourcesByType(String type);

	public int getMaxPerson(String resource_name);


}
