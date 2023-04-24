package com.gant.myhome.domain;

public class Overtime {
	
private String id;
private int paper_num;
private String over_time;
private String overtime_content;
private String overtime_reason;
private String overtime_date;
private String reference_person;
private String condition;
private String write_date;
private String classification;
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
public String getOver_time() {
	return over_time;
}
public void setOver_time(String over_time) {
	this.over_time = over_time;
}
public String getOvertime_content() {
	return overtime_content;
}
public void setOvertime_content(String overtime_content) {
	this.overtime_content = overtime_content;
}
public String getOvertime_reason() {
	return overtime_reason;
}
public void setOvertime_reason(String overtime_reason) {
	this.overtime_reason = overtime_reason;
}
public String getOvertime_date() {
	return overtime_date;
}
public void setOvertime_date(String overtime_date) {
	this.overtime_date = overtime_date;
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
}
