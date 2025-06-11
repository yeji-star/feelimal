package com.example.feel.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.feel.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

// Rq를 하나 만들어서, 로그인 로그아웃 관련해서 담당자

@Component
public class BeforeActionInterceptor implements HandlerInterceptor {

//	Rq rq = new Rq(req, resp); 이것과 같은 효과
	
	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		 req.setAttribute("rq", rq);
//		Rq rq = new Rq(req, resp);
		
		rq.initBeforeActionInterceptor();

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
