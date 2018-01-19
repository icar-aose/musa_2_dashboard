package org.login;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebFilter(urlPatterns= {"/admin/*","/devTeam/*","/customer/*","/super/*"})

public class LoginFilter implements Filter {
String addr,role;
    @Override
    public void init(FilterConfig config) throws ServletException {
        // If you have any <init-param> in web.xml, then you could get them
        // here by config.getInitParameter("name") and assign it as field.
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            addr="/login.jsp";
            System.out.println("NESSUNA SESSIONE");
            response.sendRedirect(request.getContextPath() + addr);
        } 
        else {
        role=session.getAttribute("role").toString();	
	        switch (role) {
	        
	            case "customer":  {
	            	if(request.getRequestURI().startsWith(request.getContextPath()+"/customer"))
	            		chain.doFilter(req, res);
	            	else {addr="/error.jsp";response.sendRedirect(request.getContextPath() + addr);}
	            	break;}  
	            
	            case "dev":  {
	            	if(request.getRequestURI().startsWith(request.getContextPath()+"/devTeam"))
	            		chain.doFilter(req, res);
	            	else {addr="/error.jsp";response.sendRedirect(request.getContextPath() + addr);}
	            	break;}  
	            
	            case "admin":  {
	            	if(request.getRequestURI().startsWith(request.getContextPath()+"/admin"))
	            		chain.doFilter(req, res);
	            	else {addr="/error.jsp";response.sendRedirect(request.getContextPath() + addr);}                
	            	break;}
	            case "super":  {chain.doFilter(req, res);break;}
	        }
        }        
    }

    @Override
    public void destroy() {
        // If you have assigned any expensive resources as field of
        // this Filter class, then you could clean/close them here.
    }
    
}