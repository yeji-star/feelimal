package com.example.feel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.repository.DiaryRepository;
import com.example.feel.util.Ut;
import com.example.feel.vo.Diary;
import com.example.feel.vo.ResultData;

@Service
public class DiaryService {
	
	@Autowired
	private DiaryRepository diaryRepository;

	public ResultData doDiaryWrite(int memberId, String body) {
		diaryRepository.doDiaryWrite(memberId, body);

		int id = diaryRepository.getLastInsertId();

		return ResultData.from("S-1", "이런 일이 있었구나.", "등록된 일기장 id", id);
		
	}

	public Diary getDiaryById(int id) {
		return diaryRepository.getDiaryById(id);
	}

	public List<Diary> getForPrintDiaries(int userId) {
		return diaryRepository.getForPrintDiaries(userId);
	}

	public Diary getForPrintDiary(int loginedMemberId, int id) {
		Diary diary = diaryRepository.getForPrintDiary(id);

		controlForPrintData(loginedMemberId, diary);

		return diary;
	}

	private void controlForPrintData(int loginedMemberId, Diary diary) {
		if (diary == null) {
			return;
		}

		ResultData userCanModifyRd = userCanModify(loginedMemberId, diary);
		diary.setUserCanModify(userCanModifyRd.isSuccess());

		ResultData userCanDeleteRd = userCanDelete(loginedMemberId, diary);
		diary.setUserCanDelete(userCanDeleteRd.isSuccess());
		
	}

	public ResultData userCanModify(int loginedMemberId, Diary diary) {
		if (diary.getMemberId() != loginedMemberId) {
			return ResultData.from("F-1", "이 일기는 수정할 수 없어.");
		}

		return ResultData.from("S-1", "수정 가능해.");
	}

	public void modifyDiary(int id, String body) {
		diaryRepository.modifyDiary(id, body);
		
	}

	public ResultData userCanDelete(int loginedMemberId, Diary diary) {
		if (diary.getMemberId() != loginedMemberId) {
			return ResultData.from("F-1", "이 일기는 삭제할 수 없어.");
		}

		return ResultData.from("S-1", "삭제 가능해.");
	}

	public void deleteDiary(int id) {
		diaryRepository.deleteDiary(id);
		
	}
	
	public List<Diary> getAllDiaries() {
        return diaryRepository.getAllDiaries();
    }

}
