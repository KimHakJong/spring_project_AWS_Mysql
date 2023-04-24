package com.gant.myhome.domain;

public class Vacation {

	private String id;
	private int paper_num;
	private String reference_person;
	private String condition;
	private String write_date;
	private String classification;
	private String start_date;
	private String end_date;
	private int vacation_date;
	private String division;
	private String emergency;
	private String details;	
	private String name; //작성자이름
	private String department;//부서명
	private String position;//직급
	
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getPaper_num() {
		return paper_num;
	}
	public void setPaper_num(int paper_num) {
		this.paper_num = paper_num;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	public String getEnd_date() {
		return end_date;
	}
	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}
	public String getDivision() {
		return division;
	}
	public void setDivision(String division) {
		this.division = division;
	}
	public String getEmergency() {
		return emergency;
	}
	public void setEmergency(String emergency) {
		this.emergency = emergency;
	}
	public String getDetails() {
		return details;
	}
	public void setDetails(String details) {
		this.details = details;
	}
	public String getReference_person() {
		return reference_person;
	}
	public void setReference_person(String reference_person) {
		this.reference_person = reference_person;
	}
	public String getCondition() {
		return condition;
	}
	public void setCondition(String condition) {
		this.condition = condition;
	}
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public int getVacation_date() {
		return vacation_date;
	}
	public void setVacation_date(int vacation_date) {
		this.vacation_date = vacation_date;
	}

	
	
}
