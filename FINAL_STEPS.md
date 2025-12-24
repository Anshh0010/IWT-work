# CRITICAL REMAINING STEPS TO RUN THE APPLICATION

## ✅ What's Done
- Project files copied to Tomcat webapps
- Directory structure created

## ⚠️ What You MUST Do Now

### Step 1: Setup Database (5 minutes)
Since automated scripts aren't working, use **MySQL Workbench**:

1. **Open MySQL Workbench**
2. **Connect** to localhost (password: Root)
3. Click **File** → **Run SQL Script**
4. Select: `c:\Users\HP\DBMS project 2\database\database_schema.sql`
5. Click **Run**
6. Again click **File** → **Run SQL Script**  
7. Select: `c:\Users\HP\DBMS project 2\database\sample_data.sql`
8. Click **Run**

✅ Database ready!

---

### Step 2: Download JAR Files (2 minutes)

Download these 2 files and save to your Downloads folder:

**File 1: MySQL Connector**
```
https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar
```

**File 2: JSTL**
```
https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
```

Then copy both files to:
```
C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\
```

---

### Step 3: Compile Java Files

**Option A - Using IDE** (Recommended if you have Eclipse/IntelliJ):
1. Import project into IDE
2. Build project (will create .class files)
3. Copy from `bin/` or `target/classes/` to:
   `C:\Program Files\Apache Software Foundation\Tomcat 9.0\webapps\StudentManagementSystem\WEB-INF\classes\`

**Option B - Manual** (if no IDE):
The project will run JSP pages but servlets won't work without compilation.
You can test with JSP pages first.

---

### Step 4: Start Tomcat

Open Command Prompt and run:
```cmd
cd "C:\Program Files\Apache Software Foundation\Tomcat 9.0\bin"
startup.bat
```

Wait for message: "Server startup in [xxxx] milliseconds"

---

### Step 5: Access Application

Open browser and go to:
```
http://localhost:3080/StudentManagementSystem/login.jsp
```

**Login:**
- Email: admin@sms.com
- Password: admin123

---

## 🚨 If Port 3080 Doesn't Work

Check Tomcat's actual port:
1. Open: `C:\Program Files\Apache Software Foundation\Tomcat 9.0\conf\server.xml`
2. Find: `<Connector port="XXXX"`
3. Use that port number instead of 3080

---

## ✅ Quick Test Checklist

After doing above steps:

- [ ] Database created (check in MySQL Workbench)
- [ ] Both JAR files in Tomcat lib folder
- [ ] Tomcat started (command window shows "Server startup")
- [ ] Can access: http://localhost:3080/StudentManagementSystem/login.jsp

---

**Which step are you on? Let me know if you need help with any step!**
