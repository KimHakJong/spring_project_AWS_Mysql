package com.gant.myhome.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Project;
import com.gant.myhome.mybatis.mapper.ProjectMapper;

@Service
public class ProjectServiceImpl implements ProjectService {

	private ProjectMapper dao;
	
	@Autowired
	public ProjectServiceImpl(ProjectMapper dao) {
		this.dao = dao;
	}

	@Override
	public int create(Project project) {
		project.setP_situation("진행상황 미입력");
		project.setP_percent(0);
		return dao.create(project);
	}

	@Override
	public List<Project> getProjectList(String id, String p_name, String admin, String position) {
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("id", id);
		if(!p_name.equals("")) { //프로젝트명 검색어를 입력한 경우
			map.put("p_name", p_name);
		}
		if(admin.equals("true")) { //관리자가 맞는 경우
			map.put("admin", admin);
		}
		if(position.equals("부장")) { //직급이 부장인 경우
			map.put("position", position);
		}
		
		return dao.getProjectList(map);
	}

	@Override
	public Project getProjectOne(int p_no) {
		return dao.getProjectOne(p_no);
	}

	@Override
	public int update(Project project) {
		return dao.update(project);
	}

	@Override
	public int delete(int p_no) {
		return dao.delete(p_no);
	}
	

}
