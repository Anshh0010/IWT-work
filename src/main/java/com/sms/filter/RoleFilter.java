package com.sms.filter;

import com.sms.util.SessionUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * RoleFilter - Role-based access control
 * Ensures users can only access pages for their role
 */
@WebFilter(urlPatterns = {"/admin/*", "/student/*"})
public class RoleFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization logic if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check role-based access
        if (requestURI.startsWith(contextPath + "/admin/")) {
            // Admin pages - only admin can access
            if (!SessionUtil.isAdmin(httpRequest)) {
                httpResponse.sendRedirect(contextPath + "/student/dashboard");
                return;
            }
        } else if (requestURI.startsWith(contextPath + "/student/")) {
            // Student pages - only students can access
            if (!SessionUtil.isStudent(httpRequest)) {
                httpResponse.sendRedirect(contextPath + "/admin/dashboard");
                return;
            }
        }
        
        // Allowed - continue
        chain.doFilter(request, response);
    }
    
    @Override
    public void destroy() {
        // Cleanup logic if needed
    }
}
