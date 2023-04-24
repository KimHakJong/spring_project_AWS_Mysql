package com.gant.myhome.domain;

public class Attendance{
	private String id;
	private String startTime;
	private String endTime;
	private String overTime;
	private String work_today;
	private String work_week;
	private String checkbutton;
	private String work_date;
	private int check_work_week;
	
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public String getOverTime() {
		return overTime;
	}
	public void setOverTime(String overTime) {
		this.overTime = overTime;
	}
	public String getWork_today() {
		return work_today;
	}
	public void setWork_today(String work_today) {
		this.work_today = work_today;
	}
	public String getWork_week() {
		return work_week;
	}
	public void setWork_week(String work_week) {
		this.work_week = work_week;
	}
	
	public String getCheckbutton() {
		return checkbutton;
	}
	public void setCheckbutton(String checkbutton) {
		this.checkbutton = checkbutton;
	}
	public String getWork_date() {
		return work_date;
	}
	public void setWork_date(String work_date) {
		this.work_date = work_date;
	}
	
	public int getCheck_work_week() {
		return check_work_week;
	}
	public void setCheck_work_week(int check_work_week) {
		this.check_work_week = check_work_week;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	
	
	
	

}