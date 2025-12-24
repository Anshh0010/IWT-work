# FINAL CHECKLIST - Let's Get This Running!

## ✅ COMPLETED:
- [x] Password changed to "root" in DatabaseUtil.java
- [x] Application deployed to Tomcat
- [x] Tomcat is running

## ❌ TODO (2 simple steps):

### Step 1: Setup Database (5 minutes)

**Open MySQL Workbench:**
1. Click **"Connect to Database"**
2. Password: `root` (lowercase)
3. Click **OK**

**Run SQL Scripts:**
1. Click **File** → **Open SQL Script**
2. Select: `C:\Users\HP\DBMS project 2\database\database_schema.sql`
3. Click the **lightning bolt icon** (Execute)
4. Wait for "Action Output" to show success
5. Click **File** → **Open SQL Script** again
6. Select: `C:\Users\HP\DBMS project 2\database\sample_data.sql`
7. Click the **lightning bolt icon** (Execute)

**Verify:**
Run this query to confirm:
```sql
USE student_management_system;
SHOW TABLES;
SELECT * FROM users;
```

You should see 8 tables and user data.

---

### Step 2: Copy JSTL JAR (30 seconds)

**If not done yet:**

1. Check if file exists: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\jstl-1.2.jar`
2. If NOT there:
   - Download: https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
   - Copy to: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\`

---

## Step 3: Restart Tomcat & Test!

**Kill current Tomcat:**
- Open Task Manager (Ctrl+Shift+Esc)
- Find `java.exe`
- Right-click → End Task

**Start fresh:**
```cmd
cd "c:\Users\HP\DBMS project 2"
start_tomcat.bat
```

**Test:**
Open: http://localhost:8080/StudentManagementSystem/login.jsp

**Login:**
- Email: `admin@sms.com`
- Password: `admin123`

---

## If Still Getting Errors:

### HTTP 500 - JSTL Error:
- JSTL JAR is missing from Tomcat lib folder
- Copy `jstl-1.2.jar` to Tomcat lib and restart

### Database Error:
- Run the SQL scripts in MySQL Workbench
- Check password is "root" (lowercase)

### 404 Not Found:
- URL must be: `http://localhost:8080/StudentManagementSystem/login.jsp`
- Check Tomcat is running

---

**Tell me when:**
1. Database setup is complete (ran both SQL scripts)
2. JSTL JAR is in Tomcat lib folder

And I'll help you restart and test! 🚀
