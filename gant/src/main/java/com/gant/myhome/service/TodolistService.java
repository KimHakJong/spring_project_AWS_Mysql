package com.gant.myhome.service;



import java.util.List;

import com.gant.myhome.domain.Todolist;


public interface TodolistService {
	
	//
		
	public String get_id(int p_no);
	public String get_name(int p_no);
	
	public int getListCount(int p_no);
	public int getSendListCount(int p_no, String id);
	   
	public List<Todolist> getTodolist(int page, int limi, int p_no, String id);
	
	public List<Todolist> getSearchTodolist(int page, int limi, int p_no, String id, String search_word);
	public int getSendSearchListCount(int p_no, String id, String search_word);
	
	
	 
	public void insertBoard(Todolist todolist);
	
	public List<Todolist> getTodolist2(int p_no);
	
	public List<Todolist> getTodolist3(int page, int limi, int p_no, int board_num);
	public List<Todolist> getSearchTodolist3(int page, int limit, int p_no, int board_num, String search_word);
	
	
	
	public int boardDelete(int num);
	
	
	
	public Todolist getDetail(int num);
	
	
	public int boardModify(Todolist todolist);
	


	
}
