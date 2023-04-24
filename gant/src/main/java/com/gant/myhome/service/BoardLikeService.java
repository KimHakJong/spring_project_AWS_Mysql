package com.gant.myhome.service;

public interface BoardLikeService {
    
    
	//좋아요 테이블 유무 확인
	public int selectLike(String id, int board_num);
    
	//좋아요 테이블 생성
	public void insertLike(String id, int board_num);
    
	//id와 테이블번호에 해당하는 like_check 값을 가져온다.
	public String selectLikeCheck(String id, int board_num);
    
	//like_check 를 false에서 true으로 변경 , true에서 false으로 변경
	public int updateLike(String id, int board_num, String like_check);
    

		
	
}
