package com.example.feel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.repository.DiaryWithChatRepository;
import com.example.feel.vo.DiaryWithChat;

@Service
public class DiaryWithChatService {

	@Autowired
	private DiaryWithChatRepository diaryWithChatRepository;
	
	public List<DiaryWithChat> getForPrintDiaryWithChats(int memberId) {
		return diaryWithChatRepository.getForPrintDiaryWithChats(memberId);
	}

}
