package com.example.feel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.util.Ut;
import com.example.feel.repository.MemberRepository;
import com.example.feel.vo.Member;
import com.example.feel.vo.ResultData;

@Service
public class MemberService {
	
	@Autowired
	private MemberRepository memberRepository;

	public ResultData<Integer> doJoin(String loginId, String loginPw, String nickname, String email) {

		Member existsMember = getMemberByLoginId(loginId);
		System.out.println("existsMember: " + existsMember);

		if (existsMember != null) {
			return ResultData.from("F-5", Ut.f("이미 사용중인 아이디(%s)야.", loginId));
		}


		memberRepository.doJoin(loginId, loginPw, nickname, email);

		int id = memberRepository.getLastInsertId();

		return ResultData.from("s-1", "환영해.", "가입 성공 id", id);
	}
	
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}

	public Member getMemberByLoginId(String loginId) {
		
		return memberRepository.getMemberByLoginId(loginId);
	}

	

}
