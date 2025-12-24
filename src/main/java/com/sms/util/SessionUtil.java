package com.sms.util;

import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

/**
 * Session Utility Class
 * Manages user sessions and role-based access
 */
public class SessionUtil {
    
    // Session attribute names
    public static final String SESSION_USER_ID = "userId";
    public static final String SESSION_USER_EMAIL = "userEmail";
    public static final String SESSION_USER_ROLE = "userRole";
    public static final String SESSION_STUDENT_ID = "studentId";
    public static final String SESSION_STUDENT_NAME = "studentName";
    
    /**
     * Create user session after successful login
     */
    public static void createSession(HttpServletRequest request, int userId, String email, String role) {
        HttpSession session = request.getSession(true);
        session.setAttribute(SESSION_USER_ID, userId);
        session.setAttribute(SESSION_USER_EMAIL, email);
        session.setAttribute(SESSION_USER_ROLE, role);
        session.setMaxInactiveInterval(30 * 60); // 30 minutes
    }
    
    /**
     * Create student session with additional student details
     */
    public static void createStudentSession(HttpServletRequest request, int userId, String email, 
                                           String role, int studentId, String studentName) {
        createSession(request, userId, email, role);
        HttpSession session = request.getSession(false);
        session.setAttribute(SESSION_STUDENT_ID, studentId);
        session.setAttribute(SESSION_STUDENT_NAME, studentName);
    }
    
    /**
     * Check if user is logged in
     */
    public static boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute(SESSION_USER_ID) != null;
    }
    
    /**
     * Get user ID from session
     */
    public static Integer getUserId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Integer) session.getAttribute(SESSION_USER_ID);
        }
        return null;
    }
    
    /**
     * Get user email from session
     */
    public static String getUserEmail(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute(SESSION_USER_EMAIL);
        }
        return null;
    }
    
    /**
     * Get user role from session
     */
    public static String getUserRole(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (String) session.getAttribute(SESSION_USER_ROLE);
        }
        return null;
    }
    
    /**
     * Get student ID from session
     */
    public static Integer getStudentId(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            return (Integer) session.getAttribute(SESSION_STUDENT_ID);
        }
        return null;
    }
    
    /**
     * Check if user is admin
     */
    public static boolean isAdmin(HttpServletRequest request) {
        String role = getUserRole(request);
        return "ADMIN".equals(role);
    }
    
    /**
     * Check if user is student
     */
    public static boolean isStudent(HttpServletRequest request) {
        String role = getUserRole(request);
        return "STUDENT".equals(role);
    }
    
    /**
     * Invalidate session (logout)
     */
    public static void invalidateSession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }
}
