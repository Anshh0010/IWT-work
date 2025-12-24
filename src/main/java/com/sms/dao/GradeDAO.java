package com.sms.dao;

import com.sms.model.Grade;
import com.sms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * GradeDAO - Data Access Object for Grade operations
 * UNIQUE FEATURE: Auto SGPA and CGPA calculation
 */
public class GradeDAO {
    
    private DatabaseUtil dbUtil;
    
    public GradeDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
    }
    
    /**
     * Save auto-calculated grade
     */
    public boolean saveGrade(Grade grade) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO grades (student_id, subject_id, semester, grade, grade_points) " +
                    "VALUES (?, ?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE grade = VALUES(grade), grade_points = VALUES(grade_points)";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, grade.getStudentId());
            pstmt.setInt(2, grade.getSubjectId());
            pstmt.setInt(3, grade.getSemester());
            pstmt.setString(4, grade.getGrade());
            pstmt.setDouble(5, grade.getGradePoints());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR saving grade: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt);
        }
        
        return false;
    }
    
    /**
     * Get grades for a student
     */
    public List<Grade> getGradesByStudent(int studentId) {
        List<Grade> grades = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT g.*, sub.subject_name, sub.credits " +
                    "FROM grades g " +
                    "JOIN subjects sub ON g.subject_id = sub.subject_id " +
                    "WHERE g.student_id = ? " +
                    "ORDER BY g.semester, sub.subject_name";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Grade grade = new Grade();
                grade.setGradeId(rs.getInt("grade_id"));
                grade.setStudentId(rs.getInt("student_id"));
                grade.setSubjectId(rs.getInt("subject_id"));
                grade.setSemester(rs.getInt("semester"));
                grade.setGrade(rs.getString("grade"));
                grade.setGradePoints(rs.getDouble("grade_points"));
                grade.setCalculatedAt(rs.getTimestamp("calculated_at"));
                grade.setSubjectName(rs.getString("subject_name"));
                grade.setCredits(rs.getInt("credits"));
                grades.add(grade);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting grades by student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return grades;
    }
    
    /**
     * UNIQUE FEATURE: Calculate SGPA for a specific semester
     * SGPA = Sum(Grade Points × Credits) / Sum(Credits)
     */
    public double calculateSGPA(int studentId, int semester) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT g.grade_points, sub.credits " +
                    "FROM grades g " +
                    "JOIN subjects sub ON g.subject_id = sub.subject_id " +
                    "WHERE g.student_id = ? AND g.semester = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            pstmt.setInt(2, semester);
            
            rs = pstmt.executeQuery();
            
            double totalPoints = 0.0;
            int totalCredits = 0;
            
            while (rs.next()) {
                double gradePoints = rs.getDouble("grade_points");
                int credits = rs.getInt("credits");
                
                totalPoints += (gradePoints * credits);
                totalCredits += credits;
            }
            
            if (totalCredits > 0) {
                double sgpa = totalPoints / totalCredits;
                System.out.println("SGPA for semester " + semester + ": " + String.format("%.2f", sgpa));
                return sgpa;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR calculating SGPA: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return 0.0;
    }
    
    /**
     * UNIQUE FEATURE: Calculate CGPA (overall GPA across all semesters)
     * CGPA = Sum(Grade Points × Credits) / Sum(Credits) for all semesters
     */
    public double calculateCGPA(int studentId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT g.grade_points, sub.credits " +
                    "FROM grades g " +
                    "JOIN subjects sub ON g.subject_id = sub.subject_id " +
                    "WHERE g.student_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            double totalPoints = 0.0;
            int totalCredits = 0;
            
            while (rs.next()) {
                double gradePoints = rs.getDouble("grade_points");
                int credits = rs.getInt("credits");
                
                totalPoints += (gradePoints * credits);
                totalCredits += credits;
            }
            
            if (totalCredits > 0) {
                double cgpa = totalPoints / totalCredits;
                System.out.println("CGPA: " + String.format("%.2f", cgpa));
                return cgpa;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR calculating CGPA: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return 0.0;
    }
    
    /**
     * Get SGPA for each semester for a student
     */
    public Map<Integer, Double> getSGPABySemesters(int studentId) {
        Map<Integer, Double> sgpaMap = new HashMap<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT DISTINCT semester FROM grades WHERE student_id = ? ORDER BY semester";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                int semester = rs.getInt("semester");
                double sgpa = calculateSGPA(studentId, semester);
                sgpaMap.put(semester, sgpa);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting SGPA by semesters: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return sgpaMap;
    }
    
    /**
     * Get average CGPA across all students (for admin dashboard)
     */
    public double getAverageCGPA() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT AVG(cgpa) as avg_cgpa FROM v_cgpa_summary";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getDouble("avg_cgpa");
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting average CGPA: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return 0.0;
    }
}
