package com.sms.model;

import java.sql.Timestamp;

/**
 * Grade Model Class
 * Represents auto-calculated grades and CGPA
 */
public class Grade {
    private int gradeId;
    private int studentId;
    private int subjectId;
    private int semester;
    private String grade; // A+, A, B, C, F
    private double gradePoints; // 10.0, 9.0, 8.0, 7.0, 0.0
    private Timestamp calculatedAt;
    
    // Additional fields for display
    private String studentName;
    private String subjectName;
    private int credits;
    
    // Constructors
    public Grade() {}
    
    public Grade(int studentId, int subjectId, int semester, String grade, double gradePoints) {
        this.studentId = studentId;
        this.subjectId = subjectId;
        this.semester = semester;
        this.grade = grade;
        this.gradePoints = gradePoints;
    }
    
    // Getters and Setters
    public int getGradeId() {
        return gradeId;
    }
    
    public void setGradeId(int gradeId) {
        this.gradeId = gradeId;
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
    
    public int getSemester() {
        return semester;
    }
    
    public void setSemester(int semester) {
        this.semester = semester;
    }
    
    public String getGrade() {
        return grade;
    }
    
    public void setGrade(String grade) {
        this.grade = grade;
    }
    
    public double getGradePoints() {
        return gradePoints;
    }
    
    public void setGradePoints(double gradePoints) {
        this.gradePoints = gradePoints;
    }
    
    public Timestamp getCalculatedAt() {
        return calculatedAt;
    }
    
    public void setCalculatedAt(Timestamp calculatedAt) {
        this.calculatedAt = calculatedAt;
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
    
    public int getCredits() {
        return credits;
    }
    
    public void setCredits(int credits) {
        this.credits = credits;
    }
    
    @Override
    public String toString() {
        return "Grade{" +
                "gradeId=" + gradeId +
                ", studentId=" + studentId +
                ", subjectId=" + subjectId +
                ", semester=" + semester +
                ", grade='" + grade + '\'' +
                ", gradePoints=" + gradePoints +
                '}';
    }
}
