package com.example.feel.controller;


import java.time.LocalDate;
import java.util.List;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;

import com.example.feel.service.ChatService;
import com.example.feel.service.DiaryService;
import com.example.feel.util.Ut;
import com.example.feel.vo.Chat;
import com.example.feel.vo.Diary;
import com.example.feel.vo.ResultData;
import com.example.feel.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/feelimals/chat")
public class ChatController {

	@Autowired
	private Rq rq;
	
    @Autowired
    private ChatService chatService;

    @PostMapping("")
    @ResponseBody
    public ResultData<Chat> doWrite(@RequestParam String body) {
        int memberId = rq.getLoginedMemberId();
        
        // 1. 사용자 메시지 저장
        int chatId = chatService.writeUserMessage(memberId, body);
        
        // 2. Flask 서버에 메시지 전달
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:5000/get-answer";
        
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        
        JSONObject requestJson = new JSONObject();
        requestJson.put("question", body);
        
        HttpEntity<String> entity = new HttpEntity<>(requestJson.toString(), headers);
        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);
        
        JSONObject jsonResponse = new JSONObject(response.getBody());
        String answer = jsonResponse.getString("answer");
        
        // 3. AI 응답 저장
        chatService.writeAiReply(chatId, answer, "gpt-3.5-turbo");
        
        // 4. 사용자 메시지 리턴
        Chat userChat = chatService.getChatById(chatId);
        
        return ResultData.from("S-1", "AI 응답 완료", "chat", userChat);
    }

    @GetMapping("/list")
    public String showList(Model model) {
        int memberId = rq.getLoginedMemberId();
        List<Chat> chatList = chatService.getListByMemberId(memberId);
        model.addAttribute("chats", chatList);
        return "feelimals/chat/list";
    }
}
