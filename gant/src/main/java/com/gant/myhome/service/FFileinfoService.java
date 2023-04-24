package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import com.gant.myhome.domain.FFileinfo;
import com.gant.myhome.domain.FFolder;

public interface FFileinfoService {

	public int insert(FFileinfo ffileinfo); //파일업로드할 때 추가

	public int update(Map<String, Object> map); //파일이름 변경

	public List<FFileinfo> selectAllFileInFolder(FFolder ffolder); //폴더 하위에있는 모든 파일을 가져오는 동작 수행

	public int updateLocation(Map<String, Object> map); //파일이 포함된 폴더경로 변경

	public int updatePathFromEdit(Map<String, Object> map); //폴더명 변경에 따른 하위파일 경로에 있는 폴더명 변경

	public int updateLocationByFolder(Map<String, Object> map); //폴더 경로 이동할 때 파일 경로 같이 변경

}
