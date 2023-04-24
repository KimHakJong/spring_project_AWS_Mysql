package com.gant.myhome.domain;

public class BoardLike {
	private String id;
	private int board_num;
	private String like_check;
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
	}
	public String getLike_check() {
		return like_check;
	}
	public void setLike_check(String like_check) {
		this.like_check = like_check;
	}
	
}
