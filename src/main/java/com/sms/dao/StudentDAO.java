package com.sms.dao;

import com.sms.model.Student;
import com.sms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * StudentDAO - Data Access Object for Student operations
 * Uses PreparedStatements to prevent SQL injection
 */
public class StudentDAO {
    
    private DatabaseUtil dbUtil;
    
    public StudentDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
    }
    
    /**
     * Create new student
     */
    public int createStudent(Student student) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            pstmt.setInt(1, student.getUserId());
            pstmt.setString(2, student.getRollNo());
            pstmt.setString(3, student.getFullName());
            pstmt.setString(4, student.getEmail());
            pstmt.setInt(5, student.getCourseId());
            pstmt.setString(6, student.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR creating student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return -1;
    }
    
    /**
     * Get student by ID
     */
    public Student getStudentById(int studentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT s.*, c.course_name " +
                    "FROM students s " +
                    "JOIN courses c ON s.course_id = c.course_id " +
                    "WHERE s.student_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting student by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Get student by user ID
     */
    public Student getStudentByUserId(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT s.*, c.course_name " +
                    "FROM students s " +
                    "JOIN courses c ON s.course_id = c.course_id " +
                    "WHERE s.user_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractStudentFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting student by user ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Get all students
     */
    public List<Student> getAllStudents() {
        List<Student> students = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT s.*, c.course_name " +
                    "FROM students s " +
                    "JOIN courses c ON s.course_id = c.course_id " +
                    "ORDER BY s.roll_no";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting all students: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return students;
    }
    
    /**
     * Get pending students (for admin approval)
     */
    public List<Student> getPendingStudents() {
        List<Student> students = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT s.*, c.course_name " +
                    "FROM students s " +
                    "JOIN courses c ON s.course_id = c.course_id " +
                    "WHERE s.status = 'PENDING' " +
                    "ORDER BY s.registered_date DESC";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting pending students: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return students;
    }
    
    /**
     * Get approved students
     */
    public List<Student> getApprovedStudents() {
        List<Student> students = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT s.*, c.course_name " +
                    "FROM students s " +
                    "JOIN courses c ON s.course_id = c.course_id " +
                    "WHERE s.status = 'APPROVED' " +
                    "ORDER BY s.roll_no";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(extractStudentFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting approved students: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return students;
    }
    
    /**
     * Approve student registration
     */
    public boolean approveStudent(int studentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE students SET status = 'APPROVED' WHERE student_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR approving student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt);
        }
        
        return false;
    }
    
    /**
     * Reject student registration
     */
    public boolean rejectStudent(int studentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE students SET status = 'REJECTED' WHERE student_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR rejecting student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt);
        }
        
        return false;
    }
    
    /**
     * Update student details
     */
    public boolean updateStudent(Student student) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE students SET full_name = ?, email = ?, course_id = ? " +
                    "WHERE student_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setString(1, student.getFullName());
            pstmt.setString(2, student.getEmail());
            pstmt.setInt(3, student.getCourseId());
            pstmt.setInt(4, student.getStudentId());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR updating student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt);
        }
        
        return false;
    }
    
    /**
     * Get count of students by status
     */
    public int getStudentCountByStatus(String status) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT COUNT(*) as count FROM students WHERE status = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting student count: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return 0;
    }
    
    /**
     * Helper method to extract Student from ResultSet
     */
    private Student extractStudentFromResultSet(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setStudentId(rs.getInt("student_id"));
        student.setUserId(rs.getInt("user_id"));
        student.setRollNo(rs.getString("roll_no"));
        student.setFullName(rs.getString("full_name"));
        student.setEmail(rs.getString("email"));
        student.setCourseId(rs.getInt("course_id"));
        student.setCourseName(rs.getString("course_name"));
        student.setStatus(rs.getString("status"));
        student.setRegisteredDate(rs.getTimestamp("registered_date"));
        return student;
    }
}
