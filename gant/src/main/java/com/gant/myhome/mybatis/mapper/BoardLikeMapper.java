package com.gant.myhome.mybatis.mapper;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

/*
 Mapper 인터페이스란 매퍼 파일에 기재된 SQL을 호출하기 위한 인터페이스 입니다.
 Mybatis-Spring은 Mapper 인터페이스를 이용해서 실제 SQL 처리가 되는 클래스를 자동으로 생성합니다. 
 */

@Mapper
public interface BoardLikeMapper {
	    
        
		// 좋아요 테이블 유무 확인 
		public String selectLike(HashMap<String, Object> map);
        
		//좋아요 테이블 생성
		public void insertLike(HashMap<String, Object> map);
        
		//id와 테이블번호에 해당하는 like_check 값을 가져온다.
		public String selectLikeCheck(HashMap<String, Object> map);
		
		//like_check 를 false에서 true으로 변경 , true에서 false으로 변경
		public int updateLike(Map<String, Object> map);
        



    
	
	
}
