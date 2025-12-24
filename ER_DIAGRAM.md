# Entity-Relationship Diagram
## Student Management System

This document describes the ER diagram for the Student Management System database.

## Entities and Attributes

### 1. USER
**Purpose**: Stores authentication credentials for all system users (Admin and Students)

**Attributes**:
- `user_id` (PK): Unique identifier for each user
- `email` (UNIQUE): User's email address for login
- `password_hash`: SHA-256 hashed password
- `role`: ENUM('ADMIN', 'STUDENT')
- `created_at`: Timestamp of account creation

**Constraints**:
- PRIMARY KEY: user_id
- UNIQUE: email

---

### 2. STUDENT
**Purpose**: Stores student-specific profile information

**Attributes**:
- `student_id` (PK): Unique identifier for each student
- `user_id` (FK): Reference to users table
- `roll_no` (UNIQUE): Student roll number
- `full_name`: Student's full name
- `email` (UNIQUE): Student's email
- `course_id` (FK): Reference to courses table
- `status`: ENUM('PENDING', 'APPROVED', 'REJECTED')
- `registered_date`: Registration timestamp

**Constraints**:
- PRIMARY KEY: student_id
- FOREIGN KEY: user_id REFERENCES users(user_id)
- FOREIGN KEY: course_id REFERENCES courses(course_id)
- UNIQUE: user_id, roll_no, email

---

### 3. COURSE
**Purpose**: Catalog of available academic courses

**Attributes**:
- `course_id` (PK): Unique identifier for each course
- `course_name`: Name of the course
- `duration_years`: Course duration in years
- `created_at`: Timestamp

**Constraints**:
- PRIMARY KEY: course_id

---

### 4. SUBJECT
**Purpose**: Subjects/modules within each course

**Attributes**:
- `subject_id` (PK): Unique identifier for each subject
- `subject_code` (UNIQUE): Subject code (e.g., CS101)
- `subject_name`: Name of the subject
- `credits`: Credit hours for the subject
- `course_id` (FK): Reference to courses table
- `semester`: Semester number (1-8)

**Constraints**:
- PRIMARY KEY: subject_id
- FOREIGN KEY: course_id REFERENCES courses(course_id)
- UNIQUE: subject_code

---

### 5. ATTENDANCE
**Purpose**: Records daily attendance for students in each subject

**Attributes**:
- `attendance_id` (PK): Unique identifier
- `student_id` (FK): Reference to students table
- `subject_id` (FK): Reference to subjects table
- `attendance_date`: Date of attendance
- `status`: ENUM('PRESENT', 'ABSENT')
- `marked_at`: Timestamp when marked

**Constraints**:
- PRIMARY KEY: attendance_id
- FOREIGN KEY: student_id REFERENCES students(student_id)
- FOREIGN KEY: subject_id REFERENCES subjects(subject_id)
- UNIQUE: (student_id, subject_id, attendance_date)

---

### 6. MARKS
**Purpose**: Stores marks obtained by students in subjects

**Attributes**:
- `mark_id` (PK): Unique identifier
- `student_id` (FK): Reference to students table
- `subject_id` (FK): Reference to subjects table
- `semester`: Semester number
- `marks_obtained`: Marks scored (0-100)
- `max_marks`: Maximum marks (default 100)
- `exam_type`: ENUM('MIDTERM', 'ENDTERM', 'ASSIGNMENT', 'FINAL')
- `entered_at`: Timestamp

**Constraints**:
- PRIMARY KEY: mark_id
- FOREIGN KEY: student_id REFERENCES students(student_id)
- FOREIGN KEY: subject_id REFERENCES subjects(subject_id)
- CHECK: marks_obtained >= 0 AND marks_obtained <= 100

---

### 7. GRADES
**Purpose**: Auto-calculated grades based on marks

**Attributes**:
- `grade_id` (PK): Unique identifier
- `student_id` (FK): Reference to students table
- `subject_id` (FK): Reference to subjects table
- `semester`: Semester number
- `grade`: CHAR(2) - A+, A, B, C, F
- `grade_points`: DECIMAL(3,2) - 10.0, 9.0, 8.0, 7.0, 0.0
- `calculated_at`: Timestamp

**Constraints**:
- PRIMARY KEY: grade_id
- FOREIGN KEY: student_id REFERENCES students(student_id)
- FOREIGN KEY: subject_id REFERENCES subjects(subject_id)
- UNIQUE: (student_id, subject_id, semester)

---

### 8. AUDIT_LOGS
**Purpose**: System activity tracking for security and audit

**Attributes**:
- `log_id` (PK): Unique identifier
- `user_id` (FK): Reference to users table
- `action`: Type of action performed
- `table_name`: Affected table
- `record_id`: Affected record ID
- `details`: Additional details (TEXT)
- `ip_address`: User's IP address
- `created_at`: Timestamp

