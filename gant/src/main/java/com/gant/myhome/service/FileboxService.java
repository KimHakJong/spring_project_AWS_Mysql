package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import com.gant.myhome.domain.FFolder;
import com.gant.myhome.domain.Filebox;

public interface FileboxService {

	public int insert(Filebox filebox); //파일업로드 시 파일작성자,날짜,파일번호 저장

	public List<Map<String, Object>> selectFile(Map<String, Integer> param_map); //파일정보테이블과 조인하여 파일리스트 조회

	public String selectUploader(int num); //작성자확인

	public int delete(int num); //삭제한 ID가 관리자,프로젝트생성자,파일생성자이면 삭제O

	public int deleteFileinFolder(FFolder ffolder); //해당폴더 하위 경로에 있는 파일을 삭제

}
