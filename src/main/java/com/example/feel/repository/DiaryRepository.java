package com.example.feel.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DiaryRepository {

	public void doDiaryWrite(int userId, String content);

}
