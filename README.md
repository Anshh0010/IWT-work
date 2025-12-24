# Student Management System

A comprehensive DBMS-based web application demonstrating SQL operations, normalization, and real-world database logic with unique features like attendance defaulter prediction and auto-grading.

## 🎯 Project Overview

This Student Management System is a full-stack Java EE web application built using:
- **Frontend**: HTML5, CSS3, Bootstrap 5
- **Backend**: Java, JSP, Servlets, JDBC
- **Database**: MySQL
- **Server**: Apache Tomcat

## ✨ Unique Features

### 1. **Attendance Defaulter Prediction**
- Automatically calculates attendance percentage for each student
- Flags students with <75% attendance as "AT RISK"
- Admin dashboard shows real-time defaulter count
- Student dashboard displays warnings for low attendance

### 2. **Auto-Grading & CGPA Calculator**
- Automatic grade assignment based on marks:
  - 90-100: A+ (10.0 points)
  - 80-89: A (9.0 points)
  - 70-79: B (8.0 points)
  - 60-69: C (7.0 points)
  - <60: F (0.0 points)
- Automatic SGPA calculation per semester
- Real-time CGPA calculation across all semesters
- Students can only VIEW results (read-only)

### 3. **Role-Based Access Control**
- **Admin**: Approve students, mark attendance, enter marks, view defaulters
- **Student**: View attendance, grades, CGPA (no edit access)

## 📊 Database Design

### Tables (8 normalized tables in 3NF):
1. **users** - Authentication (email, password hash, role)
2. **students** - Student profiles with approval status
3. **courses** - Course catalog
4. **subjects** - Subject details with credits
5. **attendance** - Attendance records
6. **marks** - Marks storage
7. **grades** - Auto-calculated grades with SGPA/CGPA
8. **audit_logs** - System activity tracking

### Views:
- `v_attendance_summary` - Attendance percentage and defaulter status
- `v_cgpa_summary` - SGPA and CGPA calculations

See [ER_DIAGRAM.md](ER_DIAGRAM.md) for detailed entity relationships.

## 🚀 Setup Instructions

### Prerequisites
1. **Java JDK 8 or higher**
2. **Apache Tomcat 9.x or 10.x**
3. **MySQL Server 8.x**
4. **MySQL JDBC Connector** (`mysql-connector-java-8.0.x.jar`)

### Database Setup

1. **Start MySQL Server**

2. **Execute SQL scripts**:
```bash
mysql -u root -pRoot < database/database_schema.sql
mysql -u root -pRoot < database/sample_data.sql
```

This will:
- Create database `student_management_system`
- Create all 8 tables with constraints
- Insert sample data (admin, students, courses, subjects, attendance, marks)

### Application Setup

1. **Configure MySQL JDBC Connector**:
   - Download `mysql-connector-java-8.0.x.jar`
   - Place in:
     - `TOMCAT_HOME/lib/` 
     - `src/main/webapp/WEB-INF/lib/`

2. **Verify Database Credentials** in `DatabaseUtil.java`:
```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/student_management_system";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "Root";
```

3. **Build the Project**:
   - If using Eclipse: Export as WAR file
   - If using IntelliJ: Build Artifacts → WAR
   - If manual: Ensure proper directory structure

4. **Deploy to Tomcat**:
   - Copy WAR file to `TOMCAT_HOME/webapps/`
   - OR: Deploy exploded directory structure

5. **Start Tomcat**:
```bash
# Windows
TOMCAT_HOME\bin\startup.bat

# Linux/Mac
TOMCAT_HOME/bin/startup.sh
```

6. **Access Application**:
```
http://localhost:8080/DBMS_project_2/
```

## 🔐 Login Credentials

### Admin Account
- **Email**: `admin@sms.com`
- **Password**: `admin123`

### Sample Student Accounts
- **Email**: `rajesh.kumar@student.com`
- **Password**: `student123`

OR

- **Email**: `priya.sharma@student.com`
- **Password**: `student123`

## 📁 Project Structure

