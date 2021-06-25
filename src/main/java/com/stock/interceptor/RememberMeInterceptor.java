package com.stock.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;
import org.springframework.web.util.WebUtils;

import com.stock.domain.UserVo;
import com.stock.service.UserService;



@Component
public class RememberMeInterceptor extends HandlerInterceptorAdapter{

	@Autowired
	private UserService service;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		HttpSession session = request.getSession();
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		if(loginCookie != null) {
			System.out.println("쿠키값이 있습니다.조회합니다."+loginCookie.getValue());
			UserVo vo = service.checkLoginBefore(loginCookie.getValue());
			System.out.println("vo---" + vo);
			if(vo != null) {
				session.setAttribute("userId", vo.getUserId());
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('자동 로그인 성공'); location.href='/notices/list';</script>");
				out.flush();
			}
		}
		
		return true;
	}
	
	
}
