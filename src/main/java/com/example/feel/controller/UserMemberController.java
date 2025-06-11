package com.example.feel.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.feel.vo.ResultData;
import com.example.feel.service.MemberService;
import com.example.feel.util.Ut;
import com.example.feel.vo.Member;
import com.example.feel.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserMemberController {

	@Autowired
	private MemberService memberService;

	@Autowired
	private Rq rq;

	// 회원가입 폼

	@RequestMapping("/feelimals/member/join")
	public String showJoin() {
		return "feelimals/member/join";
	}

	// 회원가입

	@RequestMapping("/feelimals/member/doJoin")
	@ResponseBody
	public String doJoin(HttpServletRequest req, String loginId, String loginPw, String nickname, String email) {

		if (Ut.isEmptyOrNull(loginId)) {

			return Ut.jsHistoryBack(null, "아이디를 입력해줘.");
		}

		if (Ut.isEmptyOrNull(loginPw)) {

			return Ut.jsHistoryBack(null, "비밀번호를 입력해줘.");
		}

		if (Ut.isEmptyOrNull(nickname)) { // 근데 닉네임은... 공백으로 두면 자동으로 "사용자" 로 되게 하는 것도... 흠...

			return Ut.jsHistoryBack(null, "닉네임을 입력해줘.");
		}

		if (Ut.isEmptyOrNull(email)) {
			;
			return Ut.jsHistoryBack(null, "이메일을 입력해줘.");
		}

		ResultData<Integer> joinRd = memberService.doJoin(loginId, loginPw, nickname, email);

		if (joinRd.isFail()) {
			return Ut.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		Member member = memberService.getMemberById((int) joinRd.getData1());

		rq.login(member);

		return Ut.jsReplace(null, Ut.f("환영해, %s", member.getNickname()), "/feelimals/home/main");
	}

	// 로그인 폼

	@RequestMapping("/feelimals/member/login")
	public String showLogin() {
		return "feelimals/member/login";
	}

	// 로그인

	@RequestMapping("/feelimals/member/doLogin")
	@ResponseBody
	public String doLogin(HttpServletRequest req, String loginId, String loginPw,
			@RequestParam(defaultValue = "/") String afterLoginUri) {

		if (Ut.isEmptyOrNull(loginId)) {
			return Ut.jsHistoryBack(null, "아이디를 입력해줘.");
		}

		if (Ut.isEmptyOrNull(loginPw)) {
			return Ut.jsHistoryBack(null, "비밀번호를 입력해줘.");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack(null, Ut.f("%s는(은) 없는 아이디야.", loginId));
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack(null, "비밀번호가 일치 않아.");
		}

		rq.login(member);

		return Ut.jsReplace(null, Ut.f("어서와, %s", member.getNickname()), afterLoginUri);
	}

	// 로그아웃

	@RequestMapping("/feelimals/member/doLogout")
	@ResponseBody
	public String doLogout(HttpServletRequest req) {

		// 로그인 로그아웃때문에 하나 불러와야함
		Rq rq = (Rq) req.getAttribute("rq");

		rq.logout();

		return Ut.jsReplace(null, "다음에 또 봐.", "/");
	}

}
