package com.example.feel.controller;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.feel.service.DiaryService;
import com.example.feel.util.Ut;
import com.example.feel.vo.Diary;
import com.example.feel.vo.ResultData;
import com.example.feel.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class DiaryController {

	@Autowired
	private Rq rq;

	@Autowired
	private DiaryService diaryService;

	// 일기 작성 폼

	@RequestMapping("/feelimals/diary/write")
	public String showDiaryWrite() {
		return "feelimals/diary/write";
	}

	// 일기 작성

	@RequestMapping("/feelimals/diary/doWrite")
	public String doDiaryWrite(HttpServletRequest req, String body) {

		Rq rq = (Rq) req.getAttribute("rq");

		if (Ut.isEmptyOrNull(body)) {
			return rq.historyBackOnView("오늘 겪었던 일을 떠올려봐.");
		}

		diaryService.doDiaryWrite(rq.getLoginedMemberId(), body);
		return "redirect:/feelimals/diary/list";
	}

	// 일기 보기

	@RequestMapping("/feelimals/diary/detail")
	public String showDetail(HttpServletRequest req, Model model, @RequestParam(required = false) Integer id) {
		System.out.println("넘어온 id: " + id); // 확인 로그

		if (id == null) {
			return "feelimals/common/error"; // 임시 에러 페이지
		}

		Rq rq = (Rq) req.getAttribute("rq");

		Diary diary = diaryService.getForPrintDiary(rq.getLoginedMemberId(), id);

		if (diary == null) {
			return rq.historyBackOnView("존재하지 않는 일기야.");
		}

		model.addAttribute("diary", diary);

		return "feelimals/diary/detail";
	}

	// 일기 수정 폼

	@RequestMapping("/feelimals/diary/modify")
	public String showModify(HttpServletRequest req, Model model, int id) {
		Rq rq = (Rq) req.getAttribute("rq");

		Diary diary = diaryService.getForPrintDiary(rq.getLoginedMemberId(), id);

		if (diary == null) {
			return Ut.jsHistoryBack("", "권한이 없거나 존재하지 않는 일기야.");
		}

		model.addAttribute("diary", diary);

		return "feelimals/diary/modify";
	}

	// 일기 수정

	@RequestMapping("/feelimals/diary/doModify")
	@ResponseBody
	public String doModify(HttpServletRequest req, int id, String body) {
		Rq rq = (Rq) req.getAttribute("rq");

		Diary diary = diaryService.getDiaryById(id);

		if (diary == null) {
			return Ut.jsReplace("", "권한이 없거나 존재하지 않는 일기야.", "../diary/list");
		}

		ResultData userCanModifyRd = diaryService.userCanModify(rq.getLoginedMemberId(), diary);

		if (userCanModifyRd.isFail()) {
			return Ut.jsHistoryBack(userCanModifyRd.getResultCode(), userCanModifyRd.getMsg());
		}

		if (userCanModifyRd.isSuccess()) {
			diaryService.modifyDiary(id, body);
		}

		diary = diaryService.getDiaryById(id);

		return Ut.jsReplace("", "수정 완료했어.", "/feelimals/diary/detail?id=" + id);
	}

	// 일기 삭제

	@RequestMapping("/feelimals/diary/doDelete")
	@ResponseBody
	public String doDelete(HttpServletRequest req, int id) {

		Rq rq = (Rq) req.getAttribute("rq");

		Diary diary = diaryService.getDiaryById(id);

		if (diary == null) {
			return Ut.jsHistoryBack("F-1", Ut.f("%d번 게시글은 없습니다", id));
		}

		ResultData userCanDeleteRd = diaryService.userCanDelete(rq.getLoginedMemberId(), diary);

		if (userCanDeleteRd.isFail()) {
			return Ut.jsHistoryBack(userCanDeleteRd.getResultCode(), userCanDeleteRd.getMsg());
		}

		if (userCanDeleteRd.isSuccess()) {
			diaryService.deleteDiary(id);
		}

		return Ut.jsReplace("", "삭제했어.", "/feelimals/chatDiary/list");
	}

	/*
	 * @RequestMapping("feelimals/calendar") public String
	 * showCalendar(HttpServletRequest req, Model model) { // 필요한 데이터 불러오기 return
	 * "usr/calendar/calendar"; // ⇒ /WEB-INF/jsp/usr/calendar/calendar.jsp }
	 */

}
