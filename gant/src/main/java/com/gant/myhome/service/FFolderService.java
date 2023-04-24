package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import com.gant.myhome.domain.FFolder;

public interface FFolderService {

	public int selectCount(int p_no); //처음 들어왔을 때 폴더 있는지

	public int insert(FFolder ffolder); //폴더 추가

	public FFolder selectFirst(int p_no); //첫 폴더에 대한 정보

	public List<FFolder> selectSubFolder(FFolder ffolder); //한 단계 하위폴더 가져옴

	public int update(Map<String, Object> map); //폴더이름 변경

	public int delete(FFolder ffolder); //폴더삭제(하위 폴더도 같이)

	public int updateLocation(Map<String, Object> map); //폴더위치 변경(하위 폴더도 같이)

	public int updatePathFromEdit(Map<String, Object> map); //폴더명 변경에따른 경로에서 폴더명 변경(하위 폴더도 같이)
	
}
