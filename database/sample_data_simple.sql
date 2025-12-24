-- Sample Data for Student Management System

USE student_management_system;

-- Insert Courses
INSERT INTO courses (course_name, duration_years) VALUES
('B.Tech Computer Science', 4),
('B.Tech Information Technology', 4),
('BCA', 3);

-- Insert Admin User (password: admin123, hashed with SHA-256)
INSERT INTO users (email, password_hash, role) VALUES
('admin@sms.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN');

-- Insert Student Users (password: student123 for all)
INSERT INTO users (email, password_hash, role) VALUES
('rajesh.kumar@student.com', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548', 'STUDENT'),
('priya.sharma@student.com', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548', 'STUDENT'),
('amit.patel@student.com', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548', 'STUDENT');

-- Insert Students (APPROVED)
INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(2, 'CS2021001', 'Rajesh Kumar', 'rajesh.kumar@student.com', 1, 'APPROVED'),
(3, 'CS2021002', 'Priya Sharma', 'priya.sharma@student.com', 1, 'APPROVED'),
(4, 'CS2021003', 'Amit Patel', 'amit.patel@student.com', 1, 'APPROVED');

-- Insert Subjects
INSERT INTO subjects (subject_code, subject_name, credits, course_id, semester) VALUES
('CS101', 'Programming in C', 4, 1, 1),
('CS102', 'Data Structures', 4, 1, 2),
('CS103', 'Database Management', 4, 1, 3);

-- Insert Sample Attendance (mix of present/absent)
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
-- Rajesh - Good attendance (90%)
(1, 1, '2025-01-01', 'PRESENT'),
(1, 1, '2025-01-02', 'PRESENT'),
(1, 1, '2025-01-03', 'PRESENT'),
(1, 1, '2025-01-04', 'PRESENT'),
(1, 1, '2025-01-05', 'PRESENT'),
-- Amit - Poor attendance (60%)
(3, 1, '2025-01-01', 'PRESENT'),
(3, 1, '2025-01-02', 'ABSENT'),
(3, 1, '2025-01-03', 'PRESENT'),
(3, 1, '2025-01-04', 'ABSENT'),
(3, 1, '2025-01-05', 'PRESENT');

-- Insert Sample Marks
INSERT INTO marks (student_id, subject_id, semester, marks_obtained, exam_type) VALUES
(1, 1, 1, 95, 'FINAL'),
(2, 1, 1, 88, 'FINAL'),
(3, 1, 1, 72, 'FINAL');
