package com.sms.servlet;

import com.sms.dao.MarksDAO;
import com.sms.dao.StudentDAO;
import com.sms.dao.SubjectDAO;
import com.sms.model.Mark;
import com.sms.model.Student;
import com.sms.model.Subject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * MarksServlet - Admin marks entry
 * UNIQUE FEATURE: Auto-grading upon marks entry
 */
@WebServlet("/admin/marks")
public class MarksServlet extends HttpServlet {
    
    private StudentDAO studentDAO;
    private SubjectDAO subjectDAO;
    private MarksDAO marksDAO;
    
    @Override
    public void init() throws ServletException {
        studentDAO = new StudentDAO();
        subjectDAO = new SubjectDAO();
        marksDAO = new MarksDAO();
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
            
            // Forward to marks entry page
            request.getRequestDispatcher("/admin/marks-entry.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to load marks page: " + e.getMessage());
            request.getRequestDispatcher("/admin/marks-entry.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String studentIdStr = request.getParameter("studentId");
        String subjectIdStr = request.getParameter("subjectId");
        String semesterStr = request.getParameter("semester");
        String marksStr = request.getParameter("marks");
        String examType = request.getParameter("examType");
        
        if (studentIdStr == null || subjectIdStr == null || semesterStr == null || 
            marksStr == null || examType == null) {
            request.setAttribute("error", "All fields are required");
            doGet(request, response);
            return;
        }
        
        try {
            int studentId = Integer.parseInt(studentIdStr);
            int subjectId = Integer.parseInt(subjectIdStr);
            int semester = Integer.parseInt(semesterStr);
            double marks = Double.parseDouble(marksStr);
            
            // Validate marks (0-100)
            if (marks < 0 || marks > 100) {
                request.setAttribute("error", "Marks must be between 0 and 100");
                doGet(request, response);
                return;
            }
            
            // Add marks (auto-grading will be triggered)
            Mark mark = new Mark(studentId, subjectId, semester, marks, examType);
            int markId = marksDAO.addMarks(mark);
            
            if (markId > 0) {
                // Calculate and display grade
                String grade = marksDAO.calculateGrade(marks);
                request.setAttribute("success", 
                    "Marks entered successfully! Auto-Grade: " + grade);
            } else {
                request.setAttribute("error", "Failed to enter marks");
            }
            
            doGet(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format");
            doGet(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to enter marks: " + e.getMessage());
            doGet(request, response);
        }
    }
}