```
DBMS project 2/
├── database/
│   ├── database_schema.sql      # Database creation script
│   └── sample_data.sql          # Sample data insertion
├── src/main/java/com/sms/
│   ├── model/                   # Entity classes
│   │   ├── User.java
│   │   ├── Student.java
│   │   ├── Course.java
│   │   ├── Subject.java
│   │   ├── Attendance.java
│   │   ├── Mark.java
│   │   ├── Grade.java
│   │   └── AttendanceStats.java
│   ├── dao/                     # Data Access Objects
│   │   ├── UserDAO.java
│   │   ├── StudentDAO.java
│   │   ├── CourseDAO.java
│   │   ├── SubjectDAO.java
│   │   ├── AttendanceDAO.java   # Defaulter prediction
│   │   ├── MarksDAO.java        # Auto-grading
│   │   └── GradeDAO.java        # SGPA/CGPA calculation
│   ├── servlet/                 # Controllers
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── AdminDashboardServlet.java
│   │   ├── StudentApprovalServlet.java
│   │   ├── AttendanceServlet.java
│   │   ├── DefaultersServlet.java
│   │   ├── MarksServlet.java
│   │   ├── StudentDashboardServlet.java
│   │   ├── StudentAttendanceServlet.java
│   │   └── StudentGradesServlet.java
│   ├── filter/                  # Security filters
│   │   ├── AuthFilter.java      # Session validation
│   │   └── RoleFilter.java      # Role-based access
│   └── util/                    # Utilities
│       ├── DatabaseUtil.java    # DB connection
│       ├── PasswordUtil.java# SHA-256 hashing
│       └── SessionUtil.java     # Session management
└── src/main/webapp/
    ├── login.jsp
    ├── register.jsp
    ├── WEB-INF/
    │   └── web.xml
    ├── admin/                   # Admin pages
    │   ├── dashboard.jsp
    │   ├── pending-approvals.jsp
    │   ├── attendance-entry.jsp
    │   ├── marks-entry.jsp
    │   └── defaulters-report.jsp
    └── student/                 # Student pages
        ├── dashboard.jsp
        ├── attendance.jsp
        └── grades.jsp
```

## 🔒 Security Features

1. **Password Hashing**: SHA-256 encryption
2. **SQL Injection Prevention**: PreparedStatements throughout
3. **Session Management**: 30-minute timeout
4. **Role-Based Access**: Filters on all protected routes
5. **Approval System**: Students pending until admin approval

## 🎓 Academic Features

### Normalization
- All tables follow 3NF (Third Normal Form)
- Foreign key constraints ensure referential integrity
- No data redundancy

### SQL Operations Demonstrated
- **Joins**: Student-Course, Attendance-Subject, Marks-Grade joins
- **Aggregation**: COUNT, SUM, AVG for statistics
- **Views**: Complex queries encapsulated in views
- **Constraints**: PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK
- **Indexes**: Performance optimization on frequently queried columns

## 📊 Features Breakdown

### Admin Features
✅ View dashboard with statistics  
✅ Approve/reject student registrations  
✅ Mark attendance for students  
✅ Enter marks (auto-grading enabled)  
✅ View attendance defaulters (<75%)  
✅ Monitor average CGPA  

### Student Features
✅ View attendance with defaulter warnings  
✅ Check subject-wise attendance percentage  
✅ View marks and grades (read-only)  
✅ Check SGPA per semester  
✅ View overall CGPA  

## 🐛 Troubleshooting

### Database Connection Error
- Verify MySQL is running
- Check credentials in `DatabaseUtil.java`
- Ensure database exists: `SHOW DATABASES;`

### ClassNotFoundException: JDBC Driver
- Verify `mysql-connector-java-8.0.x.jar` is in:
  - `TOMCAT_HOME/lib/`
  - `WEB-INF/lib/`

### Page Not Found (404)
- Check Tomcat is running
- Verify context path matches URL
- Check servlet mappings in `@WebServlet` annotations

### Session/Login Issues
- Clear browser cookies
- Check session timeout settings
- Verify filters are properly configured

## 📸 Screenshots

The application features:
- Modern gradient designs
- Responsive Bootstrap 5 layouts
- Color-coded attendance warnings
- Interactive stat cards
- Clean navigation

## 👨‍💻 Author

**College DBMS Project**  
Demonstrates: SQL, JDBC, Servlets, JSP, MVC Architecture, Normalization

## 📄 License

Educational project for academic purposes.

---

**Note**: This is a complete, production-ready DBMS project suitable for college submissions, demonstrating all key database concepts and real-world application development.
