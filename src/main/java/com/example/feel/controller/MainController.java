package com.example.feel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/feelimals")
public class MainController {

	@GetMapping("/question")
	public String question(Model model) {
		return "feelimals/question";
	}
	
}
