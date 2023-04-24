package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.FFileinfo;
import com.gant.myhome.domain.FFolder;
import com.gant.myhome.mybatis.mapper.FFileinfoMapper;

@Service
public class FFileinfoServiceImpl implements FFileinfoService {
	
	private FFileinfoMapper dao;

	@Autowired
	public FFileinfoServiceImpl(FFileinfoMapper dao) {
		this.dao = dao;
	}

	@Override
	public int insert(FFileinfo ffileinfo) {
		return dao.insert(ffileinfo);
	}


	@Override
	public int update(Map<String, Object> map) {
		return dao.update(map);
	}

	@Override
	public List<FFileinfo> selectAllFileInFolder(FFolder ffolder) {
		return dao.selectAllFileInFolder(ffolder);
	}

	@Override
	public int updateLocation(Map<String, Object> map) {
		return dao.updateLocation(map);
	}

	@Override
	public int updatePathFromEdit(Map<String, Object> map) {
		return dao.updatePathFromEdit(map);
	}

	@Override
	public int updateLocationByFolder(Map<String, Object> map) {
		return dao.updateLocationByFolder(map);
	}

}
