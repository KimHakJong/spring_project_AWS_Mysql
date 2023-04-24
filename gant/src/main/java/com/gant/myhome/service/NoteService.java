package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Note;

public interface NoteService {
	
	//쪽지휴지통(삭제전 임시보관함) 테이블을 생성
	int insertNoteDelete(String table_kind);
    
	//방금 생성한 휴지통 테이블의 휴지통 번호를 가져온다.
	int selectDeleteNum();
    
	//보낸 쪽지함 테이블(note)에 insert
	int insertNote(Note note);
    
	//방금 생성한 보낸쪽지함 테이블의 쪽지번호를 가져온다.
	int selectNoteNum();
    
	//받은 쪽지함 테이블(note_to)에 insert
	int insertNoteTo(Note note);
   
	//파일 테이블에(notefile)insert 한다.
	int insertNoteFile(Note note);
    
	//id가 참조자로 되어있는 받은쪽지함 테이블의 쪽지번호 리스트를 가져온다.
	int getNoteNum(String id,String search_subject,String delete_table);
    
	// id에 해당하는 받은 쪽지 List을 가져온다. 
	List<Note> getNoteList(String id, int page, int limit, String search_subject,String delete_table);
    
	//id가 보낸사람을 되어있는 되어있는 보낸쪽지함 테이블(note)의 갯수를 가져온다.
	int sendNoteNum(String id, String search_subject,String delete_table);
    
	// id에 해당하는 보낸 쪽지 List을 가져온다. 
	List<Note> sendNoteList(String id, int page, int limit, String search_subject,String delete_table);
    
	//id에 해당하는 이름을 members테이블에서 가져온다.
	String selectName(String id);
    
	//note_num 과 id에 해당하는 받은 쪽지테이블(note_to)의 데이터를 가져온다.
	Map<String,Object> selectNoteTo(int note_num, String id,int notefile);
    
	//note_num에 파일이테이블이 있는지 없는지 확인 없으면 0 , 있으면 1
	int selectNotefile(int note_num);
    
	//만약 읽음표시가 flase이면 true으로 변경하여준다.
	void ReadCheck(int note_num, String id);
    
	//휴지통 note_delete(테이블의) delete_table 컬럼을 'yes'으로 변경
	int getBasket(int note_num, String id,String type);
    
	//note_num에 해당하는 보낸 쪽지테이블(note)의 데이터를 가져온다.
	Map<String, Object> selectNote(int note_num, int notefile);
    
	//id에 해당하는 이름/부서/직급을 members테이블에서 가져온다.
	Members selectMembersdata(String toid);
       
	// note(보낸쪽지테이블) 또는 note_to (받은 쪽지테이블) 의 delete_num을 가져온다.
	int selectDeleteNums(int note_num, String id, String type);
    
	//휴지통 note_delete(테이블) 삭제 
	int Delete(int delete_num);
    
	//방금생성한 파일번호를 가져온다.
	int selectFileNum();
	
	//삭제일이 오늘인 delete_num 테이블의 delete_num을 가져온다.
	List<Integer> selectDeleteDate(String formattedDate);
    
	//휴지통 note_delete(테이블의) delete_table 컬럼을 'no'으로 변경
	int restore(int note_num, String id, String type);
    
	
    
	
	
	
}
