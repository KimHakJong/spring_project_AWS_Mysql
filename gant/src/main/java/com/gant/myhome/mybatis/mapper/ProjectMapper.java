package com.gant.myhome.mybatis.mapper;



import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Project;


@Mapper
public interface ProjectMapper {

	public int create(Project project);

	public List<Project> getProjectList(Map<String, String> map);

	public Project getProjectOne(int p_no);

	public int update(Project project);

	public int delete(int p_no);


	 
}
