package com.gant.myhome.service;

import java.util.List;

import com.gant.myhome.domain.ReservationItem;

public interface ReservationItemService {

	public int insert(ReservationItem rItem); //자원추가

	public List<String> getTypeList(); //종류목록 가져옴

	public List<String> getResourcesByType(String type); //선택한 종류의 자원리스트 가져옴 

	public int getMaxPerson(String resource_name); //자원명에 대한 최대 참여명단 수를 제한


}
