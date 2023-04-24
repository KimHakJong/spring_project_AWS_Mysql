package com.gant.myhome.mybatis.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Todolist;

@Mapper
public interface TodolistMapper {
	
		
	
	public List<Todolist> getTodolist(HashMap<String, Object> map);


	public String get_id(int p_no);

	public String get_name(int p_no);
	
	public int getListCount(int p_no);
	
	public void insertBoard(Todolist todolist);
	
	public List<Todolist> getTodolist2(HashMap<String, Object> map);

	public List<Todolist> getTodolist3(HashMap<String, Object> map);
	public List<Todolist> getSearchTodolist3(HashMap<String, Object> map);


	public int getSendListCount(int p_no, String id);
	
	public int getSendSearchListCount(int p_no, String id, String search_word);
	
	public List<Todolist> getSearchTodolist(HashMap<String, Object> map);


	public int boardDelete(Todolist todolist);
	
	public Todolist getDetail(int num);


	public int boardModify(Todolist todolist);



	/*
	 * 	
	
	
	
	
	public int boardReply(Board board);
	
	

	
	public int setReadCountUpdate(int num);
	
	public Board isBoardWriter(HashMap<String, Object> map);
	
	
	
	public int boardReplyUpdate(Board board);
	
	public List<String> getDeleteFileList();
	
	public void deleteFileList(String filename);
	 */

}
