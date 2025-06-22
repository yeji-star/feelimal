package com.example.feel.controller;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import com.example.feel.service.CalendarService;
import com.example.feel.util.Ut;
import com.example.feel.vo.Calendar;
import com.example.feel.vo.ResultData;
import com.example.feel.vo.Rq;

@Controller
public class CalendarController {

	@Autowired
	private CalendarService calendarService;

	@Autowired
	private Rq rq;

	@GetMapping("/feelimals/calendar/events")
	@ResponseBody
	public ResultData<List<Map<String, Object>>> getCalendarEvents() {
		int memberId = rq.getLoginedMemberId();

		List<Calendar> entries = calendarService.getAllForCalendar(memberId);
		List<Map<String, Object>> result = new ArrayList<>();

		for (Calendar d : entries) {
			Map<String, Object> item = new HashMap<>();
			item.put("id", d.getId());
			item.put("start", d.getRegDate().substring(0, 10));
			item.put("emoji", getEmoji(d.getEmoTagId()));
			item.put("type", d.isChat() ? "chat" : "diary");
			item.put("body", trim(d.getBody()));
			item.put("url", d.isChat()
			    ? "/feelimals/chat/detail?id=" + d.getId()
			    : "/feelimals/diary/detail?id=" + d.getId());

			result.add(item);
		}

		return ResultData.from("S-1", "캘린더 이벤트 로딩 성공", "events", result);
	}

	private String getEmoji(int emoId) {
		return switch (emoId) {
			case 1 -> "😐";
			case 2 -> "😊";
			case 3 -> "😢";
			case 4 -> "😠";
			case 5 -> "😱";
			default -> "🐾";
		};
	}

	private String trim(String body) {
		if (Ut.isEmptyOrNull(body)) return "";
		return body.length() > 10 ? body.substring(0, 10) + "..." : body;
	}
}
