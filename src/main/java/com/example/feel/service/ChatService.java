package com.example.feel.service;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

	private final RestTemplate restTemplate = new RestTemplate();

	ChatService(FeelimalsApplication feelimalsApplication) {
		this.feelimalsApplication = feelimalsApplication;
	}

	// 새 세션 만들기
	public int createNewChatSession(int memberId) {
		chatRepository.createNewChatSession(memberId);

		return chatRepository.getLastInsertId();
	}

	// 사용자 메시지 저장 (감정까지 저장)
	public int writeUserMessage(int memberId, int sessionId, String body, int emoTagId, boolean isUser,
			boolean thisChat) {
		chatRepository.writeUserMessage(memberId, sessionId, body, emoTagId, isUser, thisChat);
		return chatRepository.getLastInsertId();
	}

	// AI 응답 저장
	public void writeAiReply(int chatId, String reply, String model) {
		chatRepository.writeAiReply(chatId, reply, model);

	}

	// 1차- 감정 추출
	public String getEmotion(String body) {
		String flaskUrl = "http://localhost:5000/get-emotion";
		Map<String, String> requestBody = new HashMap<>(); // flask로 데이터를 보내기 위해
		requestBody.put("message", body);

		// JSON으로 POST
		String emotion = "무감정"; // 문제 발생시 무감정으로
		try {
			ResponseEntity<String> responseEntity = restTemplate.postForEntity(flaskUrl, requestBody, String.class);
			String rawBody = responseEntity.getBody();
			System.out.println("Flask 응답(raw): " + rawBody);

			JSONObject response = new JSONObject(rawBody);
			if (!response.has("emotion")) {
				System.out.println("경고: emotion 키 없음. 전체 응답: " + rawBody);
			}
			emotion = response.getString("emotion");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return emotion;
	}

	// 감정 이름으로 emoTagId 조회
	public int getEmoTagIdByEmotion(String emotion) {

		// int면 != null 불가능 -> Integer로 수정
		Integer id = chatRepository.getEmoTagIdByEmotion(emotion);

		// 못찾으면 0이나 예외 처리
		return id != null ? id : 5;
	}

	// 2차- 피드백 받기
	public String sendFeedback(String newBody, String emotion) {
		String flaskUrl = "http://localhost:5000/send-feedback";
		Map<String, String> requestBody = new HashMap<>(); // flask로 데이터를 보내기 위해
		requestBody.put("message", newBody);
		requestBody.put("emotion", emotion);

		// JSON으로 POST
		String feedback = "힘내!"; // 문제 발생시 무감정으로
		try {
			// 1. String으로 응답 받기
			ResponseEntity<String> responseEntity = restTemplate.postForEntity(flaskUrl, requestBody, String.class);
			String rawBody = responseEntity.getBody();
			System.out.println("Flask 응답(raw): " + rawBody); // <-- 이게 진짜 raw!

			// 2. 파싱해서 실제 사용
			JSONObject response = new JSONObject(rawBody);
			if (!response.has("feedback")) {
				System.out.println("경고: feedback 키 없음. 전체 응답: " + rawBody);
			}
			feedback = response.getString("feedback");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return feedback;
	}

	// 채팅 하나 조회
	public ChatSession getChatSessionById(int id) {
		return chatRepository.getChatSessionById(id);

	}

	// 채팅 불러오기
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

	public void doDeleteChatSession(int id) { // 세션과 채팅 db 둘 다 삭제
		chatRepository.doDeleteChatSession(id);
		chatRepository.doDeleteChatDiarySession(id);

	}

	// 삭제 가능??

	public ResultData userCanDeleteSession(int loginedMemberId, ChatSession session) {

		if (session.getMemberId() != loginedMemberId) {
			return ResultData.from("F-A", Ut.f("%d번 대화를 삭제 할 수 없어.", session.getId()));
		}

		return ResultData.from("S-1", Ut.f("%d번 대화를 삭제할 수 있어.", session.getId()));
	}

}
