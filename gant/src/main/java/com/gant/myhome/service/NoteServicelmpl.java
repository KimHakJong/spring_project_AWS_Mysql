package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Members;
import com.gant.myhome.domain.Note;
import com.gant.myhome.mybatis.mapper.NoteMapper;




@Service
public class NoteServicelmpl implements NoteService {

	private NoteMapper dao;
		
	@Autowired
	public NoteServicelmpl(NoteMapper dao) {
		this.dao = dao;
	}
	
	
	//쪽지휴지통(삭제전 임시보관함) 테이블을 생성
	@Override
	public int insertNoteDelete(String table_kind) {
		return dao.insertNoteDelete(table_kind);
	}

	//방금 생성한 휴지통 테이블의 휴지통 번호를 가져온다.
	@Override
	public int selectDeleteNum() {
		return dao.selectDeleteNum();
	}

	//보낸 쪽지함 테이블(note)에 insert
	@Override
	public int insertNote(Note note) {
		return dao.insertNote(note);
	}

	//방금 생성한 보낸쪽지함 테이블의 쪽지번호를 가져온다.
	@Override
	public int selectNoteNum() {
		return dao.selectNoteNum();
	}

	//받은 쪽지함 테이블(note_to)에 insert
	@Override
	public int insertNoteTo(Note note) {
		return dao.insertNoteTo(note);
	}

	//파일 테이블에(notefile)insert 한다.
	@Override
	public int insertNoteFile(Note note) {
		return dao.insertNoteFile(note);
	}

	//id가 참조자로 되어있는 받은쪽지함 테이블의 쪽지번호 리스트를 가져온다.
	@Override
	public int getNoteNum(String id,String search_subject,String delete_table) {
		Map<String,Object> map = new HashMap<String, Object>();		
		map.put("search_subject", search_subject);
		map.put("id", id);
		map.put("delete_table", delete_table);
		return dao.getNoteNum(map);
	}

	// id에 해당하는 받은 쪽지 List을 가져온다. 
	@Override
	public List<Note> getNoteList(String id, int page, int limit, String search_subject,String delete_table) {
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("search_subject", search_subject);
		map.put("id", id);
		map.put("delete_table", delete_table);
		return dao.getNoteList(map);
	}

	//id가 보낸사람을 되어있는 되어있는 보낸쪽지함 테이블(note)의 갯수를 가져온다.
	@Override
	public int sendNoteNum(String id, String search_subject,String delete_table) {
		Map<String,Object> map = new HashMap<String, Object>();		
		map.put("search_subject", search_subject);
		map.put("id", id);
		map.put("delete_table", delete_table);
		return dao.sendNoteNum(map);
	}

	// id에 해당하는 보낸 쪽지 List을 가져온다. 
	@Override
	public List<Note> sendNoteList(String id, int page, int limit, String search_subject,String delete_table) {
		int startrow=(page-1)*limit+1;
		int endrow=startrow+limit-1;		
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("startrow", startrow);
		map.put("endrow", endrow);
		map.put("search_subject", search_subject);
		map.put("id", id);
		map.put("delete_table", delete_table);
		return dao.sendNoteList(map);
	}

	//id에 해당하는 이름을 members테이블에서 가져온다.
	@Override
	public String selectName(String id) {
		return dao.selectName(id);
	}

	//note_num 과 id에 해당하는 받은 쪽지테이블(note_to)의 데이터를 가져온다.
	@Override
	public Map<String,Object> selectNoteTo(int note_num, String id,int notefile) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("note_num",note_num);
		map.put("notefile",notefile);
		return dao.selectNoteTo(map);
	}

	//note_num에 파일이테이블이 있는지 없는지 확인 없으면 0 , 있으면 1
	@Override
	public int selectNotefile(int note_num) {
		return dao.selectNotefile(note_num);
	}

	//읽음표시가 flase이면 true으로 변경하여준다.
	@Override
	public void ReadCheck(int note_num, String id) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("note_num",note_num);
		dao.ReadCheck(map);
	}

	//휴지통 note_delete(테이블의) delete_table 컬럼을 'yes'으로 변경 -> 받은쪽지함
	@Override
	public int getBasket(int note_num, String id,String type) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("note_num",note_num);
		map.put("type",type);
		return dao.getBasket(map);
	}

	//note_num에 해당하는 보낸 쪽지테이블(note)의 데이터를 가져온다.
	@Override
	public Map<String, Object> selectNote(int note_num, int notefile) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("note_num",note_num);
		map.put("notefile",notefile);
		return dao.selectNote(map);
	}

	//id에 해당하는 이름/부서/직급을 members테이블에서 가져온다.
	@Override
	public Members selectMembersdata(String toid) {
		return dao.selectMembersdata(toid);
	}


	// note(보낸쪽지테이블) 또는 note_to (받은 쪽지테이블) 의 delete_num을 가져온다.
	@Override
	public int selectDeleteNums(int note_num, String id, String type) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("note_num",note_num);
		map.put("type",type);
		return dao.selectDeleteNums(map);
	}

	//휴지통 note_delete(테이블) 삭제 
	@Override
	public int Delete(int delete_num) {
		return dao.Delete(delete_num);
	}

	//방금생성한 파일번호를 가져온다.
	@Override
	public int selectFileNum() {
		return dao.selectFileNum();
	}

	//삭제일이 오늘인 delete_num 테이블의 delete_num을 가져온다.
	@Override
	public List<Integer> selectDeleteDate(String formattedDate) {
		return dao.selectDeleteDate(formattedDate);
	}

	//휴지통 note_delete(테이블의) delete_table 컬럼을 'no'으로 변경
	@Override
	public int restore(int note_num, String id, String type) {
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("id",id);
		map.put("note_num",note_num);
		map.put("type",type);
		return dao.restore(map);
	}
    
	


	
}
