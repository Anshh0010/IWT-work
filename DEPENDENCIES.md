# Required Dependencies for Student Management System

This file lists all the JAR files required to run the application on Apache Tomcat.

## Required JAR Files

### 1. MySQL JDBC Connector
**Required**: Yes  
**Version**: 8.0.33 or higher (8.0.x series)  
**Filename**: `mysql-connector-java-8.0.33.jar`  
**Download**: https://dev.mysql.com/downloads/connector/j/  
**Purpose**: Database connectivity for MySQL

**Installation**:
```
Place in: TOMCAT_HOME/lib/mysql-connector-java-8.0.33.jar
OR
Place in: src/main/webapp/WEB-INF/lib/mysql-connector-java-8.0.33.jar
```

---

### 2. JSTL (JavaServer Pages Standard Tag Library)
**Required**: Yes  
**Version**: 1.2  
**Filename**: `jstl-1.2.jar`  
**Download**: https://tomcat.apache.org/download-taglibs.cgi  
**Purpose**: JSP tag library for loops, conditionals, formatting

**Installation**:
```
Place in: TOMCAT_HOME/lib/jstl-1.2.jar
OR
Place in: src/main/webapp/WEB-INF/lib/jstl-1.2.jar
```

---

### 3. Servlet API (Usually included with Tomcat)
**Required**: No (included with Tomcat)  
**Version**: 4.0 or higher  
**Filename**: `servlet-api.jar`  
**Purpose**: Servlet and JSP compilation

**Note**: This is automatically provided by Tomcat. Only needed for compilation if developing outside Tomcat.

---

## Download Links

### MySQL Connector/J
- Official: https://dev.mysql.com/downloads/connector/j/
- Maven Central: https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/
- Direct Download: https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar

### JSTL
- Apache Tomcat Taglibs: https://tomcat.apache.org/download-taglibs.cgi
- Maven Central: https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/
- Direct Download: https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar

---

## Maven Dependencies (Optional)

If you want to use Maven for dependency management, add these to `pom.xml`:

```xml
<dependencies>
    <!-- MySQL Connector -->
    <dependency>
        <groupId>mysql</groupId>
        <artifactId>mysql-connector-java</artifactId>
        <version>8.0.33</version>
    </dependency>
    
    <!-- JSTL -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>jstl</artifactId>
        <version>1.2</version>
    </dependency>
    
    <!-- Servlet API (provided by Tomcat) -->
    <dependency>
        <groupId>javax.servlet</groupId>
        <artifactId>javax.servlet-api</artifactId>
        <version>4.0.1</version>
        <scope>provided</scope>
    </dependency>
</dependencies>
```

---

## Installation Methods

### Method 1: Tomcat Global Installation (Recommended)
```bash
# Copy JAR files to Tomcat lib folder
copy mysql-connector-java-8.0.33.jar %TOMCAT_HOME%\lib\
copy jstl-1.2.jar %TOMCAT_HOME%\lib\
```

**Advantages**:
- Available to all applications
- Cleaner WAR file
- Easier upgrades

### Method 2: Application-Specific Installation
```bash
# Copy JAR files to WEB-INF/lib
copy mysql-connector-java-8.0.33.jar "c:\Users\HP\DBMS project 2\src\main\webapp\WEB-INF\lib\"
copy jstl-1.2.jar "c:\Users\HP\DBMS project 2\src\main\webapp\WEB-INF\lib\"
```

**Advantages**:
- Portable WAR file
- No Tomcat configuration needed

---

## Verification

### Check if JARs are loaded:

1. **Start Tomcat**
2. **Check logs**: `TOMCAT_HOME/logs/catalina.out`
3. **Look for**:
   - No ClassNotFoundException errors
   - MySQL JDBC Driver loaded successfully

### Test Database Connection:

Create a simple JSP test file:

```jsp
<%@ page import="java.sql.*" %>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/student_management_system",
        "root", "Root"
    );
    out.println("Database connected successfully!");
    conn.close();
} catch(Exception e) {
    out.println("Error: " + e.getMessage());
}
%>
```

### Test JSTL:

Create a simple JSP test file:

```jsp
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="test" value="JSTL Working!" />
<c:out value="${test}" />
```

---

## Compatibility Matrix

| Component | Version | Compatible With |
|-----------|---------|----------------|
| Java | 8, 11, 17 | Tomcat 9.x, 10.x |
| Tomcat | 9.0.x | Servlet 4.0, JSP 2.3 |
| Tomcat | 10.0.x | Servlet 5.0, JSP 3.0 |
| MySQL Connector | 8.0.x | MySQL 8.0+ |
| JSTL | 1.2 | JSP 2.1+ |

---

## Common Issues

### ClassNotFoundException: com.mysql.cj.jdbc.Driver
**Cause**: MySQL connector JAR not found  
**Solution**: Add `mysql-connector-java-8.0.33.jar` to classpath

### Cannot find JSTL tags
**Cause**: JSTL JAR not found  
**Solution**: Add `jstl-1.2.jar` to WEB-INF/lib or Tomcat lib

### Version conflicts
**Cause**: Multiple versions of same JAR  
**Solution**: Remove older versions, keep only latest

---

## Security Note

For production:
- Keep JDBC driver updated for security patches
- Use connection pooling (e.g., HikariCP) instead of direct JDBC
- Store credentials in environment variables, not in code

---

## File Checksums

Verify downloaded files (Optional):

**mysql-connector-java-8.0.33.jar**
- Size: ~2.4 MB
- MD5: (verify from official download page)

**jstl-1.2.jar**
- Size: ~400 KB
- MD5: (verify from official download page)

---

**Note**: After adding or updating JAR files, always restart Tomcat for changes to take effect.
