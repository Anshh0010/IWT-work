package com.sms.model;

/**
 * Subject Model Class
 * Represents a subject/course in the curriculum
 */
public class Subject {
    private int subjectId;
    private String subjectCode;
    private String subjectName;
    private int credits;
    private int courseId;
    private int semester;
    
    // Constructors
    public Subject() {}
    
    public Subject(String subjectCode, String subjectName, int credits, int courseId, int semester) {
        this.subjectCode = subjectCode;
        this.subjectName = subjectName;
        this.credits = credits;
        this.courseId = courseId;
        this.semester = semester;
    }
    
    // Getters and Setters
    public int getSubjectId() {
        return subjectId;
    }
    
    public void setSubjectId(int subjectId) {
        this.subjectId = subjectId;
    }
    
    public String getSubjectCode() {
        return subjectCode;
    }
    
    public void setSubjectCode(String subjectCode) {
        this.subjectCode = subjectCode;
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
    
    public int getCourseId() {
        return courseId;
    }
    
    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }
    
    public int getSemester() {
        return semester;
    }
    
    public void setSemester(int semester) {
        this.semester = semester;
    }
    
    @Override
    public String toString() {
        return "Subject{" +
                "subjectId=" + subjectId +
                ", subjectCode='" + subjectCode + '\'' +
                ", subjectName='" + subjectName + '\'' +
                ", credits=" + credits +
                ", semester=" + semester +
                '}';
    }
}
