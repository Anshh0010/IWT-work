package com.sms.dao;

import com.sms.model.Attendance;
import com.sms.model.AttendanceStats;
import com.sms.util.DatabaseUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * AttendanceDAO - Data Access Object for Attendance operations
 * UNIQUE FEATURE: Attendance Defaulter Prediction (< 75%)
 */
public class AttendanceDAO {
    
    private DatabaseUtil dbUtil;
    
    public AttendanceDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
    }
    
    /**
     * Mark attendance for a student
     */
    public boolean markAttendance(Attendance attendance) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        String sql = "INSERT INTO attendance (student_id, subject_id, attendance_date, status) " +
                    "VALUES (?, ?, ?, ?) " +
                    "ON DUPLICATE KEY UPDATE status = VALUES(status)";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            pstmt.setInt(1, attendance.getStudentId());
            pstmt.setInt(2, attendance.getSubjectId());
            pstmt.setDate(3, attendance.getAttendanceDate());
            pstmt.setString(4, attendance.getStatus());
            
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
            
        } catch (SQLException e) {
            System.err.println("ERROR marking attendance: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt);
        }
        
        return false;
    }
    
    /**
     * Get attendance records for a student
     */
    public List<Attendance> getAttendanceByStudent(int studentId) {
        List<Attendance> attendanceList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT a.*, sub.subject_name " +
                    "FROM attendance a " +
                    "JOIN subjects sub ON a.subject_id = sub.subject_id " +
                    "WHERE a.student_id = ? " +
                    "ORDER BY a.attendance_date DESC";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Attendance att = new Attendance();
                att.setAttendanceId(rs.getInt("attendance_id"));
                att.setStudentId(rs.getInt("student_id"));
                att.setSubjectId(rs.getInt("subject_id"));
                att.setAttendanceDate(rs.getDate("attendance_date"));
                att.setStatus(rs.getString("status"));
                att.setMarkedAt(rs.getTimestamp("marked_at"));
                att.setSubjectName(rs.getString("subject_name"));
                attendanceList.add(att);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting attendance by student: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return attendanceList;
    }
    
    /**
     * UNIQUE FEATURE: Calculate attendance percentage for a student in a subject
     * @return Attendance percentage (0-100)
     */
    public double calculateAttendancePercentage(int studentId, int subjectId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT " +
                    "COUNT(*) as total_classes, " +
                    "SUM(CASE WHEN status = 'PRESENT' THEN 1 ELSE 0 END) as classes_attended " +
                    "FROM attendance " +
                    "WHERE student_id = ? AND subject_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            pstmt.setInt(2, subjectId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                int total = rs.getInt("total_classes");
                int attended = rs.getInt("classes_attended");
                
                if (total > 0) {
                    return (attended * 100.0) / total;
                }
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR calculating attendance percentage: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return 0.0;
    }
    
    /**
     * UNIQUE FEATURE: Get attendance statistics for a student (all subjects)
     * Calculates percentage and defaulter status
     */
    public List<AttendanceStats> getAttendanceStatsByStudent(int studentId) {
        List<AttendanceStats> statsList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // Use the view created in schema
        String sql = "SELECT * FROM v_attendance_summary WHERE student_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                AttendanceStats stats = new AttendanceStats();
                stats.setStudentId(rs.getInt("student_id"));
                stats.setStudentName(rs.getString("full_name"));
                stats.setRollNo(rs.getString("roll_no"));
                stats.setSubjectId(rs.getInt("subject_id"));
                stats.setSubjectName(rs.getString("subject_name"));
                stats.setTotalClasses(rs.getInt("total_classes"));
                stats.setClassesAttended(rs.getInt("classes_attended"));
                stats.setAttendancePercentage(rs.getDouble("attendance_percentage"));
                stats.setDefaulterStatus(rs.getString("defaulter_status"));
                statsList.add(stats);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting attendance stats: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return statsList;
    }
    
    /**
     * UNIQUE FEATURE: Get list of attendance defaulters (students with < 75% attendance)
     * This is the key feature for admin dashboard
     */
    public List<AttendanceStats> getDefaulters() {
        List<AttendanceStats> defaulters = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        // Use the view and filter for AT RISK status
        String sql = "SELECT * FROM v_attendance_summary " +
                    "WHERE defaulter_status = 'AT RISK' " +
                    "ORDER BY attendance_percentage ASC";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                AttendanceStats stats = new AttendanceStats();
                stats.setStudentId(rs.getInt("student_id"));
                stats.setStudentName(rs.getString("full_name"));
                stats.setRollNo(rs.getString("roll_no"));
                stats.setSubjectId(rs.getInt("subject_id"));
                stats.setSubjectName(rs.getString("subject_name"));
                stats.setTotalClasses(rs.getInt("total_classes"));
                stats.setClassesAttended(rs.getInt("classes_attended"));
                stats.setAttendancePercentage(rs.getDouble("attendance_percentage"));
                stats.setDefaulterStatus(rs.getString("defaulter_status"));
                defaulters.add(stats);
            }
            
            System.out.println("Found " + defaulters.size() + " attendance defaulters");
            
        } catch (SQLException e) {
            System.err.println("ERROR getting defaulters: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return defaulters;
    }
    
    /**
     * Get count of attendance defaulters
     */
    public int getDefaulterCount() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT COUNT(DISTINCT student_id) as count " +
                    "FROM v_attendance_summary " +
                    "WHERE defaulter_status = 'AT RISK'";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return rs.getInt("count");
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting defaulter count: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return 0;
    }
    
    /**
     * Check if student is a defaulter
     */
    public boolean isDefaulter(int studentId) {
        List<AttendanceStats> stats = getAttendanceStatsByStudent(studentId);
        
        for (AttendanceStats stat : stats) {
            if (stat.isDefaulter()) {
                return true;
            }
        }
        
        return false;
    }
}
