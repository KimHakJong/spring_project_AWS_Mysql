package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.gant.myhome.domain.Board;
import com.gant.myhome.mybatis.mapper.BoardMapper;






@Service
public class BoardServicelmpl implements BoardService {

	private BoardMapper dao;
		
	@Autowired
	public BoardServicelmpl(BoardMapper dao) {
		this.dao = dao;
	}
    
	//전체 게시글 수
	@Override
	public int getListCount() {
		return dao.getListCount();
	}
    
	//게시글 목록 (10줄씩 공지사항 글이 위로 온다)
	@Override
	public List<Board> getBoardList(int page, int limit) {
		HashMap<String,Integer> map = new HashMap<String,Integer>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;
		map.put("start",startrow);
		map.put("end",endrow);
		return dao.getBoardList(map);
	}
    
	// 검색 게시글 수 
	@Override
	public int getSearchListCount(String search_name) {
		return dao.getSearchListCount(search_name);
	}
    
	//검색 게시글 목록 (공지,일반 게시물 구분을 하지 않는다.)
	@Override
	public List<Board> getSearchBoardList(int page, int limit, String search_name) {
		HashMap<String,Object> map = new HashMap<String,Object>();
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;
		map.put("start",startrow);
		map.put("end",endrow);
		map.put("search_name", search_name);
		return dao.getBoardSearchList(map);
	}
    

	@Override
	public void insertBoard(Board board) {
		dao.insertBoard(board);
	}

	@Override
	public String getadmindate(String id) {
		return dao.getadmindate(id);
	}
	
	
	@Override
    public int setReadCountUpdate(int board_num) {
		return dao.setReadCountUpdate(board_num);
	}
	
		
	@Override
	public Board getDetail(int board_num) {
		return dao.getDetail(board_num);
	}
    
	
	//프로필 이미지 가져오기
	@Override
	public String getprofileimg(String board_name) {		
		return dao.getprofileimg(board_name);
	}
     
	
	@Override
	public int boardDelete(int board_num) {
		int result = 0;
		Board board = dao.getDetail(board_num);		
		if(board != null) {
			result = dao.boardDelete(board);
		}
		return result;
	}
	
	
	@Override
	public void BoardupdateLike(int board_num, int update) {
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("board_num",board_num);
		map.put("update",update);
		dao.BoardupdateLike(map);
	}
	
	
	@Override
	@Transactional
	public int boardReply(Board board) {
		boardReplyUpdate(board);
		board.setBoard_re_lev(board.getBoard_re_lev()+1);
		board.setBoard_re_seq(board.getBoard_re_seq()+1);
		board.setBoard_notice("false");
		return dao.boardReply(board);
	}
	
	@Override
	public int boardReplyUpdate(Board board) {
		return dao.boardReplyUpdate(board);
	}
	
	
		
	@Override
	public int boardModify(Board modifyboard) {
		return dao.boardModify(modifyboard);
	}




	@Override
	public List<String> getdeleteFileList() {		
		return dao.getDeleteFileList();
	}

	@Override
	public void deleteFileList(String filename) {
		dao.deleteFileList(filename);
	}


	
}
