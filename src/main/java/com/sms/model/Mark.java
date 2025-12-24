package com.sms.model;

import java.sql.Timestamp;

/**
 * Mark Model Class
 * Represents marks obtained by a student in a subject
 */
public class Mark {
    private int markId;
    private int studentId;
    private int subjectId;
    private int semester;
    private double marksObtained;
    private double maxMarks;
    private String examType; // MIDTERM, ENDTERM, ASSIGNMENT, FINAL
    private Timestamp enteredAt;
    
    // Additional fields for display
    private String studentName;
    private String subjectName;
    
    // Constructors
    public Mark() {}
    
    public Mark(int studentId, int subjectId, int semester, double marksObtained, String examType) {
        this.studentId = studentId;
        this.subjectId = subjectId;
        this.semester = semester;
        this.marksObtained = marksObtained;
        this.examType = examType;
        this.maxMarks = 100;
    }
    
    // Getters and Setters
    public int getMarkId() {
        return markId;
    }
    
    public void setMarkId(int markId) {
        this.markId = markId;
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
    
    public double getMarksObtained() {
        return marksObtained;
    }
    
    public void setMarksObtained(double marksObtained) {
        this.marksObtained = marksObtained;
    }
    
    public double getMaxMarks() {
        return maxMarks;
    }
    
    public void setMaxMarks(double maxMarks) {
        this.maxMarks = maxMarks;
    }
    
    public String getExamType() {
        return examType;
    }
    
    public void setExamType(String examType) {
        this.examType = examType;
    }
    
    public Timestamp getEnteredAt() {
        return enteredAt;
    }
    
    public void setEnteredAt(Timestamp enteredAt) {
        this.enteredAt = enteredAt;
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
        return "Mark{" +
                "markId=" + markId +
                ", studentId=" + studentId +
                ", subjectId=" + subjectId +
                ", semester=" + semester +
                ", marksObtained=" + marksObtained +
                ", examType='" + examType + '\'' +
                '}';
    }
}
