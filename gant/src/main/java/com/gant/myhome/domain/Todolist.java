package com.gant.myhome.domain;


public class Todolist {
	
	private int    board_num;
	private int    p_no;
	public int getP_no() {
		return p_no;
	}
	public void setP_no(int p_no) {
		this.p_no = p_no;
	}
	private String board_id;
	private String board_name;
	private String board_r_id;
	private String board_r_name;
	private String board_pass;
	private String board_subject;
	private String board_content;
	private String deadline;
	private String state;
	
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getBoard_id() {
		return board_id;
	}
	public void setBoard_id(String board_id) {
		this.board_id = board_id;
	}
	public String getBoard_name() {
		return board_name;
	}
	public void setBoard_name(String board_name) {
		this.board_name = board_name;
	}
	public String getBoard_r_id() {
		return board_r_id;
	}
	public void setBoard_r_id(String board_r_id) {
		this.board_r_id = board_r_id;
	}
	public String getBoard_r_name() {
		return board_r_name;
	}
	public void setBoard_r_name(String board_r_name) {
		this.board_r_name = board_r_name;
	}
	public String getBoard_pass() {
		return board_pass;
	}
	public void setBoard_pass(String board_pass) {
		this.board_pass = board_pass;
	}
	public String getBoard_subject() {
		return board_subject;
	}
	public void setBoard_subject(String board_subject) {
		this.board_subject = board_subject;
	}
	public String getBoard_content() {
		return board_content;
	}
	public void setBoard_content(String board_content) {
		this.board_content = board_content;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}

		

	
}
