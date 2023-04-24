package com.gant.myhome.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;


//AuthenticationSuccessHandler : 사용자 인증이 성공 후 처리할 작업을 직접 작성할 때 사용하는 인터페이스 입니다.
//@Service
public class LoginSuccessHandler implements AuthenticationSuccessHandler {

	
	private static final Logger logger = LoggerFactory.getLogger(LoginSuccessHandler.class);
	
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		logger.info("로그인 성공 : LoginSuccessHandler");
		
		//request getparameter 스토어값 가져오는지 확인
		logger.info("ID저장값가져옴:"+request.getParameter("store"));
		String IDStore = request.getParameter("store");
		Cookie cookie = new Cookie("store", IDStore); //ID저장 쿠키
		
		if(IDStore != null) {
			cookie.setMaxAge(60*60*24); //쿠키 유효시간 24시간
			response.addCookie(cookie);//클라이언트로 쿠키값 전송
			logger.info("ID저장 쿠키생성");
		}else if(IDStore == null || IDStore.equals("")){
			cookie.setMaxAge(0); //쿠키 유효시간 0
			response.addCookie(cookie);//클라이언트로 쿠키값 전송
		}
		
		String url = request.getContextPath()+"/pmain/view";
		response.sendRedirect(url);
		
	}

}
