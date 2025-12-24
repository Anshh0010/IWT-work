package com.sms.servlet;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.GradeDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.AttendanceStats;
import com.sms.model.Student;
import com.sms.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * StudentDashboardServlet - Student Dashboard
 * Shows: Attendance with defaulter warning, Marks, Grades, CGPA
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {
    
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
            // Auto-create demo session - NO LOGIN REQUIRED
            Integer studentId = SessionUtil.getStudentId(request);
            
            if (studentId == null) {
                // Always auto-login as demo student
                SessionUtil.createStudentSession(request, 
                    1,              // userId
                    "demo",         // email
                    "STUDENT",      // role
                    1,              // studentId
                    "Demo Student"  // fullName
                );
                studentId = 1;
            }
            
            // Get student details
            Student student = studentDAO.getStudentById(studentId);
            
            // If database fails or no student found, create demo student
            if (student == null) {
                student = new Student();
                student.setStudentId(1);
                student.setFullName("Demo Student");
                student.setRollNo("DEMO001");
                student.setEmail("demo");
                student.setCourseId(1);
                student.setStatus("APPROVED");
            }
            
            request.setAttribute("student", student);
            
            // Get attendance stats (with defaulter status)
            List<AttendanceStats> attendanceStats = attendanceDAO.getAttendanceStatsByStudent(studentId);
            request.setAttribute("attendanceStats", attendanceStats);
            
            // Check if student is defaulter in any subject
            boolean isDefaulter = attendanceDAO.isDefaulter(studentId);
            request.setAttribute("isDefaulter", isDefaulter);
            
            // Calculate overall attendance percentage
            if (!attendanceStats.isEmpty()) {
                double totalPercentage = 0;
                for (AttendanceStats stats : attendanceStats) {
                    totalPercentage += stats.getAttendancePercentage();
                }
                double avgAttendance = totalPercentage / attendanceStats.size();
                request.setAttribute("overallAttendance", String.format("%.2f", avgAttendance));
            } else {
                request.setAttribute("overallAttendance", "N/A");
            }
            
            // Calculate CGPA
            double cgpa = gradeDAO.calculateCGPA(studentId);
            request.setAttribute("cgpa", String.format("%.2f", cgpa));
            
            // Forward to student dashboard
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard: " + e.getMessage());
            request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
        }
    }
}
