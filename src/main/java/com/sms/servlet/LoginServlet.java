package com.sms.servlet;

import com.sms.dao.StudentDAO;
import com.sms.dao.UserDAO;
import com.sms.model.Student;
import com.sms.model.User;
import com.sms.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * LoginServlet - Handles user authentication
 * Supports both login and logout functionality
 */
@WebServlet(urlPatterns = {"/login", "/logout"})
public class LoginServlet extends HttpServlet {
    
    private UserDAO userDAO;
    private StudentDAO studentDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.userDAO = new UserDAO();
        this.studentDAO = new StudentDAO();
    }
    
    /**
     * GET /login - Display login page
     * GET /logout - Logout user
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String servletPath = request.getServletPath();
        
        if ("/logout".equals(servletPath)) {
            // Logout - invalidate session and redirect to login
            SessionUtil.invalidateSession(request);
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Check if already logged in
        if (SessionUtil.isLoggedIn(request)) {
            // Already logged in - redirect to appropriate dashboard
            String role = SessionUtil.getUserRole(request);
            if ("ADMIN".equals(role)) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
            }
            return;
        }
        
        // Show login page
        request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
    }
    
    /**
     * POST /login - Authenticate user
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Validate inputs
        if (email == null || email.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Email and password are required");
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        // Authenticate user
        User user = userDAO.authenticateUser(email, password);
        
        if (user == null) {
            // Authentication failed
            request.setAttribute("error", "Invalid email or password");
            request.setAttribute("email", email); // Pre-fill email
            request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
            return;
        }
        
        // Authentication successful - create session
        SessionUtil.createSession(request, user.getUserId(), user.getEmail(), user.getRole());
        
        // For students, check approval status and set student details
        if ("STUDENT".equals(user.getRole())) {
            Student student = studentDAO.getStudentByUserId(user.getUserId());
            
            if (student == null) {
                // Student record not found
                SessionUtil.invalidateSession(request);
                request.setAttribute("error", "Student record not found. Please contact administrator.");
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
            
            // Check if student is approved
            if (!"APPROVED".equals(student.getStatus())) {
                SessionUtil.invalidateSession(request);
                String message = "PENDING".equals(student.getStatus()) 
                    ? "Your registration is pending approval. Please wait for admin approval."
                    : "Your registration has been rejected. Please contact administrator.";
                request.setAttribute("error", message);
                request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);
                return;
            }
            
            // Add student details to session
            request.getSession().setAttribute("studentId", student.getStudentId());
            request.getSession().setAttribute("studentName", student.getFullName());
            
            // Redirect to student dashboard
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
        } else {
            // Admin user - redirect to admin dashboard
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
}
