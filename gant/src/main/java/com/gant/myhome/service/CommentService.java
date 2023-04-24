package com.gant.myhome.service;


import java.util.List;

import com.gant.myhome.domain.Comment;




public interface CommentService {
    
	//글의 갯수 구하기
	public int getListCount(int comment_board_num);
	
	//댓글 목록 가져오기
	public List<Comment> getCommentList(int comment_board_num, int state);

	//댓글 등록하기
	public int commentsInsert(Comment c);
	
	//댓글 삭제
	public int commentsDelete(int num);
	
    //댓글 수정
	public int commentsUpdate(Comment co);
    
	//댓글의 댓글 등록
	public int commentsreply(Comment comment);
	

}
