package com.example.feel.controller;


import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/feelimals")
public class QuestionController {

    @GetMapping("/ask")
    public String askGpt(Model model, @RequestParam String question) {
        RestTemplate restTemplate = new RestTemplate();
        String url = "http://localhost:5000/get-answer";

        // JSON으로 데이터를 보내고 받기 위한 설정
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        JSONObject requestJson = new JSONObject();
        requestJson.put("question", question);

        HttpEntity<String> entity = new HttpEntity<>(requestJson.toString(), headers);
        ResponseEntity<String> response = restTemplate.postForEntity(url, entity, String.class);

        // JSON 문자열로부터 JSONObject 생성
        JSONObject jsonResponse = new JSONObject(response.getBody());
        String answer = jsonResponse.getString("answer"); // 'answer' 키로부터 값을 가져옴

        model.addAttribute("answer", answer);
        return "feelimals/answer"; // Thymeleaf 템플릿 렌더링
    }
}
