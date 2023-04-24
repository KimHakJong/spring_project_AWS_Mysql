package com.gant.myhome.domain;

public class Reservation {
	private int num;
	private String id;
	private String purpose;
	private String names;
	private String type;
	private String resource_name;
	private String day;
	private String start_time;
	private String end_time;
	private String name; //해당시간의 예약자 성명을 같이 넘기기 위함
	private String profileimgs; //해당시간의 예약명단에 대한 프로필 사진을 같이 넘기기 위함
	private String ids; //해당시간의 예약명단에 대한 아이디를 같이 넘기기 위함

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProfileimgs() {
		return profileimgs;
	}
	public void setProfileimgs(String profileimgs) {
		this.profileimgs = profileimgs;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPurpose() {
		return purpose;
	}
	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}
	public String getNames() {
		return names;
	}
	public void setNames(String names) {
		this.names = names;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
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
	public String getStart_time() {
		return start_time;
	}
	public void setStart_time(String start_time) {
		this.start_time = start_time;
	}
	public String getEnd_time() {
		return end_time;
	}
	public void setEnd_time(String end_time) {
		this.end_time = end_time;
	} 
	
}
