package com.sms.servlet;

import com.sms.dao.GradeDAO;
import com.sms.dao.MarksDAO;
import com.sms.model.Grade;
import com.sms.model.Mark;
import com.sms.util.SessionUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * StudentGradesServlet - View marks, grades, SGPA, and CGPA
 * Students can only VIEW (read-only)
 */
@WebServlet("/student/grades")
public class StudentGradesServlet extends HttpServlet {
    
    private MarksDAO marksDAO;
    private GradeDAO gradeDAO;
    
    @Override
    public void init() throws ServletException {
        marksDAO = new MarksDAO();
        gradeDAO = new GradeDAO();
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
            
            // Get marks
            List<Mark> marks = marksDAO.getMarksByStudent(studentId);
            request.setAttribute("marks", marks);
            
            // Get grades
            List<Grade> grades = gradeDAO.getGradesByStudent(studentId);
            request.setAttribute("grades", grades);
            
            // Get SGPA by semesters
            Map<Integer, Double> sgpaMap = gradeDAO.getSGPABySemesters(studentId);
            request.setAttribute("sgpaMap", sgpaMap);
            
            // Get overall CGPA
            double cgpa = gradeDAO.calculateCGPA(studentId);
            request.setAttribute("cgpa", String.format("%.2f", cgpa));
            
            // Forward to grades page
            request.getRequestDispatcher("/student/grades.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load grades: " + e.getMessage());
            request.getRequestDispatcher("/student/grades.jsp").forward(request, response);
        }
    }
}
