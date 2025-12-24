# JAR Files Download Instructions

## You Need to Download These 2 Files Manually:

### 1. JSTL Library (CRITICAL - App won't load without this)

**Open this link in your browser:**
https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar

**Action:** Click the link - it will download automatically
**File size:** ~400 KB
**Save location:** Your Downloads folder (anywhere is fine for now)

---

### 2. MySQL Connector (CRITICAL - Database won't work without this)

**Open this link in your browser:**
https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar

**Action:** Click the link - it will download automatically
**File size:** ~2.5 MB
**Save location:** Your Downloads folder

---

## After Downloading Both Files:

### Step 1: Copy to Tomcat lib folder

Open File Explorer and copy BOTH JAR files to:
```
C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\
```

**You may need Administrator permission** - click "Continue" when prompted.

### Step 2: I'll help you restart Tomcat and test!

Tell me when you've copied the files and I'll restart Tomcat for you.

---

## Quick Copy Commands (After Download):

If your files are in Downloads, you can run this in PowerShell as Administrator:

```powershell
Copy-Item "$env:USERPROFILE\Downloads\jstl-1.2.jar" -Destination "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\"
Copy-Item "$env:USERPROFILE\Downloads\mysql-connector-java-8.0.33.jar" -Destination "C:\Program Files\Apache Software Foundation\Tomcat 9.0\lib\"
```

---

**Let me know when the files are copied!**
