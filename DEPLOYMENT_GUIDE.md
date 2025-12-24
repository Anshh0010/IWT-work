# Student Management System - Deployment Guide

## Quick Start Guide

This guide will help you deploy the Student Management System on Apache Tomcat.

---

## Step 1: Prerequisites Check

Ensure you have:
- [x] Java JDK 8 or higher installed
- [x] Apache Tomcat 9.x or 10.x installed
- [x] MySQL Server 8.x running
- [x] MySQL root password is: `Root`

### Verify Installations:

**Check Java:**
```bash
java -version
```
Expected: Java version 8 or higher

**Check MySQL:**
```bash
mysql --version
```
Expected: MySQL 8.x

**Check Tomcat:**
Navigate to `TOMCAT_HOME/bin` and run:
```bash
catalina.bat version
```

---

## Step 2: Download Required JAR Files

You need these JAR files:

### 1. MySQL JDBC Connector
- Download: https://dev.mysql.com/downloads/connector/j/
- Version: 8.0.x
- File: `mysql-connector-java-8.0.33.jar` (or latest 8.0.x)

### 2. JSTL Library
- Download: https://tomcat.apache.org/download-taglibs.cgi
- Files needed:
  - `jstl-1.2.jar`
  - `standard-1.1.2.jar` (optional, for older Tomcat)

### Where to Place JAR Files:

**Option A: Tomcat lib (Recommended)**
```
TOMCAT_HOME/lib/
├── mysql-connector-java-8.0.33.jar
└── jstl-1.2.jar
```

**Option B: Application lib**
```
DBMS project 2/src/main/webapp/WEB-INF/lib/
├── mysql-connector-java-8.0.33.jar
└── jstl-1.2.jar
```

---

## Step 3: Database Setup

### Automated Setup (Windows):

1. Open Command Prompt
2. Navigate to project directory:
   ```bash
   cd "c:\Users\HP\DBMS project 2"
   ```

3. Run setup script:
   ```bash
   setup_database.bat
   ```

### Manual Setup:

```bash
# Method 1: Direct command
mysql -u root -pRoot < database\database_schema.sql
mysql -u root -pRoot < database\sample_data.sql

# Method 2: MySQL Shell
mysql -u root -pRoot
source database/database_schema.sql;
source database/sample_data.sql;
exit;
```

### Verify Database:

```sql
USE student_management_system;
SHOW TABLES;
-- Should show 8 tables

SELECT * FROM users;
-- Should show admin and student accounts

SELECT * FROM v_attendance_summary;
-- Should show attendance statistics
```

---

## Step 4: Deploy to Tomcat

### Method 1: WAR File Deployment (Recommended)

1. **Create WAR file:**
   - Using Eclipse: Right-click project → Export → WAR file
   - Using IntelliJ: Build → Build Artifacts → WAR
   - Manual: Use `jar` command from webapp directory

2. **Deploy:**
   - Copy WAR file to `TOMCAT_HOME/webapps/`
   - Rename to `StudentManagementSystem.war` (optional, for cleaner URL)
   - Tomcat will auto-deploy

3. **Access:**
   ```
   http://localhost:8080/StudentManagementSystem/
   ```

### Method 2: Exploded Directory Deployment

1. **Copy entire project:**
   ```
   Copy folder: DBMS project 2/src/main/webapp
   To: TOMCAT_HOME/webapps/StudentManagementSystem/
   ```

2. **Copy compiled classes:**
   ```
   Copy folder: DBMS project 2/src/main/java/com (compiled .class files)
   To: TOMCAT_HOME/webapps/StudentManagementSystem/WEB-INF/classes/com/
   ```

   **Note:** You need to compile Java files first:
   ```bash
   javac -cp "path/to/servlet-api.jar;path/to/mysql-connector.jar" src/main/java/com/sms/*/*.java
   ```

3. **Access:**
   ```
   http://localhost:8080/StudentManagementSystem/
   ```

---

## Step 5: Start Tomcat

### Windows:
```bash
cd TOMCAT_HOME\bin
startup.bat
```

### Linux/Mac:
```bash
cd TOMCAT_HOME/bin
./startup.sh
```

### Verify Tomcat is Running:
- Open browser: `http://localhost:8080`
- Should see Tomcat welcome page

---

## Step 6: Access Application

### Main URL:
```
http://localhost:8080/StudentManagementSystem/
```
(Replace "StudentManagementSystem" with your WAR filename)

OR (if using context path from project):
```
http://localhost:8080/DBMS_project_2/
```

### Login Credentials:

**Admin Account:**
- Email: `admin@sms.com`
- Password: `admin123`

**Student Account (Approved):**
- Email: `rajesh.kumar@student.com`
- Password: `student123`

**Student Account (Pending Approval):**
- Email: `kavya.iyer@student.com`
- Password: `student123`

