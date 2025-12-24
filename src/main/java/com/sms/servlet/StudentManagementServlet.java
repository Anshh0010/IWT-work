package com.sms.servlet;

import com.sms.dao.StudentDAO;
import com.sms.dao.UserDAO;
import com.sms.dao.CourseDAO;
import com.sms.model.Student;
import com.sms.model.User;
import com.sms.model.Course;
import com.sms.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/students")
public class StudentManagementServlet extends HttpServlet {
    
    private StudentDAO studentDAO;
    private UserDAO userDAO;
    private CourseDAO courseDAO;
    
    @Override
    public void init() throws ServletException {
        super.init();
        this.studentDAO = new StudentDAO();
        this.userDAO = new UserDAO();
        this.courseDAO = new CourseDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get all students
        List<Student> students = studentDAO.getAllStudents();
        request.setAttribute("students", students);
        
        // Get all courses for the dropdown
        List<Course> courses = courseDAO.getAllCourses();
        request.setAttribute("courses", courses);
        
        // Forward to JSP
        request.getRequestDispatcher("/WEB-INF/views/students.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String rollNo = request.getParameter("rollNo");
        String password = request.getParameter("password");
        String courseIdStr = request.getParameter("courseId");
        
        try {
            // Validate inputs
            if (fullName == null || email == null || rollNo == null || password == null || courseIdStr == null) {
                request.setAttribute("error", "All fields are required");
                doGet(request, response);
                return;
            }
            
            int courseId = Integer.parseInt(courseIdStr);
            
            // Check if email already exists
            if (userDAO.emailExists(email)) {
                request.setAttribute("error", "Email already exists");
                doGet(request, response);
                return;
            }
            
            // Create user account
            String hashedPassword = PasswordUtil.hashPassword(password);
            User user = new User(email, hashedPassword, "STUDENT");
            int userId = userDAO.createUser(user);
            
            if (userId == -1) {
                request.setAttribute("error", "Failed to create user account");
                doGet(request, response);
                return;
            }
            
            // Create student record
            Student student = new Student();
            student.setUserId(userId);
            student.setFullName(fullName);
            student.setEmail(email);
            student.setRollNo(rollNo);
            student.setCourseId(courseId);
            student.setStatus("APPROVED"); // Auto-approve for demo
            
            int studentId = studentDAO.createStudent(student);
            
            if (studentId == -1) {
                request.setAttribute("error", "Failed to create student record");
                doGet(request, response);
                return;
            }
            
            // Success
            request.setAttribute("success", "Student added successfully! Roll No: " + rollNo);
            doGet(request, response);
            
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            doGet(request, response);
        }
    }
}
