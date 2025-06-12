package com.example.feel.controller;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import com.example.feel.service.DiaryService;
import com.example.feel.vo.Diary;

@RestController
@RequestMapping("/calendar")
public class CalendarController {

    @Autowired
    private DiaryService diaryService;

    @GetMapping("/entries")
    public List<Map<String, Object>> getDiaryEntries() {
        List<Diary> diaries = diaryService.getAllDiaries();

        List<Map<String, Object>> result = new ArrayList<>();
        for (Diary diary : diaries) {
            Map<String, Object> item = new HashMap<>();
            item.put("title", diary.getBody().length() > 15 ? diary.getBody().substring(0, 15) + "..." : diary.getBody());
            item.put("start", diary.getRegDate().substring(0, 10)); // yyyy-MM-dd
            item.put("url", "/feelimals/diary/detail?id=" + diary.getId());
            result.add(item);
        }

        return result;
    }
}
