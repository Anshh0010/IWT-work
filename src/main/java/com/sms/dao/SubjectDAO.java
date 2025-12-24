package com.sms.dao;

import com.sms.model.Subject;
import com.sms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * SubjectDAO - Data Access Object for Subject operations
 */
public class SubjectDAO {
    
    private DatabaseUtil dbUtil;
    
    public SubjectDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
    }
    
    /**
     * Get all subjects
     */
    public List<Subject> getAllSubjects() {
        List<Subject> subjects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM subjects ORDER BY course_id, semester, subject_name";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                subjects.add(extractSubjectFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting all subjects: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return subjects;
    }
    
    /**
     * Get subjects by course ID
     */
    public List<Subject> getSubjectsByCourse(int courseId) {
        List<Subject> subjects = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM subjects WHERE course_id = ? ORDER BY semester, subject_name";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, courseId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                subjects.add(extractSubjectFromResultSet(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting subjects by course: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return subjects;
    }
    
    /**
     * Get subject by ID
     */
    public Subject getSubjectById(int subjectId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM subjects WHERE subject_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, subjectId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return extractSubjectFromResultSet(rs);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting subject by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Helper method to extract Subject from ResultSet
     */
    private Subject extractSubjectFromResultSet(ResultSet rs) throws SQLException {
        Subject subject = new Subject();
        subject.setSubjectId(rs.getInt("subject_id"));
        subject.setSubjectCode(rs.getString("subject_code"));
        subject.setSubjectName(rs.getString("subject_name"));
        subject.setCredits(rs.getInt("credits"));
        subject.setCourseId(rs.getInt("course_id"));
        subject.setSemester(rs.getInt("semester"));
        return subject;
    }
}
