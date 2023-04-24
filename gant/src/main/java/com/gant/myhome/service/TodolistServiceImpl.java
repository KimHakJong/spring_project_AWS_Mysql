package com.gant.myhome.service;


import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.gant.myhome.domain.Todolist;
import com.gant.myhome.mybatis.mapper.TodolistMapper;



@Service
public class TodolistServiceImpl implements TodolistService {

	private TodolistMapper dao;
	
	
	@Autowired
	public TodolistServiceImpl(TodolistMapper dao) {
		this.dao = dao;
	}

	
	@Override
	public int getListCount(int p_no) {
		return dao.getListCount(p_no);
	}
	
	@Override
	public int getSendListCount(int p_no, String id) {
		return dao.getSendListCount(p_no, id);
	}
	
	@Override
	public int getSendSearchListCount(int p_no, String id, String search_word) {
		return dao.getSendSearchListCount(p_no, id, search_word);
	}

	@Override
	public List<Todolist> getTodolist(int page, int limit, int p_no, String id) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int startrow = (page-1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("p_no", p_no);
		map.put("id", id);
		
		return dao.getTodolist(map);
	}
	
	@Override
	public List<Todolist> getSearchTodolist(int page, int limit, int p_no, String id, String search_word) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int startrow = (page-1) * limit + 1;
		int endrow = startrow + limit - 1;
		
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("p_no", p_no);
		map.put("id", id);
		map.put("search", search_word);
		
		
		return dao.getSearchTodolist(map);
	}
	
	@Override
	public List<Todolist> getTodolist2(int p_no) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
	
		map.put("p_no", p_no);

		return dao.getTodolist2(map);
	}
	
	public List<Todolist> getTodolist3(int page, int limit, int p_no, int board_num) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int startrow = (page-1) * limit + 1;
		int endrow = startrow + limit - 1;
	
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("p_no", p_no);
		map.put("board_num", board_num);

		return dao.getTodolist3(map);
	}
	
	public List<Todolist> getSearchTodolist3(int page, int limit, int p_no, int board_num, String search_word) {
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		int startrow = (page-1) * limit + 1;
		int endrow = startrow + limit - 1;
	
		map.put("start", startrow);
		map.put("end", endrow);
		map.put("p_no", p_no);
		map.put("board_num", board_num);
		map.put("search", search_word);

		return dao.getSearchTodolist3(map);
	}
	
	@Override
	public void insertBoard(Todolist todolist) {
		dao.insertBoard(todolist);
		
	}
	
	public String get_id(int p_no) {
		
		String id = dao.get_id(p_no);
		
		return id;
		
	}
	public String get_name(int p_no) {

		
		String name = dao.get_name(p_no);
		
		return name;
	}


	@Override
	public Todolist getDetail(int num) {
		return dao.getDetail(num);
	}
	
	@Override
	public int boardModify(Todolist todolist) {
		return dao.boardModify(todolist);
	}

	
	@Override
	public int boardDelete(int num) {
		int result = 0;
		Todolist todolist = dao.getDetail(num);
		
		if(todolist != null) {
			result = dao.boardDelete(todolist);
		}
		return result;
	}

	
	/*
	 * 



	
	@Override
	public int boardReplyUpdate(Board board) {
		return dao.boardReplyUpdate(board);
	}
	
	@Override
	public int boardReply(Board board) {
		boardReplyUpdate(board);
		
		board.setBOARD_RE_LEV(board.getBOARD_RE_LEV()+1);
		board.setBOARD_RE_SEQ(board.getBOARD_RE_SEQ()+1);
		return dao.boardReply(board);
	}




	@Override
	public int setReadCountUpdate(int num) {
		return dao.setReadCountUpdate(num);
	}
	
	

	@Override
	public boolean isBoardWriter(int num, String pass) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("num", num);
		map.put("pass", pass);
		
		Board result = dao.isBoardWriter(map);
		if(result == null) 
			return false;
		else
			return true;
	}



	@Override
	public List<String> getDeleteFileList(){
		return dao.getDeleteFileList();
	} 
	
	@Override
	public void deleteFileList(String filename){
		dao.deleteFileList(filename);
	}
	 */

	

}
