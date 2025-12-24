package com.sms.dao;

import com.sms.model.Course;
import com.sms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * CourseDAO - Data Access Object for Course operations
 */
public class CourseDAO {
    
    private DatabaseUtil dbUtil;
    
    public CourseDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
    }
    
    /**
     * Get all courses
     */
    public List<Course> getAllCourses() {
        List<Course> courses = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT course_id, course_name, duration_years, created_at " +
                    "FROM courses ORDER BY course_name";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseName(rs.getString("course_name"));
                course.setDurationYears(rs.getInt("duration_years"));
                course.setCreatedAt(rs.getTimestamp("created_at"));
                courses.add(course);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting all courses: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return courses;
    }
    
    /**
     * Get course by ID
     */
    public Course getCourseById(int courseId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT course_id, course_name, duration_years, created_at " +
                    "FROM courses WHERE course_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, courseId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Course course = new Course();
                course.setCourseId(rs.getInt("course_id"));
                course.setCourseName(rs.getString("course_name"));
                course.setDurationYears(rs.getInt("duration_years"));
                course.setCreatedAt(rs.getTimestamp("created_at"));
                return course;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting course by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
}
