package com.sms.servlet;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.StudentDAO;
import com.sms.dao.SubjectDAO;
import com.sms.model.Attendance;
import com.sms.model.Student;
import com.sms.model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Date;
import java.util.List;

/**
 * AttendanceServlet - Admin attendance marking
 */
@WebServlet("/admin/attendance")
public class AttendanceServlet extends HttpServlet {
    
    private StudentDAO studentDAO;
    private SubjectDAO subjectDAO;
    private AttendanceDAO attendanceDAO;
    
    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
        subjectDAO = new SubjectDAO();
        attendanceDAO = new AttendanceDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // Get all approved students and subjects
            List<Student> students = studentDAO.getApprovedStudents();
            List<Subject> subjects = subjectDAO.getAllSubjects();
            
            request.setAttribute("students", students);
            request.setAttribute("subjects", subjects);
            
            // Forward to attendance page
            request.getRequestDispatcher("/admin/attendance-entry.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load attendance page: " + e.getMessage());
            request.getRequestDispatcher("/admin/attendance-entry.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String studentIdStr = request.getParameter("studentId");
        String subjectIdStr = request.getParameter("subjectId");
        String dateStr = request.getParameter("date");
        String status = request.getParameter("status");
        
        if (studentIdStr == null || subjectIdStr == null || dateStr == null || status == null) {
            request.setAttribute("error", "All fields are required");
            doGet(request, response);
            return;
        }
        
        try {
            int studentId = Integer.parseInt(studentIdStr);
            int subjectId = Integer.parseInt(subjectIdStr);
            Date date = Date.valueOf(dateStr);
            
            // Mark attendance
            Attendance attendance = new Attendance(studentId, subjectId, date, status);
            boolean success = attendanceDAO.markAttendance(attendance);
            
            if (success) {
                request.setAttribute("success", "Attendance marked successfully");
            } else {
                request.setAttribute("error", "Failed to mark attendance");
            }
            
            doGet(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to mark attendance: " + e.getMessage());
            doGet(request, response);
        }
    }
}
