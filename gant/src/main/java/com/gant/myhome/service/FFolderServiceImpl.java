package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.FFolder;
import com.gant.myhome.mybatis.mapper.FFolderMapper;

@Service
public class FFolderServiceImpl implements FFolderService {
	
	private FFolderMapper dao;
	
	@Autowired
	public FFolderServiceImpl(FFolderMapper dao) {
		this.dao = dao;
	}

	@Override
	public int selectCount(int p_no) {
		return dao.selectCount(p_no);
	}


	@Override
	public int insert(FFolder ffolder) {
		return dao.insert(ffolder);
	}

	@Override
	public FFolder selectFirst(int p_no) {
		return dao.selectFirst(p_no);
	}

	@Override
	public List<FFolder> selectSubFolder(FFolder ffolder) {
		return dao.selectSubFolder(ffolder);
	}

	@Override
	public int update(Map<String, Object> map) {
		return dao.update(map);
	}

	@Override
	public int delete(FFolder ffolder) {
		return dao.delete(ffolder);
	}

	@Override
	public int updateLocation(Map<String, Object> map) {
		return dao.updateLocation(map);
	}

	@Override
	public int updatePathFromEdit(Map<String, Object> map) {
		return dao.updatePathFromEdit(map);
	}

}
