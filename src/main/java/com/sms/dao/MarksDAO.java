package com.sms.dao;

import com.sms.model.Mark;
import com.sms.model.Grade;
import com.sms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 * MarksDAO - Data Access Object for Marks operations
 * UNIQUE FEATURE: Auto-grading system (marks -> grade -> SGPA -> CGPA)
 */
public class MarksDAO {
    
    private DatabaseUtil dbUtil;
    private GradeDAO gradeDAO;
    
    public MarksDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
        this.gradeDAO = new GradeDAO();
    }
    
    /**
     * Add marks for a student
     * Automatically triggers grade calculation
     */
    public int addMarks(Mark mark) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "INSERT INTO marks (student_id, subject_id, semester, marks_obtained, max_marks, exam_type) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            pstmt.setInt(1, mark.getStudentId());
            pstmt.setInt(2, mark.getSubjectId());
            pstmt.setInt(3, mark.getSemester());
            pstmt.setDouble(4, mark.getMarksObtained());
            pstmt.setDouble(5, mark.getMaxMarks());
            pstmt.setString(6, mark.getExamType());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    int markId = rs.getInt(1);
                    
                    // AUTO-GRADING: Calculate and save grade
                    calculateAndSaveGrade(mark.getStudentId(), mark.getSubjectId(), 
                                         mark.getSemester(), mark.getMarksObtained());
                    
                    return markId;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR adding marks: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return -1;
    }
    
    /**
     * UNIQUE FEATURE: Calculate grade from marks
     * Grading Logic:
     * 90-100: A+ (10.0 points)
     * 80-89:  A  (9.0 points)
     * 70-79:  B  (8.0 points)
     * 60-69:  C  (7.0 points)
     * <60:    F  (0.0 points)
     */
    public String calculateGrade(double marks) {
        if (marks >= 90) {
            return "A+";
        } else if (marks >= 80) {
            return "A";
        } else if (marks >= 70) {
            return "B";
        } else if (marks >= 60) {
            return "C";
        } else {
            return "F";
        }
    }
    
    /**
     * UNIQUE FEATURE: Get grade points from grade
     */
    public double getGradePoints(String grade) {
        switch (grade) {
            case "A+":
                return 10.0;
            case "A":
                return 9.0;
            case "B":
                return 8.0;
            case "C":
                return 7.0;
            case "F":
            default:
                return 0.0;
        }
    }
    
    /**
     * AUTO-GRADING: Calculate and save grade automatically
     */
    private void calculateAndSaveGrade(int studentId, int subjectId, int semester, double marks) {
        String grade = calculateGrade(marks);
        double gradePoints = getGradePoints(grade);
        
        Grade gradeObj = new Grade(studentId, subjectId, semester, grade, gradePoints);
        gradeDAO.saveGrade(gradeObj);
        
        System.out.println("Auto-graded: Marks=" + marks + " -> Grade=" + grade + " (" + gradePoints + " points)");
    }
    
    /**
     * Get marks for a student
     */
    public List<Mark> getMarksByStudent(int studentId) {
        List<Mark> marks = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT m.*, sub.subject_name " +
                    "FROM marks m " +
                    "JOIN subjects sub ON m.subject_id = sub.subject_id " +
                    "WHERE m.student_id = ? " +
                    "ORDER BY m.semester, sub.subject_name";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Mark mark = new Mark();
                mark.setMarkId(rs.getInt("mark_id"));
                mark.setStudentId(rs.getInt("student_id"));
                mark.setSubjectId(rs.getInt("subject_id"));
                mark.setSemester(rs.getInt("semester"));
                mark.setMarksObtained(rs.getDouble("marks_obtained"));
                mark.setMaxMarks(rs.getDouble("max_marks"));
                mark.setExamType(rs.getString("exam_type"));
                mark.setEnteredAt(rs.getTimestamp("entered_at"));
                mark.setSubjectName(rs.getString("subject_name"));
                marks.add(mark);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting marks by student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return marks;
    }
    
    /**
     * Get marks for a specific subject and semester
     */
    public Mark getMarksByStudentSubject(int studentId, int subjectId, int semester) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT m.*, sub.subject_name " +
                    "FROM marks m " +
                    "JOIN subjects sub ON m.subject_id = sub.subject_id " +
                    "WHERE m.student_id = ? AND m.subject_id = ? AND m.semester = ? " +
                    "AND m.exam_type = 'FINAL' " +
                    "LIMIT 1";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            pstmt.setInt(2, subjectId);
            pstmt.setInt(3, semester);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Mark mark = new Mark();
                mark.setMarkId(rs.getInt("mark_id"));
                mark.setStudentId(rs.getInt("student_id"));
                mark.setSubjectId(rs.getInt("subject_id"));
                mark.setSemester(rs.getInt("semester"));
                mark.setMarksObtained(rs.getDouble("marks_obtained"));
                mark.setMaxMarks(rs.getDouble("max_marks"));
                mark.setExamType(rs.getString("exam_type"));
                mark.setEnteredAt(rs.getTimestamp("entered_at"));
                mark.setSubjectName(rs.getString("subject_name"));
                return mark;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting marks: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Update marks (re-triggers auto-grading)
     */
    public boolean updateMarks(int markId, double newMarks, int studentId, int subjectId, int semester) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "UPDATE marks SET marks_obtained = ? WHERE mark_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setDouble(1, newMarks);
            pstmt.setInt(2, markId);
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                // Recalculate grade
                calculateAndSaveGrade(studentId, subjectId, semester, newMarks);
                return true;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR updating marks: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt);
        }
        
        return false;
    }
}
