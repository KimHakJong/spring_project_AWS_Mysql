package com;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import com.gant.myhome.security.CustomAccessDeniedHandler;
import com.gant.myhome.security.CustomUserDetailsService;
import com.gant.myhome.security.LoginFailHandler;
import com.gant.myhome.security.LoginSuccessHandler;

@EnableWebSecurity // 스프링 시큐리티 결합
@Configuration
public class SecuerityConfig extends WebSecurityConfigurerAdapter {
    
	// <security:http> 설정 부분
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		//네이버 에디터를 사용하기위한 코드 
		http.headers().frameOptions().sameOrigin();   
		
		
		http.authorizeRequests()
		          .antMatchers("/resources/**/**").permitAll()
		          .antMatchers("/member/login").permitAll()
		          .antMatchers("/member/join").permitAll()
		          .antMatchers("/member/idcheck").permitAll()
		          .antMatchers("/member/sendCert").permitAll()
		          .antMatchers("/member/joinProcess").permitAll()
		          .antMatchers("/member/findid").permitAll()
		          .antMatchers("/member/findidok").permitAll()
		          .antMatchers("/member/findpass").permitAll()
		          .antMatchers("/member/findpassok").permitAll()
		          .antMatchers("/member/findpassokProcess").permitAll()
		          .antMatchers("/member/info").access("hasRole('ROLE_ADMIN')")
		          .antMatchers("/request/getAdmin").access("hasRole('ROLE_ADMIN')")
		          .antMatchers("/**").access("hasAnyRole('ROLE_MEMBER','ROLE_ADMIN')");
		     
		
		http.formLogin().loginPage("/member/login")
		                .loginProcessingUrl("/member/loginProcess")
		                .usernameParameter("id")
		                .passwordParameter("password")
		                .successHandler(loginSuccessHandler())
		                .failureHandler(loginFailureHandler());
	

		/*
		 1. logoutSuccessUrl : 로그인 후 이동할 주소
		 2. logoutUrl (여기서 처리하기 때문에 컨트롤러 logout 제거합니다. post방식을 요구합니다.
		 3. invalidateHttpSession : 로그아웃시 세션 속성들 제거
		 4. deleteCookies : 쿠키 제거
		*/
		
	http.logout().logoutSuccessUrl("/member/login")
	    .logoutUrl("/member/logout")
	    .invalidateHttpSession(true)
	    .deleteCookies("remember-me" , "JSESSION_ID" , "store");
	
	
	http.rememberMe()
	    .rememberMeParameter("remember-me")
	    .rememberMeCookieName("remember-me")
	    .tokenValiditySeconds(21600); //6시간 쿠키유지
	
	http.exceptionHandling().accessDeniedHandler(accessDeniedHandler());
	
	}

	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());
	}
	
	
	//로그인 성공시 실행할 객체 생성
	@Bean
	public AuthenticationSuccessHandler loginSuccessHandler() {
		return new LoginSuccessHandler(); // 패키지명 com.gant.security에 존재하는 모든 클래스 파일이 @Service 없애주세요
	}
	
	
	/*
	 1. UserDetailsService 인터페이스는 DB에서 유저 정보를 불러오는 loadUserByUsername()가 존재합니다.
	 이를 구현하는 클래스는 DB에서 유저 정보를 가져와서 UserDetails 타입으로 리턴해주는 작업을 합니다.
	 */
	
	@Bean  
	public UserDetailsService customUserService() {			
		return new CustomUserDetailsService(); // 패키지명 com.gant.security에 존재하는 모든 클래스 파일이 @Service 없애주세요
	} 
	
	@Bean			
	public PasswordEncoder passwordEncoder() {			
		return new BCryptPasswordEncoder();
	}
	
	
	@Bean
	public AccessDeniedHandler accessDeniedHandler() {
		return new CustomAccessDeniedHandler();
	}
	
	@Bean
	public AuthenticationFailureHandler loginFailureHandler() {
		return new LoginFailHandler();
	}
	
}
