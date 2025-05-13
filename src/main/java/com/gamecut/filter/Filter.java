package com.gamecut.filter;

import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class Filter
 */
@WebFilter("*.do")
public class Filter extends HttpFilter implements javax.servlet.Filter {

    String arr[] = {
			"login.do",
            "joinUser.do", 
            "joinUserOK.do", 
            "idCheck.do", 
            "loginOK.do",
            "nicknameCheck.do",
            "resetPassword.do",
            "resetPasswordOK.do",
            "userInfoCheck.do"
    };

    /**
     * @see HttpFilter#HttpFilter()
     */
    public Filter() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see Filter#destroy()
     */
    public void destroy() {
        // TODO Auto-generated method stub
    }
    
	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		String uri = ((HttpServletRequest)request).getRequestURI();
		String cmd = uri.substring(uri.lastIndexOf("/")+1);
		int i = 0;
		for(i = 0; i<arr.length; i++) {
			if(cmd.equals(arr[i])) {
				break;
			}
		}
		if(i< arr.length) {
			chain.doFilter(request, response);
			return;
		}else {
			HttpSession session = ((HttpServletRequest)request).getSession();
			if(session.getAttribute("loginUSER") == null) {
				((HttpServletResponse)response).sendRedirect("login.do");
			}else {
				chain.doFilter(request, response);
			}
		}
	}

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }

}
