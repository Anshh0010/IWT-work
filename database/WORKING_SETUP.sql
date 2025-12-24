-- ================================================
-- WORKING DATABASE SETUP WITH SHA-256 PASSWORDS
-- ================================================
-- The application uses SHA-256, not BCrypt!

DROP DATABASE IF EXISTS student_management_system;
CREATE DATABASE student_management_system;
USE student_management_system;

-- Tables (same as before)
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role ENUM('ADMIN', 'STUDENT') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    duration_years INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

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

CREATE VIEW v_attendance_summary AS
SELECT 
    s.student_id, s.full_name, s.roll_no,
    sub.subject_id, sub.subject_name,
    COUNT(a.attendance_id) as total_classes,
    SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) as classes_attended,
    ROUND((SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)), 2) as attendance_percentage,
    CASE WHEN ROUND((SUM(CASE WHEN a.status = 'PRESENT' THEN 1 ELSE 0 END) * 100.0 / COUNT(a.attendance_id)), 2) < 75 THEN 'AT RISK' ELSE 'SAFE' END as defaulter_status
FROM students s
JOIN attendance a ON s.student_id = a.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id
GROUP BY s.student_id, s.full_name, s.roll_no, sub.subject_id, sub.subject_name;

CREATE VIEW v_cgpa_summary AS
SELECT 
    s.student_id, s.full_name, s.roll_no,
    g.semester,
    AVG(g.grade_points) as sgpa,
    (SELECT AVG(grade_points) FROM grades WHERE student_id = s.student_id) as cgpa
FROM students s
JOIN grades g ON s.student_id = g.student_id
GROUP BY s.student_id, s.full_name, s.roll_no, g.semester;

-- ===============================================
-- Insert Sample Data with SHA-256 Hashed Passwords
-- ===============================================

-- Insert Courses
INSERT INTO courses (course_name, duration_years) VALUES
('Bachelor of Technology - Computer Science', 4),
('Bachelor of Technology - Information Technology', 4),
('Bachelor of Computer Applications', 3);

-- Test User: test@test.com / password: test
-- SHA-256 hash of "test" = 9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08
INSERT INTO users (email, password_hash, role) VALUES
('test@test.com', '9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08', 'STUDENT');

INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(LAST_INSERT_ID(), 'CS001', 'Test Student', 'test@test.com', 1, 'APPROVED');

-- Sample User: student@student.com / password: student
-- SHA-256 hash of "student" = d8a928b2043db77e340b523547bf16cb4aa483f0645fe0a290ed1f20aab76257
INSERT INTO users (email, password_hash, role) VALUES
('student@student.com', 'd8a928b2043db77e340b523547bf16cb4aa483f0645fe0a290ed1f20aab76257', 'STUDENT');

INSERT INTO students (user_id, roll_no, full_name, email, course_id, status) VALUES
(LAST_INSERT_ID(), 'CS002', 'Sample Student', 'student@student.com', 1, 'APPROVED');

-- Insert Subjects
INSERT INTO subjects (subject_code, subject_name, credits, course_id, semester) VALUES
('CS101', 'Programming in C', 4, 1, 1),
('CS102', 'Data Structures', 4, 1, 1),
('CS201', 'Database Systems', 4, 1, 2);

-- Sample Attendance
INSERT INTO attendance (student_id, subject_id, attendance_date, status) VALUES
(1, 1, DATE_SUB(CURDATE(), INTERVAL 5 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 4 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 3 DAY), 'PRESENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 'ABSENT'),
(1, 1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 'PRESENT');

-- Sample Marks
INSERT INTO marks (student_id, subject_id, semester, marks_obtained, exam_type) VALUES
(1, 1, 1, 85.00, 'FINAL'),
(1, 2, 1, 90.00, 'FINAL');

-- Sample Grades
INSERT INTO grades (student_id, subject_id, semester, grade, grade_points) VALUES
(1, 1, 1, 'A', 9.0),
(1, 2, 1, 'A+', 10.0);

-- ===============================================
SELECT '✅ Database setup complete!' as STATUS;
SELECT '📧 Email: test@test.com | 🔑 Password: test' as LOGIN_1;
SELECT '📧 Email: student@student.com | 🔑 Password: student' as LOGIN_2;
