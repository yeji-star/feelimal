package com.example.feel.service;

import java.time.LocalDateTime;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.example.feel.FeelimalsApplication;
import com.example.feel.repository.ChatRepository;
import com.example.feel.repository.DiaryRepository;
import com.example.feel.util.Ut;
import com.example.feel.vo.Chat;
import com.example.feel.vo.ChatSession;
import com.example.feel.vo.ChatWithAi;
import com.example.feel.vo.Diary;
import com.example.feel.vo.ResultData;

@Service
public class ChatService {

    private final FeelimalsApplication feelimalsApplication;

	@Autowired
	private ChatRepository chatRepository;

    ChatService(FeelimalsApplication feelimalsApplication) {
        this.feelimalsApplication = feelimalsApplication;
    }

	// 사용자 메시지 저장
	public int writeUserMessage(int memberId, int sessionId, String body) {
		boolean isChat = true;
		chatRepository.writeUserMessage(memberId, sessionId, body, true);
		return chatRepository.getLastInsertId();
	}

	// Flask 서버에 메시지 전달, 응답 받아오기
	public String askToFlask(String body) {

		RestTemplate restTemplate = new RestTemplate();
		String url = "http://localhost:5000/get-answer";

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		JSONObject requestJson = new JSONObject();
		requestJson.put("question", body);

		HttpEntity<String> entity = new HttpEntity<>(requestJson.toString(), headers);
		ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

		JSONObject jsonResponse = new JSONObject(response.getBody());
		return jsonResponse.getString("answer");
	}

	// AI 응답 저장
	public void writeAiReply(int chatId, String reply, String model) {
		chatRepository.writeAiReply(chatId, reply, model);

	}

	// 채팅 하나 조회
	public ChatSession getChatSessionById(int id) {
		return chatRepository.getChatSessionById(id);

	}

	// 봇 대화
	public List<ChatWithAi> getChatsWithAiBySessionId(int sessionId) {
		
		return chatRepository.getChatsWithAiBySessionId(sessionId);
	}

	// 사용자의 대화
	public List<ChatWithAi> getChatWithAiListByMemberId(int memberId) {
		
		return chatRepository.getChatWithAiListByMemberId(memberId);
	}

	// 대화 업데이트 (수정)
	public void modifyChat(int memberId, int chatId, String newBody) {
		chatRepository.modifyChat(memberId, chatId, newBody);

	}

	// 대화 삭제
	public void deleteById(int memberId, int chatId) {
		chatRepository.deleteById(memberId, chatId);

	}
	
	public void doDeleteChatSession(int id) {
		chatRepository.doDeleteChatSession(id);
		chatRepository.doDeleteChatDiarySession(id);

	}

	// 새 세션 만들기
	public int createNewChatSession(int memberId) {
		chatRepository.createNewChatSession(memberId);
		
		return chatRepository.getLastInsertId();
	}

	public void deleteChatSessionById(int sessionId) {
		// TODO Auto-generated method stub
		
	}
	
	// 삭제 가능??

	public ResultData userCanDeleteSession(int loginedMemberId, ChatSession session) {

		if (session.getMemberId() != loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 대화를 삭제 할 수 없어.", session.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 대화를 삭제할 수 있어.", session.getId()));
	}

}
