# Complete Setup Instructions

## Step-by-Step Database Setup

### 1. Set Up Database Structure
```bash
mysql -u root -pansh < database/database_schema.sql
```

### 2. Add Sample Data with Test Users
```bash
mysql -u root -pansh < database/setup_complete.sql
```

### 3. Test Login Credentials
After running the setup, you can login with these accounts:

| Email | Password | Name |
|-------|----------|------|
| test@student.com | student123 | Test Student |
| john@student.com | student123 | John Doe |
| jane@student.com | student123 | Jane Smith |

---

## Alternative: Manual Database Setup via MySQL Workbench

1. **Open MySQL Workbench**
2. **Connect** to localhost (root/ansh)
3. **File → Run SQL Script**
4. **Select**: `database/database_schema.sql` → Run
5. **File → Run SQL Script** again
6. **Select**: `database/setup_complete.sql` → Run
7. **Done!**

---

## Testing the Application

### 1. Start Tomcat
```bash
# Navigate to Tomcat bin directory
cd "C:\Program Files\Apache Software Foundation\Tomcat 10.1\bin"
startup.bat
```

### 2. Access Application
- **URL**: `http://localhost:8080/webapp/`
- **Click**: "Register here" OR use test credentials above

### 3. Login
- **Email**: test@student.com
- **Password**: student123
- **Click**: Login

### 4. Verify Dashboard
- Should see student dashboard with:
  - Student name and details
  - Attendance overview
  - Grades and CGPA

---

## Troubleshooting

### Issue: "Invalid email or password"

**Solution 1**: Register a new account
- Click "Register here"
- Fill in all fields
- Submit
- Login immediately (auto-approved)

**Solution 2**: Verify database has data
```sql
USE student_management_system;
SELECT * FROM users;
SELECT * FROM students;
```

### Issue: "Database connection failed"

**Check**:
1. MySQL is running
2. Password in `DatabaseUtil.java` is "ansh"
3. Database name is `student_management_system`

**Fix**:
```bash
# Start MySQL if not running
net start MySQL80
```

### Issue: Empty dashboard

**Fix**: Run the sample data again
```bash
mysql -u root -pansh < database/setup_complete.sql
```

---

## Quick Registration Flow (No Database Needed)

If you don't want to use SQL scripts:

1. **Go to**: `http://localhost:8080/webapp/`
2. **Click**: "Register here"
3. **Fill in**:
   - Full Name: Your Name
   - Roll No: Any number (CS001, IT002, etc.)
   - Email: yourname@student.com
   - Password: yourpassword
   - Course: Select any
4. **Submit**
5. **Login** immediately with your credentials
6. **Done!** (Auto-approved, no waiting)

---

## What's Included in Sample Data

- ✅ 3 test students (all password: student123)
- ✅ 3 courses (CS, IT, BCA)
- ✅ 8 subjects
- ✅ Sample attendance records
- ✅ Sample marks and grades
- ✅ All students auto-approved

Your system is ready to use!
