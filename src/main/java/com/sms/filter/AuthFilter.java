package com.sms.filter;

import com.sms.util.SessionUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * AuthFilter - Session validation filter
 * Ensures user is logged in before accessing protected pages
 */
@WebFilter(urlPatterns = {"/admin/*", "/student/*"})
public class AuthFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Check if user is logged in
        if (!SessionUtil.isLoggedIn(httpRequest)) {
            // Not logged in - redirect to login page
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login");
            return;
        }
        
        // User is logged in - continue
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
