package com.example.feel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.feel.repository.MemberRepository;
import com.example.feel.vo.Member;

@Service
public class MemberService {
	
	@Autowired
	private MemberRepository memberRepository;

	public void doJoin(String loginId, String loginPw, String nickname) {
		memberRepository.doJoin(loginId, loginPw, nickname);
		
	}

	public Member getMemberByLoginId(String loginId) {
		
		return memberRepository.getMemberByLoginId(loginId);
	}

}
