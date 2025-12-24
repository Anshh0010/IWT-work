package com.sms.model;

import java.sql.Timestamp;

/**
 * Student Model Class
 * Represents a student in the system
 */
public class Student {
    private int studentId;
    private int userId;
    private String rollNo;
    private String fullName;
    private String email;
    private int courseId;
    private String courseName; // For display purposes
    private String status; // PENDING, APPROVED, REJECTED
    private Timestamp registeredDate;
    
    // Constructors
    public Student() {}
    
    public Student(int userId, String rollNo, String fullName, String email, int courseId, String status) {
        this.userId = userId;
        this.rollNo = rollNo;
        this.fullName = fullName;
        this.email = email;
        this.courseId = courseId;
        this.status = status;
    }
    
    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }
    
    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getUserId() {
        return userId;
    }
    
    public void setUserId(int userId) {
        this.userId = userId;
    }
    
    public String getRollNo() {
        return rollNo;
    }
    
    public void setRollNo(String rollNo) {
        this.rollNo = rollNo;
    }
    
    public String getFullName() {
        return fullName;
    }
    
    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    public String getEmail() {
        return email;
    }
    
    public void setEmail(String email) {
        this.email = email;
    }
    
    public int getCourseId() {
        return courseId;
    }
    
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    
    public String getCourseName() {
        return courseName;
    }
    
    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Timestamp getRegisteredDate() {
        return registeredDate;
    }
    
    public void setRegisteredDate(Timestamp registeredDate) {
        this.registeredDate = registeredDate;
    }
    
    @Override
    public String toString() {
        return "Student{" +
                "studentId=" + studentId +
                ", rollNo='" + rollNo + '\'' +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", courseId=" + courseId +
                ", status='" + status + '\'' +
                '}';
    }
}
