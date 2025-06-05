package com.example.feel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	@RequestMapping("/feelimals/home/main")
	public String showMain() {
		return "feelimals/home/main";
	}
	
	@RequestMapping("/")
	public String showMain2() {
		return "redirect:/feelimals/home/main";
	}	
	
}
