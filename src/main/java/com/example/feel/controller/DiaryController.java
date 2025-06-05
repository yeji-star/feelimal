package com.example.feel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.example.feel.service.DiaryService;

import jakarta.servlet.http.HttpSession;

@Controller
public class DiaryController {

	@Autowired
	private DiaryService diaryService;
	
	@RequestMapping("/feelimals/diary/write")
	public String showDiaryWrite() {
		return "feelimals/diary/write";
	}
	
	@RequestMapping("/feelimals/diary/doWrite")
	public String doDiaryWrite(String content, HttpSession session) {
		
		int userId = (int) session.getAttribute("loginedMemberId");
		diaryService.doDiaryWrite(userId, content);
		
		return "redirect:/diary/list";
	}
	
}
