package com.sms.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Attendance Model Class
 * Represents an attendance record
 */
public class Attendance {
    private int attendanceId;
    private int studentId;
    private int subjectId;
    private Date attendanceDate;
    private String status; // PRESENT or ABSENT
    private Timestamp markedAt;
    
    // Additional fields for display
    private String studentName;
    private String subjectName;
    
    // Constructors
    public Attendance() {}
    
    public Attendance(int studentId, int subjectId, Date attendanceDate, String status) {
        this.studentId = studentId;
        this.subjectId = subjectId;
        this.attendanceDate = attendanceDate;
        this.status = status;
    }
    
    // Getters and Setters
    public int getAttendanceId() {
        return attendanceId;
    }
    
    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
    }
    
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getSubjectId() {
        return subjectId;
    }
    
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
    
    public Date getAttendanceDate() {
        return attendanceDate;
    }
    
    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getMarkedAt() {
        return markedAt;
    }
    
    public void setMarkedAt(Timestamp markedAt) {
        this.markedAt = markedAt;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getSubjectName() {
        return subjectName;
    }
    
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    
    @Override
    public String toString() {
        return "Attendance{" +
                "attendanceId=" + attendanceId +
                ", studentId=" + studentId +
                ", subjectId=" + subjectId +
                ", attendanceDate=" + attendanceDate +
                ", status='" + status + '\'' +
                '}';
    }
}
