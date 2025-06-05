package com.example.feel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import com.example.feel.service.MemberService;
import com.example.feel.vo.Member;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserMemberController {

	@Autowired
	private MemberService memberService;

	// 회원가입 폼

	@RequestMapping("feelimals/member/join")
	public String showJoin() {
		return "feelimals/member/join";
	}

	// 회원가입

	@RequestMapping("feelimals/member/doJoin")
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String nickname) {
		memberService.doJoin(loginId, loginPw, nickname);
		return "feelimals/member/join";
	}
	
	// 로그인 폼
	
	@RequestMapping("feelimals/member/login")
	public String showLogin() {
		return "feelimals/member/login";
	}
	
	// 로그인
	
	@RequestMapping("feelimals/member/doLogin")
	public String doLogin(HttpServletRequest req, String loginId, String loginPw) {
		
		Member member = memberService.getMemberByLoginId(loginId);
		
		if (member == null || !member.getLoginPw().equals(loginPw)) {
			return "redirect:/member/login";
		}
		
		HttpSession session = req.getSession();
		session.setAttribute("loginedMemberId", member.getId());
		
		return "redirect:/";
	}

	// 로그아웃

	@RequestMapping("/feelimals/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		HttpSession session = req.getSession();
		session.removeAttribute("loginedMemberId");

		return "redirect:/";
	}

	

}
