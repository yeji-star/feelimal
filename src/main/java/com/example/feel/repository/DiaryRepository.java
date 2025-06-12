package com.example.feel.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.feel.vo.Diary;

@Mapper
public interface DiaryRepository {

	public int doDiaryWrite(int memberId, String body);

	public int getLastInsertId();

	public Diary getDiaryById(int id);

	public List<Diary> getForPrintDiaries(int userId);

	public Diary getForPrintDiary(int id);

	public void modifyDiary(int id, String body);

	public void deleteDiary(int id);
	
	public List<Diary> getAllDiaries();

}
