-- ===============================================
-- Student Management System - Database Schema
-- ===============================================
-- MySQL Database: student_management_system
-- Username: root
-- Password: ansh
-- ===============================================

-- Drop database if exists (for clean setup)
DROP DATABASE IF EXISTS student_management_system;

-- Create database
CREATE DATABASE student_management_system;

-- Use the database
USE student_management_system;

-- ===============================================
-- Table 1: users (Authentication)
-- ===============================================
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'STUDENT') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 2: courses
-- ===============================================
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration_years INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 3: students
-- ===============================================
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE,
    roll_no VARCHAR(20) UNIQUE NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    course_id INT NOT NULL,
    status ENUM('PENDING', 'APPROVED', 'REJECTED') DEFAULT 'PENDING',
    registered_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE RESTRICT,
    INDEX idx_status (status),
    INDEX idx_roll_no (roll_no)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 4: subjects
-- ===============================================
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_code VARCHAR(20) UNIQUE NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    course_id INT NOT NULL,
    semester INT NOT NULL,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE,
    INDEX idx_course_semester (course_id, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 5: attendance (Attendance Tracking)
-- ===============================================
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('PRESENT', 'ABSENT') NOT NULL,
    marked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE,
    UNIQUE KEY unique_attendance (student_id, subject_id, attendance_date),
    INDEX idx_student_subject (student_id, subject_id),
    INDEX idx_date (attendance_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 6: marks (Marks Storage)
-- ===============================================
CREATE TABLE marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    semester INT NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL CHECK (marks_obtained >= 0 AND marks_obtained <= 100),
    max_marks DECIMAL(5,2) DEFAULT 100,
    exam_type ENUM('MIDTERM', 'ENDTERM', 'ASSIGNMENT', 'FINAL') DEFAULT 'FINAL',
    entered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE,
    INDEX idx_student_semester (student_id, semester)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 7: grades (Auto-calculated Grades)
-- ===============================================
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    semester INT NOT NULL,
    grade CHAR(2) NOT NULL,
    grade_points DECIMAL(3,2) NOT NULL,
    calculated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id) ON DELETE CASCADE,
    UNIQUE KEY unique_grade (student_id, subject_id, semester),
    INDEX idx_student (student_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Table 8: audit_logs (System Activity Tracking)
-- ===============================================
CREATE TABLE audit_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(100) NOT NULL,
    table_name VARCHAR(50),
    record_id INT,
    details TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    INDEX idx_user_action (user_id, action),
    INDEX idx_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ===============================================
-- Views for Reporting
-- ===============================================

-- View: Student Attendance Percentage
CREATE VIEW v_attendance_summary AS
SELECT 
    s.student_id,
    s.full_name,
    s.roll_no,
    sub.subject_id,
    sub.subject_name,
    COUNT(a.attendance_id) as total_classes,
    SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) as classes_attended,
    ROUND((SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)), 2) as attendance_percentage,
    CASE 
        WHEN ROUND((SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)), 2) < 75 
        THEN 'AT RISK' 
        ELSE 'SAFE' 
    END as defaulter_status
FROM students s
JOIN attendance a ON s.student_id = a.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id
GROUP BY s.student_id, s.full_name, s.roll_no, sub.subject_id, sub.subject_name;

-- View: Student CGPA Summary
CREATE VIEW v_cgpa_summary AS
SELECT 
    s.student_id,
    s.full_name,
    s.roll_no,
    g.semester,
    AVG(g.grade_points) as sgpa,
    (SELECT AVG(grade_points) FROM grades WHERE student_id = s.student_id) as cgpa
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.full_name, s.roll_no, g.semester;

-- ===============================================
-- Database Setup Complete
-- ===============================================
