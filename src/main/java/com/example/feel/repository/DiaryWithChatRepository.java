package com.example.feel.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.feel.vo.Diary;
import com.example.feel.vo.DiaryWithChat;

@Mapper
public interface DiaryWithChatRepository {

	public List<DiaryWithChat> getForPrintDiaryWithChats(int memberId);

}
