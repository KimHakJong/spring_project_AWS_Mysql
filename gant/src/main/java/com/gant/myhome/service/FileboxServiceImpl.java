package com.gant.myhome.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.FFolder;
import com.gant.myhome.domain.Filebox;
import com.gant.myhome.mybatis.mapper.FileboxMapper;

@Service
public class FileboxServiceImpl implements FileboxService {
	
	private FileboxMapper dao;

	@Autowired
	public FileboxServiceImpl(FileboxMapper dao) {
		this.dao = dao;
	}

	@Override
	public int insert(Filebox filebox) {
		
		return dao.insert(filebox);
	}

	@Override
	public List<Map<String, Object>> selectFile(Map<String, Integer> param_map) {
		return dao.selectFile(param_map);
	}

	@Override
	public String selectUploader(int num) {
		return dao.selectUploader(num);
	}
	
	@Override
	public int delete(int num) {
		return dao.delete(num);
	}

	@Override
	public int deleteFileinFolder(FFolder ffolder) {
		return dao.deleteFileinFolder(ffolder);
	}


	
}
