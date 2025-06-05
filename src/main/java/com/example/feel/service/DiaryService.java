package com.example.feel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.repository.DiaryRepository;

@Service
public class DiaryService {
	
	@Autowired
	private DiaryRepository diaryRepository;

	public void doDiaryWrite(int userId, String content) {
		diaryRepository.doDiaryWrite(userId, content);
		
	}

}
