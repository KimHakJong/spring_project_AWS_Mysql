package com.gant.myhome.service;


import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.gant.myhome.domain.Memo;
import com.gant.myhome.mybatis.mapper.MemoMapper;

@Service
public class MemoServiceImpl implements MemoService {

	private MemoMapper dao;
	
	@Autowired
	public MemoServiceImpl(MemoMapper dao) {
		this.dao = dao;
	}

	@Override
	public List<Memo> getMemoList(String id) {
		return dao.getMemoList(id);
	}

	@Override
	public int add(Memo memo) {
		return dao.add(memo);
	}

	@Override
	public Memo getMemoOne(int num) {
		return dao.getMemoOne(num);
	}

	@Override
	public int update(Memo memo) {
		Date date = new Date();
		SimpleDateFormat sd = new SimpleDateFormat("yyyyMMddHHmmss");
		memo.setUpdate_date(sd.format(date)); //수정날짜 업데이트
		return dao.update(memo);
	}

	@Override
	public int getMemoNum(String id) {
		return dao.getMemoNum(id);
	}

	@Override
	public int delete(int num) {
		return dao.delete(num);
	}
	
	

}
