-- ===============================================
-- Student Management System - Sample Data
-- ===============================================
-- This file inserts sample data for testing
-- ===============================================

USE student_management_system;

-- ===============================================
-- Insert Admin User
-- ===============================================
-- Password: admin123 (hashed using SHA-256)
INSERT INTO users (email, password_hash, role) VALUES
('admin@sms.com', SHA2('admin123', 256), 'ADMIN');

-- ===============================================
-- Insert Courses
-- ===============================================
INSERT INTO courses (course_name, duration_years) VALUES
('Bachelor of Technology - Computer Science', 4),
('Bachelor of Technology - Information Technology', 4),
('Bachelor of Computer Applications', 3),
('Bachelor of Technology - Electronics', 4);

-- ===============================================
-- Insert Sample Student Users
-- ===============================================
-- All student passwords: student123
INSERT INTO users (email, password_hash, role) VALUES
('rajesh.kumar@student.com', SHA2('student123', 256), 'STUDENT'),
('priya.sharma@student.com', SHA2('student123', 256), 'STUDENT'),
('amit.patel@student.com', SHA2('student123', 256), 'STUDENT'),
('sneha.reddy@student.com', SHA2('student123', 256), 'STUDENT'),
('vikram.singh@student.com', SHA2('student123', 256), 'STUDENT'),
('ananya.nair@student.com', SHA2('student123', 256), 'STUDENT'),
('rahul.verma@student.com', SHA2('student123', 256), 'STUDENT'),
('kavya.iyer@student.com', SHA2('student123', 256), 'STUDENT'),
('aditya.joshi@student.com', SHA2('student123', 256), 'STUDENT'),
('pooja.gupta@student.com', SHA2('student123', 256), 'STUDENT');

-- ===============================================
-- Insert Students (Approved)
-- ===============================================
INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(2, 'CS2021001', 'Rajesh Kumar', 'rajesh.kumar@student.com', 1, 'APPROVED'),
(3, 'CS2021002', 'Priya Sharma', 'priya.sharma@student.com', 1, 'APPROVED'),
(4, 'IT2021001', 'Amit Patel', 'amit.patel@student.com', 2, 'APPROVED'),
(5, 'IT2021002', 'Sneha Reddy', 'sneha.reddy@student.com', 2, 'APPROVED'),
(6, 'CS2021003', 'Vikram Singh', 'vikram.singh@student.com', 1, 'APPROVED'),
(7, 'BCA2021001', 'Ananya Nair', 'ananya.nair@student.com', 3, 'APPROVED'),
(8, 'CS2021004', 'Rahul Verma', 'rahul.verma@student.com', 1, 'APPROVED');

-- Insert Pending Students (for approval testing)
INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(9, 'IT2021003', 'Kavya Iyer', 'kavya.iyer@student.com', 2, 'PENDING'),
(10, 'BCA2021002', 'Aditya Joshi', 'aditya.joshi@student.com', 3, 'PENDING'),
(11, 'CS2021005', 'Pooja Gupta', 'pooja.gupta@student.com', 1, 'PENDING');

-- ===============================================
-- Insert Subjects (BTech CS - Semester 1 & 2)
-- ===============================================
INSERT INTO subjects (subject_code, subject_name, credits, course_id, semester) VALUES
-- Semester 1
('CS101', 'Programming in C', 4, 1, 1),
('CS102', 'Digital Logic Design', 4, 1, 1),
('MA101', 'Engineering Mathematics I', 4, 1, 1),
('PH101', 'Engineering Physics', 3, 1, 1),
('EN101', 'Technical Communication', 2, 1, 1),
-- Semester 2
('CS201', 'Data Structures', 4, 1, 2),
('CS202', 'Object Oriented Programming', 4, 1, 2),
('MA201', 'Engineering Mathematics II', 4, 1, 2),
('CH101', 'Engineering Chemistry', 3, 1, 2),
('CS203', 'Computer Organization', 3, 1, 2);

-- Insert Subjects for IT
INSERT INTO subjects (subject_code, subject_name, credits, course_id, semester) VALUES
('IT101', 'Introduction to IT', 4, 2, 1),
('IT102', 'Web Technologies', 4, 2, 1),
('IT103', 'Database Systems', 4, 2, 1);

-- Insert Subjects for BCA
INSERT INTO subjects (subject_code, subject_name, credits, course_id, semester) VALUES
('BCA101', 'Computer Fundamentals', 4, 3, 1),
('BCA102', 'Programming Principles', 4, 3, 1),
('BCA103', 'Business Communication', 3, 3, 1);

