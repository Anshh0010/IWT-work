# Quick Start Guide - Student Management System

## ✅ Current Status

Your project files are complete and ready! Here's what to do next:

---

## Step 1: Database Setup ✓

**Action Required**: Press any key in the command window that opened to complete database setup.

The script is waiting for you to press Enter. After you press any key:
- ✓ Database `student_management_system` will be created
- ✓ 8 tables will be created
- ✓ Sample data (admin + 10 students) will be inserted

---

## Step 2: Download Required JAR Files

You need these two JAR files before deploying:

### 1. MySQL JDBC Connector
**Download Link**: https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar

**Direct Download**:
```
https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar
```

### 2. JSTL Library
**Download Link**: https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar

**Direct Download**:
```
https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar
```

**Where to place**: 
- Option A (Recommended): `TOMCAT_HOME\lib\`
- Option B: `c:\Users\HP\DBMS project 2\src\main\webapp\WEB-INF\lib\`

---

## Step 3: Deploy to Tomcat

### Option A: Using IDE (Eclipse/IntelliJ)

**Eclipse:**
1. Right-click project → Export → WAR file
2. Save as `StudentManagementSystem.war`
3. Copy to `TOMCAT_HOME\webapps\`

**IntelliJ IDEA:**
1. Build → Build Artifacts → WAR
2. Copy WAR to `TOMCAT_HOME\webapps\`

### Option B: Manual Deployment (Copy Files)

1. **Create folder structure in Tomcat**:
   ```
   TOMCAT_HOME\webapps\StudentManagementSystem\
   ```

2. **Copy webapp files**:
   - Copy everything from `c:\Users\HP\DBMS project 2\src\main\webapp\*` 
   - To: `TOMCAT_HOME\webapps\StudentManagementSystem\`

3. **Compile and copy Java files**:
   
   **Step 3a: Open Command Prompt in project directory**
   ```bash
   cd "c:\Users\HP\DBMS project 2"
   ```

   **Step 3b: Create output directory**
   ```bash
   mkdir compiled
   ```

   **Step 3c: Compile Java files** (requires JDK):
   ```bash
   javac -d compiled -cp "path\to\servlet-api.jar;path\to\mysql-connector.jar" src\main\java\com\sms\*\*.java
   ```

   **Step 3d: Copy compiled classes**:
   ```bash
   xcopy /E /I compiled\com "TOMCAT_HOME\webapps\StudentManagementSystem\WEB-INF\classes\com"
   ```

### Option C: Using Maven (if you have Maven installed)

1. Create `pom.xml` in project root (I can provide this if needed)
2. Run: `mvn clean package`
3. Copy generated WAR from `target\` to Tomcat `webapps\`

---

## Step 4: Start Tomcat

**Navigate to Tomcat bin folder**:
```bash
cd TOMCAT_HOME\bin
```

**Start Tomcat**:
```bash
startup.bat
```

**Verify Tomcat is running**:
- Open browser: `http://localhost:3080`
- You should see Tomcat welcome page

---

## Step 5: Access Your Application

**URL**:
```
http://localhost:3080/StudentManagementSystem/
```

**Login as Admin**:
- Email: `admin@sms.com`
- Password: `admin123`

**Login as Student**:
- Email: `rajesh.kumar@student.com`
- Password: `student123`

---

## 🚨 Important Notes

1. **JAR Files**: Download the two JARs BEFORE starting Tomcat
2. **Database**: Complete the database setup (press any key in the command window)
3. **Port 8080**: Make sure no other service is using port 3080
4. **Tomcat**: If you don't have Tomcat, download from: https://tomcat.apache.org/download-90.cgi

---

## ✅ Verification Checklist

Before accessing the app, make sure:

- [ ] MySQL service is running
- [ ] Database script completed (pressed Enter in command window)
- [ ] `mysql-connector-java-8.0.33.jar` downloaded and placed in `TOMCAT_HOME\lib\`
- [ ] `jstl-1.2.jar` downloaded and placed in `TOMCAT_HOME\lib\`
- [ ] Project files copied to `TOMCAT_HOME\webapps\StudentManagementSystem\`
- [ ] Tomcat started with `startup.bat`
- [ ] Can access `http://localhost:3080`

---
## 🐛 Troubleshooting

### "Database connection failed"
- Check MySQL is running: `net start MySQL80`
- Verify password in `DatabaseUtil.java` is "Root"

### "ClassNotFoundException: MySQL Driver"
- Ensure `mysql-connector-java-8.0.33.jar` is in Tomcat lib folder
- Restart Tomcat after adding JAR

### "404 Page Not Found"
- Check URL: `http://localhost:3080/StudentManagementSystem/`
- Verify folder exists in `webapps`
- Check Tomcat logs in `TOMCAT_HOME\logs\catalina.out`

### "JSTL tag errors"
- Add `jstl-1.2.jar` to Tomcat lib
- Restart Tomcat

---

## 📞 Need Help?

1. Check Tomcat logs: `TOMCAT_HOME\logs\catalina.out`
2. Review `DEPLOYMENT_GUIDE.md` for detailed instructions
3. Check `README.md` for full documentation

---

**Your project is ready! Just complete these steps to see it running.** 🚀
