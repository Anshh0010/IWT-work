package com.sms.model;

/**
 * Attendance Statistics Model
 * Used for displaying attendance summary and defaulter information
 */
public class AttendanceStats {
    private int studentId;
    private String studentName;
    private String rollNo;
    private int subjectId;
    private String subjectName;
    private int totalClasses;
    private int classesAttended;
    private double attendancePercentage;
    private String defaulterStatus; // AT RISK or SAFE
    
    // Constructors
    public AttendanceStats() {}
    
    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public String getStudentName() {
        return studentName;
    }
    
    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getRollNo() {
        return rollNo;
    }
    
    public void setRollNo(String rollNo) {
        this.rollNo = rollNo;
    }
    
    public int getSubjectId() {
        return subjectId;
    }
    
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
    
    public String getSubjectName() {
        return subjectName;
    }
    
    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }
    
    public int getTotalClasses() {
        return totalClasses;
    }
    
    public void setTotalClasses(int totalClasses) {
        this.totalClasses = totalClasses;
    }
    
    public int getClassesAttended() {
        return classesAttended;
    }
    
    public void setClassesAttended(int classesAttended) {
        this.classesAttended = classesAttended;
    }
    
    public double getAttendancePercentage() {
        return attendancePercentage;
    }
    
    public void setAttendancePercentage(double attendancePercentage) {
        this.attendancePercentage = attendancePercentage;
    }
    
    public String getDefaulterStatus() {
        return defaulterStatus;
    }
    
    public void setDefaulterStatus(String defaulterStatus) {
        this.defaulterStatus = defaulterStatus;
    }
    
    /**
     * Check if student is a defaulter
     */
    public boolean isDefaulter() {
        return "AT RISK".equals(defaulterStatus);
    }
    
    @Override
    public String toString() {
        return "AttendanceStats{" +
                "studentId=" + studentId +
                ", studentName='" + studentName + '\'' +
                ", rollNo='" + rollNo + '\'' +
                ", subjectName='" + subjectName + '\'' +
                ", attendancePercentage=" + attendancePercentage +
                ", defaulterStatus='" + defaulterStatus + '\'' +
                '}';
    }
}
