package com.example.feel.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.repository.ChatRepository;
import com.example.feel.repository.DiaryRepository;
import com.example.feel.util.Ut;
import com.example.feel.vo.Chat;
import com.example.feel.vo.ChatWithAi;
import com.example.feel.vo.Diary;
import com.example.feel.vo.ResultData;

@Service
public class ChatService {

    @Autowired
    private ChatRepository chatRepository;

    // 사용자 메시지 저장
	public int writeUserMessage(int memberId, String body) {
		chatRepository.writeUserMessage(memberId, body, true);
		return chatRepository.getLastInsertId();
	}

	// AI 응답 저장
	public void writeAiReply(int chatId, String reply, String model) {
		chatRepository.writeAiReply(chatId, reply, model);
		
	}
	
	// 채팅 하나 조회
	public Chat getChatById(int chatId) {
		return chatRepository.getChatById(chatId);
	
	}

	public List<Chat> getListByMemberId(int memberId) {
		return chatRepository.getListByMemberId(memberId);
	}

	public ChatWithAi getChatWithAiByChatId(int chatId) {
		// TODO Auto-generated method stub
		return null;
	}

	public List<ChatWithAi> getChatWithAiListByMemberId(int memberId) {
		// TODO Auto-generated method stub
		return null;
	}

	public void modifyChat(int memberId, int chatId, String newBody) {
		// TODO Auto-generated method stub
		
	}

	public void deleteById(int memberId, int chatId) {
		// TODO Auto-generated method stub
		
	}
}
	


