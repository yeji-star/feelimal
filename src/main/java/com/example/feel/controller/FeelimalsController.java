package com.example.feel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class FeelimalsController {

	@RequestMapping("/feelimals/chat")
	public String showChat() {
		return "feelimals/chat";
	}
	
	@RequestMapping("/feelimals/diary")
	public String showDiary() {
		return "feelimals/diary";
	}
	
	@RequestMapping("/feelimals/calendar")
	public String showCalendar() {
		return "feelimals/calendar";
	}
	
	@RequestMapping("/feelimals/settings")
	public String showSettings() {
		return "feelimals/settings";
	}
	
}
