package com.sms.model;

import java.sql.Timestamp;

/**
 * Course Model Class
 * Represents an academic course
 */
public class Course {
    private int courseId;
    private String courseName;
    private int durationYears;
    private Timestamp createdAt;
    
    // Constructors
    public Course() {}
    
    public Course(String courseName, int durationYears) {
        this.courseName = courseName;
        this.durationYears = durationYears;
    }
    
    public Course(int courseId, String courseName, int durationYears) {
        this.courseId = courseId;
        this.courseName = courseName;
        this.durationYears = durationYears;
    }
    
    // Getters and Setters
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
    
    public int getDurationYears() {
        return durationYears;
    }
    
    public void setDurationYears(int durationYears) {
        this.durationYears = durationYears;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    @Override
    public String toString() {
        return "Course{" +
                "courseId=" + courseId +
                ", courseName='" + courseName + '\'' +
                ", durationYears=" + durationYears +
                '}';
    }
}
