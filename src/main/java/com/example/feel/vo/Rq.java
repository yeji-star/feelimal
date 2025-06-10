package com.example.feel.vo;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.example.feel.service.MemberService;
import com.example.feel.util.Ut;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import lombok.Getter;
import lombok.Setter;

// 로그인 총괄 담당

//Before~~를 바꿔서 등록을 한번 해줌 (얘만 하면 오류가 다른 게 나기 때문에 후처리필요)
// 그래서 Scope~~ 를 써야함
@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
@Getter
@Setter
public class Rq {

	@Autowired
	private MemberService memberService;

	private final HttpServletRequest req;
	private final HttpServletResponse resp;
	private final HttpSession session;

	private boolean isLogined = false;

	private int loginedMemberId = 0;

	private Member loginedMember;

	public Rq(HttpServletRequest req, HttpServletResponse resp) {
		this.req = req;
		this.resp = resp;
		this.session = req.getSession();
		
		System.out.println("🟠 Rq 생성됨");
	    System.out.println("세션에 loginedMemberId = " + session.getAttribute("loginedMemberId"));

		if (session.getAttribute("loginedMemberId") != null) {

			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");

		}

		this.req.setAttribute("rq", this);
	}

	public void printHistoryBack(String msg) throws IOException {
		resp.setContentType("text/html; charset=UTF-8");

		println("<script>");

		if (!Ut.isEmpty(msg)) {
			println("alert('" + msg.replace("'", "\\'") + "');");

		}

		println("history.back()");
		println("</script>");
		resp.getWriter().flush();
		resp.getWriter().close();

	}

	private void println(String str) throws IOException {
		print(str + "\n");

	}

	private void print(String str) throws IOException {
		resp.getWriter().append(str);

	}

	public void logout() {
		session.removeAttribute("loginedMemberId");

	}

	public void login(Member member) {
		System.out.println("✅ rq.login() 호출됨, id = " + member.getId());
		session.setAttribute("loginedMemberId", member.getId());
		System.out.println("✅ 세션 저장 완료: " + session.getAttribute("loginedMemberId"));

	}

	public void initBeforeActionInterceptor() {
		System.err.println("initBeforeActionInterceptor 실행됨");

	}

	public String historyBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "/feelimals/common/js";
	}

	public String jsReturnOnView(String msg, String replaceUri) { // js 리턴용
		req.setAttribute("msg", msg);
		req.setAttribute("replaceUri", replaceUri);
		req.setAttribute("historyBack", false);
		return "/feelimals/common/js"; 
	}

	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		System.out.println(currentUri);
		System.out.println(queryString);

		if (currentUri != null && queryString != null) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}

	public Member getLoginedMember() {
		if (!isLogined)
			return null;
		if (loginedMember == null) {
			loginedMember = memberService.getMemberById(loginedMemberId);
		}
		return loginedMember;
	}

}
