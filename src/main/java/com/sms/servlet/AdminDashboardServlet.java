package com.sms.servlet;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.GradeDAO;
import com.sms.dao.StudentDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * AdminDashboardServlet - Admin Dashboard with statistics
 * Shows: Total students, Pending approvals, Defaulters, Average CGPA
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    
    private StudentDAO studentDAO;
    private AttendanceDAO attendanceDAO;
    private GradeDAO gradeDAO;
    
    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
        attendanceDAO = new AttendanceDAO();
        gradeDAO = new GradeDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get statistics for dashboard
            int totalStudents = studentDAO.getStudentCountByStatus("APPROVED");
            int pendingApprovals = studentDAO.getStudentCountByStatus("PENDING");
            int defaultersCount = attendanceDAO.getDefaulterCount();
            double averageCGPA = gradeDAO.getAverageCGPA();
            
            // Set attributes
            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("pendingApprovals", pendingApprovals);
            request.setAttribute("defaultersCount", defaultersCount);
            request.setAttribute("averageCGPA", String.format("%.2f", averageCGPA));
            
            // Forward to admin dashboard
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard: " + e.getMessage());
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        }
    }
}
