package com.example.feel.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface DiaryRepository {

	void doDiaryWrite(int userId, String content);

}
