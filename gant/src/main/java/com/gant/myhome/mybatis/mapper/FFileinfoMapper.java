package com.gant.myhome.mybatis.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.FFileinfo;
import com.gant.myhome.domain.FFolder;

@Mapper
public interface FFileinfoMapper {

	public int insert(FFileinfo ffileinfo);

	public int update(Map<String, Object> map);

	public List<FFileinfo> selectAllFileInFolder(FFolder ffolder);

	public int updateLocation(Map<String, Object> map);

	public int updatePathFromEdit(Map<String, Object> map);

	public int updateLocationByFolder(Map<String, Object> map);
	
}
