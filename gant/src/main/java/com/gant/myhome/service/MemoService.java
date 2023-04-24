package com.gant.myhome.service;

import java.util.List;

import com.gant.myhome.domain.Memo;

public interface MemoService {

	public List<Memo> getMemoList(String id);

	public int add(Memo memo);

	public Memo getMemoOne(int num);

	public int update(Memo memo);

	public int getMemoNum(String id);

	public int delete(int num);


	
}
