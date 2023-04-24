package com.gant.myhome.mybatis.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Comment;




@Mapper
public interface CommentMapper {
    
	//글의 갯수 구하기
	public int getListCount(int board_num);

	//댓글 목록 가져오기
	public List<Comment> getCommentList(Map<String,Object> map);
	
	//댓글 등록하기
	public int commentsInsert(Comment c);
	
	//댓글 삭제
	public int commentsDelete(int num);
	
    //댓글 수정
	public int commentsUpdate(Comment co);
    
	//댓글삭제
	public int commentsDelete(Comment comm);
    
	//댓글 조회
	public Comment commentselect(int num);
    
	//댓글의 댓글 등록
	public int commentsreply(Comment comment);
    
	//댓글의 댓글 달기전 기존의 댓글 comment_re_seq=comment_re_seq +1
	public int pluscomments(Comment comment);
	
	

}
