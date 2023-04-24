package com.gant.myhome.domain;

public class ReservationCheck {
	private String id; //해당예약번호의 예약자를 reservation 테이블과 조인을 통해 받기 위함
	private int num;
	private String resource_name;
	private String day;
	private int reserved_time;
	private String name; //해당시간의 예약자 성명을 view에 같이 넘기기 위함
	private String max_person; //해당예약번호의 최대 수용인원을 넘기기 위함
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getMax_person() {
		return max_person;
	}
	public void setMax_person(String max_person) {
		this.max_person = max_person;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getResource_name() {
		return resource_name;
	}
	public void setResource_name(String resource_name) {
		this.resource_name = resource_name;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public int getReserved_time() {
		return reserved_time;
	}
	public void setReserved_time(int reserved_time) {
		this.reserved_time = reserved_time;
	}
}
