package com.gant.myhome.mybatis.mapper;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.FFolder;
import com.gant.myhome.domain.Filebox;

@Mapper
public interface FileboxMapper {

	public int insert(Filebox filebox);

	public List<Map<String, Object>> selectFile(Map<String, Integer> param_map);

	public String selectUploader(int num);

	public int delete(int num);

	public int deleteFileinFolder(FFolder ffolder);
	
}
