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
import com.example.feel.vo.ChatWithAi;
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
    public ResultData<ChatWithAi> doWrite(@RequestParam String body) {
        
    	// 사용자 찾기
    	int memberId = rq.getLoginedMemberId();
        
        // 1. 사용자 메시지 저장
        int chatId = chatService.writeUserMessage(memberId, body);
        
        // 2. Flask에 요청 보내기
        String answer = chatService.askToFlask(body);
        
        // 3. AI 응답 저장
        chatService.writeAiReply(chatId, answer, "gpt-3.5-turbo");
        
        // 4. 사용자 메시지 리턴
        ChatWithAi ChatWithAi = chatService.getChatWithAiByChatId(chatId);
        
        return ResultData.from("S-1", "AI 응답 완료", "chat", ChatWithAi);
    }

    // 리스트
    
   
    @GetMapping("/list")
    public String showList(Model model) {
        int memberId = rq.getLoginedMemberId();
        List<ChatWithAi> chatList = chatService.getChatWithAiListByMemberId(memberId);
        model.addAttribute("chats", chatList);
        return "feelimals/chat/list";
    }
    
    // 상세 화면
    
    @GetMapping("/detail")
    public String showDetail(@RequestParam int id, Model model) {
        int memberId = rq.getLoginedMemberId();
        ChatWithAi chat = chatService.getChatWithAiByChatId(id);
        model.addAttribute("chat", chat);
        return "feelimals/chat/detail";
    }
    
    @PostMapping("/modify")
    @ResponseBody
    public ResultData<?> doModify(@RequestParam int chatId, @RequestParam String newBody) {
        int memberId = rq.getLoginedMemberId();
        chatService.modifyChat(memberId, chatId, newBody);
        return ResultData.from("S-1", "수정 완료");
    }

    @PostMapping("/delete")
    @ResponseBody
    public ResultData<?> doDelete(@RequestParam int chatId) {
        int memberId = rq.getLoginedMemberId();
        chatService.deleteById(memberId, chatId);
        return ResultData.from("S-1", "삭제 완료");
    }
}