-- ===============================================
-- Insert Attendance Records (Last 30 days)
-- ===============================================
-- Student 1 (Rajesh Kumar) - Good Attendance
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
-- CS101 - 20 classes, 19 present (95%)
(1, 1, DATE_SUB(CURDATE(), INTERVAL 29 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 27 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 23 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 21 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 19 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 17 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 13 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 11 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 9 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 7 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'ABSENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 28 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 26 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 24 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 22 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 'PRESENT');

-- Student 3 (Amit Patel) - Poor Attendance (Defaulter)
-- IT101 - 20 classes, 13 present (65% - Below 75%)
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
(3, 11, DATE_SUB(CURDATE(), INTERVAL 29 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 27 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 23 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 21 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 19 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 17 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 13 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 11 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 9 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 7 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 28 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 26 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 24 DAY), 'ABSENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 22 DAY), 'PRESENT'),
(3, 11, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 'PRESENT');

-- Student 2 (Priya Sharma) - Borderline Attendance
-- CS102 - 20 classes, 15 present (75% - Exactly at threshold)
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
(2, 2, DATE_SUB(CURDATE(), INTERVAL 29 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 27 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 'ABSENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 23 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 21 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 19 DAY), 'ABSENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 17 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 13 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 11 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 9 DAY), 'ABSENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 7 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'ABSENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 28 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 26 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 24 DAY), 'ABSENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 22 DAY), 'PRESENT'),
(2, 2, DATE_SUB(CURDATE(), INTERVAL 20 DAY), 'PRESENT');

-- ===============================================
-- Insert Marks Records
-- ===============================================
-- Student 1 (Rajesh Kumar) - Semester 1 - Excellent Performance
INSERT INTO marks (student_id, subject_id, semester, marks_obtained, exam_type) VALUES
(1, 1, 1, 95.00, 'FINAL'),  -- CS101 - A+
(1, 2, 1, 88.00, 'FINAL'),  -- CS102 - A
(1, 3, 1, 92.00, 'FINAL'),  -- MA101 - A+
(1, 4, 1, 85.00, 'FINAL'),  -- PH101 - A
(1, 5, 1, 90.00, 'FINAL');  -- EN101 - A+

-- Student 2 (Priya Sharma) - Semester 1 - Good Performance
INSERT INTO marks (student_id, subject_id, semester, marks_obtained, exam_type) VALUES
(2, 1, 1, 82.00, 'FINAL'),  -- CS101 - A
(2, 2, 1, 78.00, 'FINAL'),  -- CS102 - B
(2, 3, 1, 75.00, 'FINAL'),  -- MA101 - B
(2, 4, 1, 80.00, 'FINAL'),  -- PH101 - A
(2, 5, 1, 88.00, 'FINAL');  -- EN101 - A

-- Student 3 (Amit Patel) - Semester 1 - Average Performance
INSERT INTO marks (student_id, subject_id, semester, marks_obtained, exam_type) VALUES
(3, 11, 1, 72.00, 'FINAL'), -- IT101 - B
(3, 12, 1, 65.00, 'FINAL'), -- IT102 - C
(3, 13, 1, 58.00, 'FINAL'); -- IT103 - F

-- ===============================================
-- Insert Auto-calculated Grades
-- ===============================================
-- Grade calculation based on marks:
-- 90-100: A+ (10.0), 80-89: A (9.0), 70-79: B (8.0), 60-69: C (7.0), <60: F (0.0)

-- Student 1 grades
INSERT INTO grades (student_id, subject_id, semester, grade, grade_points) VALUES
(1, 1, 1, 'A+', 10.0),
(1, 2, 1, 'A', 9.0),
(1, 3, 1, 'A+', 10.0),
(1, 4, 1, 'A', 9.0),
(1, 5, 1, 'A+', 10.0);

-- Student 2 grades
INSERT INTO grades (student_id, subject_id, semester, grade, grade_points) VALUES
(2, 1, 1, 'A', 9.0),
(2, 2, 1, 'B', 8.0),
(2, 3, 1, 'B', 8.0),
(2, 4, 1, 'A', 9.0),
(2, 5, 1, 'A', 9.0);

-- Student 3 grades
INSERT INTO grades (student_id, subject_id, semester, grade, grade_points) VALUES
(3, 11, 1, 'B', 8.0),
(3, 12, 1, 'C', 7.0),
(3, 13, 1, 'F', 0.0);

-- ===============================================
-- Insert Audit Logs
-- ===============================================
INSERT INTO audit_logs (user_id, action, table_name, details) VALUES
(1, 'LOGIN', 'users', 'Admin logged in'),
(1, 'STUDENT_APPROVAL', 'students', 'Approved student with roll_no: CS2021001'),
(1, 'MARKS_ENTRY', 'marks', 'Entered marks for CS101'),
(2, 'LOGIN', 'users', 'Student logged in');

-- ===============================================
-- Sample Data Insertion Complete
-- ===============================================