**Constraints**:
- PRIMARY KEY: log_id
- FOREIGN KEY: user_id REFERENCES users(user_id)

---

## Relationships

### ONE-TO-ONE
- **USER ↔ STUDENT**: Each student has exactly one user account
- Cardinality: 1:1
- Implementation: user_id in STUDENT table (UNIQUE constraint)

### ONE-TO-MANY

1. **COURSE → STUDENT**
   - One course has many students
   - Cardinality: 1:N
   - Implementation: course_id in STUDENT table

2. **COURSE → SUBJECT**
   - One course has many subjects
   - Cardinality: 1:N
   - Implementation: course_id in SUBJECT table

3. **STUDENT → ATTENDANCE**
   - One student has many attendance records
   - Cardinality: 1:N
   - Implementation: student_id in ATTENDANCE table

4. **SUBJECT → ATTENDANCE**
   - One subject has many attendance records
   - Cardinality: 1:N
   - Implementation: subject_id in ATTENDANCE table

5. **STUDENT → MARKS**
   - One student has many mark entries
   - Cardinality: 1:N
   - Implementation: student_id in MARKS table

6. **SUBJECT → MARKS**
   - One subject has many mark entries
   - Cardinality: 1:N
   - Implementation: subject_id in MARKS table

7. **STUDENT → GRADES**
   - One student has many grades
   - Cardinality: 1:N
   - Implementation: student_id in GRADES table

8. **SUBJECT → GRADES**
   - One subject has many grades
   - Cardinality: 1:N
   - Implementation: subject_id in GRADES table

9. **USER → AUDIT_LOGS**
   - One user performs many actions
   - Cardinality: 1:N
   - Implementation: user_id in AUDIT_LOGS table

---

## Normalization

The database follows **Third Normal Form (3NF)**:

### 1NF (First Normal Form):
- All attributes contain atomic values
- No repeating groups
- Each column contains values of a single type

### 2NF (Second Normal Form):
- Satisfies 1NF
- No partial dependencies (all non-key attributes depend on entire primary key)
- Example: In ATTENDANCE, both student_id and subject_id are needed to identify attendance_date

### 3NF (Third Normal Form):
- Satisfies 2NF
- No transitive dependencies
- Example: course_name is in COURSE table, not in STUDENT table (accessed via course_id)

---

## Database Views

### v_attendance_summary
**Purpose**: Calculates attendance percentage and defaulter status

**Columns**:
- student_id, full_name, roll_no
- subject_id, subject_name
- total_classes, classes_attended
- attendance_percentage
- defaulter_status ('AT RISK' if < 75%, 'SAFE' otherwise)

**Query Logic**:
```sql
SELECT students.*, subjects.*,
       COUNT(attendance) as total_classes,
       SUM(CASE WHEN status='PRESENT' THEN 1 ELSE 0 END) as attended,
       ROUND((attended * 100.0 / total_classes), 2) as percentage
FROM students 
JOIN attendance ON students.student_id = attendance.student_id
JOIN subjects ON attendance.subject_id = subjects.subject_id
GROUP BY student_id, subject_id
```

### v_cgpa_summary
**Purpose**: Calculates SGPA and CGPA for students

**Columns**:
- student_id, full_name, roll_no
- semester
- sgpa (per semester)
- cgpa (overall)

**Query Logic**:
```sql
SELECT student_id,
       AVG(grade_points) as sgpa,
       (SELECT AVG(grade_points) FROM grades WHERE student_id = g.student_id) as cgpa
FROM grades g
GROUP BY student_id, semester
```

---

## Text-Based ER Diagram

```
[USER]━━━━1:1━━━━[STUDENT]
  ┃                  ┃
  ┃                  ┃ 1:N
  ┃                  ┃
  1:N            [COURSE]
  ┃                  ┃
  ┃                  ┃ 1:N
  ┃                  ┃
[AUDIT_LOGS]     [SUBJECT]
                     ┃
              ┏━━━━━━╋━━━━━━┓
              ┃             ┃
              1:N           1:N
              ┃             ┃
         [ATTENDANCE]    [MARKS]━━━auto━━━>[GRADES]
              ┃             ┃                 ┃
              ┃             ┃                 ┃
              N:1           N:1              N:1
              ┃             ┃                 ┃
              ┗━━━━━━━[STUDENT]━━━━━━━━━━━━━━┛
```

---

## Key Database Features

1. **Referential Integrity**: All foreign keys have ON DELETE CASCADE or RESTRICT
2. **Data Validation**: CHECK constraints on marks (0-100)
3. **Uniqueness**: Prevents duplicate attendance entries, email addresses, roll numbers
4. **Indexes**: Created on frequently queried columns (email, roll_no, student_id + subject_id)
5. **Auto-increment**: Primary keys use AUTO_INCREMENT
6. **Timestamps**: Automatic timestamps for audit trails

---

This ER diagram represents a well-normalized, production-ready database schema suitable for a real-world Student Management System.
