# FINAL SETUP STEPS - Student Management System

## Current Status:
✅ Tomcat is running  
✅ Application files are deployed  
✅ MySQL Connector JAR exists in Tomcat lib  
❌ JSTL JAR is MISSING (causing the HTTP 500 error)  

---

## WHAT YOU NEED TO DO RIGHT NOW:

### Step 1: Download JSTL JAR (if not already downloaded)

**Click this link** - it will download automatically:
```
https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
```

The file will be saved to your Downloads folder.

---

### Step 2: Copy JSTL JAR to Tomcat

**Option A - Manual Copy** (Easiest):

1. Open **File Explorer**
2. Navigate to your **Downloads** folder
3. Find the file: `jstl-1.2.jar`
4. **Copy** the file (Ctrl+C)
5. Navigate to: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\`
6. **Paste** the file (Ctrl+V)
7. **Click "Continue"** when asked for administrator permission

**Option B - Using PowerShell as Administrator**:

1. Right-click **PowerShell** → **Run as Administrator**
2. Paste and run this command:
```powershell
Copy-Item "$env:USERPROFILE\Downloads\jstl-1.2.jar" -Destination "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\"
```

---

### Step 3: Restart Tomcat

**Option A - Using our script**:
Run this in Command Prompt:
```cmd
"C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin\shutdown.bat"
```
Wait 5 seconds, then:
```cmd
cd "c:\Users\HP\DBMS project 2"
start_tomcat.bat
```

**Option B - Kill and restart**:
1. Open Task Manager (Ctrl+Shift+Esc)
2. Find "java.exe" process
3. Right-click → End Task
4. Run: `c:\Users\HP\DBMS project 2\start_tomcat.bat`

---

### Step 4: Setup Database (If not done yet)

Open **MySQL Workbench**:
1. Connect to localhost (password: Root)
2. Click **File** → **Run SQL Script**
3. Select: `c:\Users\HP\DBMS project 2\database\database_schema.sql`
4. Click **Run**
5. Again, **File** → **Run SQL Script**
6. Select: `c:\Users\HP\DBMS project 2\database\sample_data.sql`
7. Click **Run**

---

### Step 5: Test Your Application!

Open browser and go to:
```
http://localhost:8080/StudentManagementSystem/login.jsp
```

**Login credentials:**
- Email: `admin@sms.com`
- Password: `admin123`

---

## Troubleshooting:

### Still getting HTTP 500 error?
- Make sure `jstl-1.2.jar` is in: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\`
- Restart Tomcat completely (shutdown.bat then startup.bat)

### Database connection error?
- Run the SQL scripts in MySQL Workbench
- Check that MySQL service is running
- Verify password is "Root" in DatabaseUtil.java

### Page not found (404)?
- Check Tomcat is running (look for java.exe in Task Manager)
- URL should be: `http://localhost:8080/StudentManagementSystem/login.jsp`

---

##✅ Success Checklist:

- [ ] jstl-1.2.jar is in Tomcat lib folder
- [ ] mysql-connector JAR is in Tomcat lib folder
- [ ] Tomcat restarted after adding JAR
- [ ] Database created using MySQL Workbench
- [ ] Can access login page without errors
- [ ] Can login with admin@sms.com / admin123

---

**Tell me when you've copied the JSTL JAR file and I'll help you restart Tomcat!**
