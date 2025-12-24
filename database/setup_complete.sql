-- ================================================
-- COMPLETE DATABASE SETUP WITH SAMPLE DATA
-- ================================================
-- Run this entire script to set up the database
-- Password for all test users: "student123"

USE student_management_system;

-- ================================================
-- Insert Courses
-- ================================================
INSERT INTO courses (course_name, duration_years) VALUES
('Bachelor of Technology - Computer Science', 4),
('Bachelor of Technology - Information Technology', 4),
('Bachelor of Computer Applications', 3);

-- ================================================
-- Insert Sample Students with BCrypt Hashed Passwords
-- ================================================
-- NOTE: These use BCrypt hashing which matches the application
-- Password for all: student123
-- BCrypt hash: $2a$10$N9qo8uLOickgx2ZMRZoMye.IjZAgcfl7p92ldGxad68LJZdL17lhWy

-- Student 1: test@student.com
INSERT INTO users (email, password_hash, role) VALUES
('test@student.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye.IjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT');

INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(LAST_INSERT_ID(), 'CS001', 'Test Student', 'test@student.com', 1, 'APPROVED');

-- Student 2: john@student.com
INSERT INTO users (email, password_hash, role) VALUES
('john@student.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye.IjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT');

INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(LAST_INSERT_ID(), 'CS002', 'John Doe', 'john@student.com', 1, 'APPROVED');

-- Student 3: jane@student.com
INSERT INTO users (email, password_hash, role) VALUES
('jane@student.com', '$2a$10$N9qo8uLOickgx2ZMRZoMye.IjZAgcfl7p92ldGxad68LJZdL17lhWy', 'STUDENT');

INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(LAST_INSERT_ID(), 'IT001', 'Jane Smith', 'jane@student.com', 2, 'APPROVED');

-- ================================================
-- Insert Subjects
-- ================================================
INSERT INTO subjects (subject_code, subject_name, credits, course_id, semester) VALUES
-- CS Semester 1
('CS101', 'Programming in C', 4, 1, 1),
('CS102', 'Digital Logic Design', 4, 1, 1),
('MA101', 'Engineering Mathematics I', 4, 1, 1),
-- CS Semester 2
('CS201', 'Data Structures', 4, 1, 2),
('CS202', 'Object Oriented Programming', 4, 1, 2),
-- IT Semester 1
('IT101', 'Introduction to IT', 4, 2, 1),
('IT102', 'Web Technologies', 4, 2, 1),
('IT103', 'Database Systems', 4, 2, 1);

-- ================================================
-- Sample Attendance Data
-- ================================================
-- Test Student - Good attendance
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
(1, 1, DATE_SUB(CURDATE(), INTERVAL 10 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 9 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 8 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 7 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 6 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 4 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'ABSENT');

-- ================================================
-- Sample Marks and Grades
-- ================================================
-- Test Student marks
INSERT INTO marks (student_id, subject_id, semester, marks_obtained, exam_type) VALUES
(1, 1, 1, 85.00, 'FINAL'),
(1, 2, 1, 90.00, 'FINAL'),
(1, 3, 1, 78.00, 'FINAL');

-- Auto-calculated grades
INSERT INTO grades (student_id, subject_id, semester, grade, grade_points) VALUES
(1, 1, 1, 'A', 9.0),
(1, 2, 1, 'A+', 10.0),
(1, 3, 1, 'B', 8.0);

-- ================================================
-- Verification Queries
-- ================================================
SELECT 'Database setup complete!' as status;
SELECT 'Test these login credentials:' as info;
SELECT email, 'student123' as password FROM users WHERE role = 'STUDENT';
