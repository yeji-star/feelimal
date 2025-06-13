package com.example.feel.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.example.feel.vo.Calendar;

@Mapper
public interface CalendarRepository {

	public List<Calendar> getAllForCalendar(int memberId);

	public Calendar getCalendarById(int id);

	public void modifyCalendar(@Param("id") int id, @Param("body") String body, @Param("emoTagId") int emoTagId);

	public void deleteCalendar(int id);
}
