package com.gant.myhome.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.gant.myhome.domain.Memo;

@Mapper
public interface MemoMapper {

	public List<Memo> getMemoList(String id);

	public int add(Memo memo);

	public Memo getMemoOne(int num);

	public int update(Memo memo);

	public int getMemoNum(String id);

	public int delete(int num);

}
