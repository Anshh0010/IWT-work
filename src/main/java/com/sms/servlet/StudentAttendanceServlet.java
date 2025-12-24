package com.sms.servlet;

import com.sms.dao.AttendanceDAO;
import com.sms.model.AttendanceStats;
import com.sms.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * StudentAttendanceServlet - View student attendance details
 */
@WebServlet("/student/attendance")
public class StudentAttendanceServlet extends HttpServlet {
    
    private AttendanceDAO attendanceDAO;
    
    @Override
    public void init() throws ServletException {
        attendanceDAO = new AttendanceDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get student ID from session
            Integer studentId = SessionUtil.getStudentId(request);
            
            if (studentId == null) {
                // No login required - use demo student
                studentId = 1;
            }
            
            // Get attendance statistics
            List<AttendanceStats> attendanceStats = attendanceDAO.getAttendanceStatsByStudent(studentId);
            request.setAttribute("attendanceStats", attendanceStats);
            
            // Forward to attendance page
            request.getRequestDispatcher("/student/attendance.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load attendance: " + e.getMessage());
            request.getRequestDispatcher("/student/attendance.jsp").forward(request, response);
        }
    }
}
