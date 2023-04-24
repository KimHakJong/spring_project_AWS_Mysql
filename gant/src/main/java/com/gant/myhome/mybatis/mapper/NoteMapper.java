package com.gant.myhome.mybatis.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Note;


/*
 Mapper 인터페이스란 매퍼 파일에 기재된 SQL을 호출하기 위한 인터페이스 입니다.
 Mybatis-Spring은 Mapper 인터페이스를 이용해서 실제 SQL 처리가 되는 클래스를 자동으로 생성합니다. 
 */

@Mapper
public interface NoteMapper {

	int insertNoteDelete(String table_kind);

	int selectDeleteNum();

	int insertNote(Note note);

	int selectNoteNum();

	int insertNoteTo(Note note);

	int insertNoteFile(Note note);

	int getNoteNum(Map<String, Object> map);

	List<Note> getNoteList(Map<String, Object> map);

	int sendNoteNum(Map<String, Object> map);

	List<Note> sendNoteList(Map<String, Object> map);

	String selectName(String id);

	Map<String,Object> selectNoteTo(Map<String, Object> map);

	int selectNotefile(int note_num);

	void ReadCheck(Map<String, Object> map);

	int getBasket(Map<String, Object> map);

	Map<String, Object> selectNote(Map<String, Object> map);

	Members selectMembersdata(String toid);

	int delete(Map<String, Object> map);

	int selectDeleteNums(Map<String, Object> map);

	int Delete(int delete_num);

	int selectFileNum();

	List<Integer> selectDeleteDate(String formattedDate);

	int restore(Map<String, Object> map);

	
		
		
}
