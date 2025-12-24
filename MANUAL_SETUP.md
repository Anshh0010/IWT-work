# Manual Database Setup Instructions

Since the automated scripts are having issues with the MySQL password format, here's how to set up the database manually:

## Option 1: Using MySQL Workbench (Easiest)

1. **Open MySQL Workbench**
2. **Connect to your local MySQL server** (root/Root)
3. **Open SQL script**: File → Open SQL Script
4. **Navigate to**: `c:\Users\HP\DBMS project 2\database\database_schema.sql`
5. **Execute**: Click the lightning bolt icon (Execute)
6. **Open second script**: `c:\Users\HP\DBMS project 2\database\sample_data.sql`
7. **Execute**: Click the lightning bolt icon again

Done! Database is set up.

## Option 2: Using MySQL Command Line Client

1. **Open MySQL Command Line Client** (from Start Menu)
2. **Enter password**: Root
3. **Run these commands**:

```sql
source c:/Users/HP/DBMS project 2/database/database_schema.sql
source c:/Users/HP/DBMS project 2/database/sample_data.sql
```

4. **Verify**:
```sql
USE student_management_system;
SHOW TABLES;
SELECT * FROM users;
```

You should see 8 tables and user data.

## Option 3: Copy-Paste SQL (If above don't work)

1. **Open MySQL Workbench or Command Line Client**
2. **Open** `database_schema.sql` in notepad
3. **Copy all content**
4. **Paste and execute** in MySQL
5. **Repeat** for `sample_data.sql`

---

## After Database Setup

Once database is created, you need to:

### 1. Download JAR Files

Download these files:
- https://repo1.maven.org/maven2/mysql/mysql-connector-java/8.0.33/mysql-connector-java-8.0.33.jar
- https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar

### 2. Find Tomcat Location

Can you tell me where Tomcat is installed? Common locations:
- `C:\Program Files\Apache Software Foundation\Tomcat 9.0\`
- `C:\apache-tomcat-9.0.xx\`
- `C:\Tomcat\`

### 3. Deploy Project

I'll help you deploy once we know your Tomcat location.

---

**Which method do you want to use for database setup?**
