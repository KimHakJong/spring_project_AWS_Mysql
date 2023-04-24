package com.gant.myhome.mybatis.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.FFolder;

@Mapper
public interface FFolderMapper {

	public int selectCount(int p_no);

	public int insert(FFolder ffolder);

	public FFolder selectFirst(int p_no);

	public List<FFolder> selectSubFolder(FFolder ffolder);

	public int update(Map<String, Object> map);

	public List<Integer> selectDelNum(FFolder ffolder);
	
	public int delete(FFolder ffolder);

	public int updateLocation(Map<String, Object> map);

	public int updatePathFromEdit(Map<String, Object> map);
	
}
