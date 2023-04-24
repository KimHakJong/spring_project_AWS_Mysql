package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Comment;
import com.gant.myhome.mybatis.mapper.CommentMapper;



@Service
public class CommentServicelmpl implements CommentService {

	private CommentMapper dao;
	
	@Autowired
	public CommentServicelmpl(CommentMapper dao) {
		this.dao = dao;
	}

	@Override
	public int getListCount(int comment_board_num) {
		return dao.getListCount(comment_board_num);
	}

	@Override
	public List<Comment> getCommentList(int comment_board_num, int state) {
		String sort ="asc"; //등록순
		if(state == 2) {
		   sort="desc"; // 최신순
		   }
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("comment_board_num", comment_board_num);
		map.put("sort",sort);
		
	   List<Comment> lists  = dao.getCommentList(map);
       System.out.println(lists.size()); 
		return lists;
	}

	@Override
	public int commentsInsert(Comment c) {
		return dao.commentsInsert(c);
	}
	
	
	@Override
	public int commentsUpdate(Comment co) {
		return dao.commentsUpdate(co);
	}

	@Override
	public int commentsDelete(int num) {
		Comment comm = dao.commentselect(num);
		return dao.commentsDelete(comm);
	}

	@Override
	public int commentsreply(Comment comment) {
		dao.pluscomments(comment);
		comment.setComment_re_lev(comment.getComment_re_lev()+1);
		comment.setComment_re_seq(comment.getComment_re_seq()+1);
		return dao.commentsreply(comment);
	}

	

	
	
	
	
}
