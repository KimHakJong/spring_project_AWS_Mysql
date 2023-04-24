package com.gant.myhome.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Members {
	private String admin;
	private String id;
	private String password;
	private String name;
	private String jumin;
	private String phone_num;
	private String email;
	private int post;
	private String address;
	private String department;
	private String position;
	private String profileimg;
	private String auth = "ROLE_MEMBER";

	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
	}
	
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJumin() {
		return jumin;
	}
	public void setJumin(String jumin) {
		this.jumin = jumin;
	}
	
	public String getBirth() {
		//현재 년도 뒤자리 2개 추출
		SimpleDateFormat sd = new SimpleDateFormat("yyyy");
		int nowyear = Integer.parseInt(sd.format(new Date()).substring(2,4));
		
		int ytest = Integer.parseInt(jumin.substring(0,2));
		String year;
		if(ytest <= nowyear) {
			year = "20" + jumin.substring(0,2) + "년 ";
		}else {
			year = "19" + jumin.substring(0,2) + "년 ";
		}
		
		String mon;
		if(jumin.substring(2,3).equals("0"))
			mon = jumin.substring(3,4) + "월 ";
		else
			mon = jumin.substring(2,4) + "월 ";
		
		String day;
		if(jumin.substring(4,5).equals("0"))
			day = jumin.substring(5,6) + "일";
		else
			day = jumin.substring(4,6) + "일";
		
		return year+mon+day;
	}
	public String getPhone_num() {
		return phone_num;
	}
	public void setPhone_num(String phone_num) {
		this.phone_num = phone_num;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getPost() {
		return post;
	}
	public void setPost(int post) {
		this.post = post;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
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
	public String getProfileimg() {
		return profileimg;
	}
	public void setProfileimg(String profileimg) {
		this.profileimg = profileimg;
	}
	
}


	

