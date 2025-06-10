package com.example.feel.interceptor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.example.feel.util.Ut;
import com.example.feel.vo.ResultData;
import com.example.feel.vo.Rq;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Component
public class NeedLogoutInterceptor implements HandlerInterceptor {

	@Autowired
	private Rq rq;

	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {

//		Rq rq = (Rq) req.getAttribute("rq");

		if (rq.isLogined()) {

			rq.printHistoryBack("로그아웃해줘.");

			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}
}
