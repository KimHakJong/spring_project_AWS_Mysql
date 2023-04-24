package com.gant.myhome.domain;

public class Memo {
	private int num;
	private String id;
	private String subject;
	private String content;
	private String background;
	private String color;
	private String update_date;
	
	public String getUpdate_date() {
		return update_date;
	}
	
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
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
	
	public String getSubject() {
		return subject;
	}
	
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	public String getContent() {
		return content;
	}
	
	public void setContent(String content) {
		this.content = content;
	}
	
	public String getBackground() {
		return background;
	}
	
	public void setBackground(String background) {
		this.background = background;
	}
	
	public String getColor() {
		return color;
	}
	
	public void setColor(String color) {
		this.color = color;
	}
	
}
