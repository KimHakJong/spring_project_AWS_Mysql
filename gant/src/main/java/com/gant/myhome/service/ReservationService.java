package com.gant.myhome.service;


import java.util.List;

import com.gant.myhome.domain.Reservation;

public interface ReservationService {

	public int insert(Reservation rv); //예약 추가

	public int selectRecentInsertion(); //방금추가한 예약번호 가져옴

	public int deletePastData(String yesterday); //시간지난 예약 삭제

	public Reservation selectInfo(int num); //번호에 해당하는 예약 정보

	public int delete(int num); //예약 취소

	public int update(Reservation rs); //예약 수정

	public List<Reservation> selectById(String start_day, String end_day, String id, int page); //날짜별 개수별 내 예약조회

	public int selectCountById(String start_day, String end_day, String id); //날짜별 모든 내 예약조회 목록 개수

}
