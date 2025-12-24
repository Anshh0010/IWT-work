package com.sms.servlet;

import com.sms.dao.StudentDAO;
import com.sms.model.Student;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * StudentApprovalServlet - Handles student approval/rejection
 */
@WebServlet("/admin/approvals")
public class StudentApprovalServlet extends HttpServlet {
    
    private StudentDAO studentDAO;
    
    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get pending students
            List<Student> pendingStudents = studentDAO.getPendingStudents();
            request.setAttribute("pendingStudents", pendingStudents);
            
            // Forward to approvals page
            request.getRequestDispatcher("/admin/pending-approvals.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load pending approvals: " + e.getMessage());
            request.getRequestDispatcher("/admin/pending-approvals.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        String studentIdStr = request.getParameter("studentId");
        
        if (studentIdStr == null || action == null) {
            response.sendRedirect(request.getContextPath() + "/admin/approvals");
            return;
        }
        
        try {
            int studentId = Integer.parseInt(studentIdStr);
            boolean success = false;
            String message = "";
            
            if ("approve".equals(action)) {
                success = studentDAO.approveStudent(studentId);
                message = success ? "Student approved successfully" : "Failed to approve student";
            } else if ("reject".equals(action)) {
                success = studentDAO.rejectStudent(studentId);
                message = success ? "Student rejected" : "Failed to reject student";
            }
            
            request.getSession().setAttribute(success ? "success" : "error", message);
            response.sendRedirect(request.getContextPath() + "/admin/approvals");
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/approvals");
        }
    }
}
