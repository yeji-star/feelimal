package com.example.feel.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.feel.service.DiaryWithChatService;
import com.example.feel.vo.DiaryWithChat;
import com.example.feel.vo.Rq;

@Controller
@RequestMapping("/feelimals/chatDiary")
public class DiaryWithChatController {

	@Autowired
	private Rq rq;
	
	@Autowired
	private DiaryWithChatService diaryWithChatService;
	
	// 일기와 대화를 합쳐서 보여줌 
	
	@GetMapping("/list")
	public String showList(Model model) {
		int memberId = rq.getLoginedMemberId();
		List<DiaryWithChat> items = diaryWithChatService.getForPrintDiaryWithChats(memberId);
		
	    LocalDate now = LocalDate.now();
	    model.addAttribute("year", now.getYear());
	    model.addAttribute("month", now.getMonthValue());
		
		model.addAttribute("items", items);
		return "feelimals/chatDiary/list";
	}
	
}
