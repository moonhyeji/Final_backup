package com.kh.bnpp.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LoginInterceptor implements HandlerInterceptor {

private Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);
	
	//spring 3.2 이상부터는 servlet-context.xml에서 <exclude-mapping-path>를 통해 설정 가능!
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("[Interceptor] : preHandle");
		
		if(request.getRequestURI().contains("/loginform.do") || 	
		   request.getRequestURI().contains("/ajaxlogin.do") || 
		  //  request.getSession().getAttribute("login") != null 	||	
		   request.getRequestURI().contains("/test.do")			||
		   request.getRequestURI().contains("/registerform.do")	||
		   request.getRequestURI().contains("/register.do")		||
		   request.getRequestURI().contains("/home.do")  ||
		   request.getRequestURI().contains("/machine.do") 
		   //interceptor의 설정에서  /* 로 설정해두었기 때문에 /machine.do를 읽고싶은데 없어서 404 에러뜸. 
			) {
		return true;
		}
		
		if(request.getSession().getAttribute("login") == null) {	
			response.sendRedirect("loginform.do");
		}
		
		return false;
	}
//컨트롤러 메소드 실행 직후에 실행 됩니다. View 페이지가 렌더링 되기전에 ModelAndView 객체를 조작 
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("[Interceptor] : postHandle");

		if(modelAndView != null) {											
			logger.info("Target View : " + modelAndView.getViewName());
		}	
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("[Interceptor] : afterCompletion");

	}
}
