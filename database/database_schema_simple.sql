-- Simplified Database Schema for Student Management System
-- Run after creating database

USE student_management_system;

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'STUDENT') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Students table  
CREATE TABLE IF NOT EXISTS students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    course_id INT,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    registered_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Courses table
CREATE TABLE IF NOT EXISTS courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    duration_years INT DEFAULT 4
);

-- Subjects table
CREATE TABLE IF NOT EXISTS subjects (
    subject_id INT PRIMARY KEY AUTO_INCREMENT,
    subject_code VARCHAR(20) UNIQUE NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    credits INT DEFAULT 3,
    course_id INT,
    semester INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Attendance table
CREATE TABLE IF NOT EXISTS attendance (
    attendance_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    attendance_date DATE NOT NULL,
    status ENUM('PRESENT', 'ABSENT') NOT NULL,
    marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    UNIQUE KEY unique_attendance (student_id, subject_id, attendance_date)
);

-- Marks table
CREATE TABLE IF NOT EXISTS marks (
    mark_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    semester INT NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    max_marks DECIMAL(5,2) DEFAULT 100,
    exam_type ENUM('MIDTERM', 'ENDTERM', 'ASSIGNMENT', 'FINAL') DEFAULT 'FINAL',
    entered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Grades table
CREATE TABLE IF NOT EXISTS grades (
    grade_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    subject_id INT,
    semester INT NOT NULL,
    grade CHAR(2) NOT NULL,
    grade_points DECIMAL(3,2) NOT NULL,
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id),
    UNIQUE KEY unique_grade (student_id, subject_id, semester)
);

-- Audit logs table
CREATE TABLE IF NOT EXISTS audit_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    action VARCHAR(255) NOT NULL,
    table_name VARCHAR(50),
    record_id INT,
    details TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);