---

## Step 7: Testing Checklist

### Database Tests:
- [x] Database `student_management_system` exists
- [x] All 8 tables created
- [x] Sample data inserted (admin + 10 students)
- [x] Views v_attendance_summary and v_cgpa_summary working

### Application Tests:
- [x] Login page loads
- [x] Admin can login
- [x] Student can login
- [x] Pending students get "approval required" message
- [x] Admin dashboard shows statistics
- [x] Student dashboard shows attendance warnings
- [x] Attendance defaulter list shows students with <75%
- [x] Marks entry triggers auto-grading
- [x] CGPA calculations are correct

---

## Troubleshooting

### Issue: ClassNotFoundException for MySQL Driver
**Solution:**
- Verify `mysql-connector-java-8.0.x.jar` is in Tomcat lib folder
- Restart Tomcat after adding JARs

### Issue: Database connection fails
**Solution:**
- Check MySQL is running: `net start MySQL80` (Windows)
- Verify credentials in `DatabaseUtil.java`
- Test connection: `mysql -u root -pRoot`

### Issue: JSTL errors in JSP
**Solution:**
- Add `jstl-1.2.jar` to Tomcat lib or WEB-INF/lib
- Restart Tomcat

### Issue: 404 Page Not Found
**Solution:**
- Check Tomcat logs: `TOMCAT_HOME/logs/catalina.out`
- Verify context path matches URL
- Check web.xml is in WEB-INF folder

### Issue: 500 Internal Server Error
**Solution:**
- Check Tomcat logs for stack trace
- Verify all Java classes are compiled
- Check database connection settings

### Issue: Session/Login not working
**Solution:**
- Clear browser cookies
- Check filters are active
- Verify SessionUtil is working

---

## Project Structure for Deployment

Correct directory structure for Tomcat:

```
webapps/StudentManagementSystem/
├── admin/
│   ├── attendance-entry.jsp
│   ├── dashboard.jsp
│   ├── defaulters-report.jsp
│   ├── marks-entry.jsp
│   └── pending-approvals.jsp
├── student/
│   ├── attendance.jsp
│   ├── dashboard.jsp
│   └── grades.jsp
├── WEB-INF/
│   ├── web.xml
│   ├── lib/
│   │   ├── mysql-connector-java-8.0.33.jar
│   │   └── jstl-1.2.jar
│   └── classes/
│       └── com/
│           └── sms/
│               ├── dao/
│               ├── filter/
│               ├── model/
│               ├── servlet/
│               └── util/
├── login.jsp
└── register.jsp
```

---

## Port Configuration

If port 8080 is already in use, change Tomcat port:

1. Edit `TOMCAT_HOME/conf/server.xml`
2. Find: `<Connector port="8080"`
3. Change to: `<Connector port="8081"` (or any available port)
4. Restart Tomcat
5. Access: `http://localhost:8081/StudentManagementSystem/`

---

## Database Backup

To backup your database:

```bash
mysqldump -u root -pRoot student_management_system > backup.sql
```

To restore:

```bash
mysql -u root -pRoot student_management_system < backup.sql
```

---

## Production Deployment Tips

For production deployment:

1. **Change Default Password:**
   - Change MySQL root password
   - Update `DatabaseUtil.java` with new credentials

2. **Security:**
   - Use environment variables for credentials
   - Enable HTTPS/SSL
   - Implement CSRF protection

3. **Performance:**
   - Enable connection pooling (e.g., HikariCP)
   - Add database indexes
   - Enable Tomcat compression

4. **Monitoring:**
   - Enable Tomcat access logs
   - Monitor database performance
   - Set up application logging

---

## Next Steps After Deployment

1. **Test All Features:**
   - Register new student
   - Admin approves student
   - Mark attendance
   - Enter marks and verify auto-grading
   - Check defaulter reports

2. **Customize:**
   - Add more courses/subjects
   - Configure email notifications (future)
   - Add reporting features (future)

3. **Documentation:**
   - Review README.md
   - Check ER_DIAGRAM.md for database structure
   - Read walkthrough.md for feature details

---

## Success Indicators

Your deployment is successful when:

✅ Login page loads without errors  
✅ Admin can login and see dashboard statistics  
✅ Student can login and see attendance/CGPA  
✅ Attendance < 75% shows "AT RISK" warning  
✅ Entering marks automatically assigns grades  
✅ CGPA calculates correctly  
✅ No errors in Tomcat logs  

---

## Support

For issues:
1. Check Tomcat logs: `TOMCAT_HOME/logs/catalina.out`
2. Review README.md for setup instructions
3. Verify database connectivity with MySQL Workbench
4. Test servlets individually

---

**Deployment Complete!** 🎉

Your Student Management System is now ready to use.
