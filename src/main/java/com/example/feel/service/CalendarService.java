package com.example.feel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.repository.CalendarRepository;
import com.example.feel.vo.Calendar;

@Service
public class CalendarService {

	@Autowired
	private CalendarRepository calendarRepository;

	public List<Calendar> getAllForCalendar(int memberId) {
		return calendarRepository.getAllForCalendar(memberId);
	}

	// ✅ 일정 1건 상세 조회
	public Calendar getCalendarById(int id) {
		return calendarRepository.getCalendarById(id);
	}

	// ✅ 일정 수정
	public void modifyCalendar(int id, String body, int emoTagId) {
		calendarRepository.modifyCalendar(id, body, emoTagId);
	}

	// ✅ 일정 삭제
	public void deleteCalendar(int id) {
		calendarRepository.deleteCalendar(id);
	}
}
