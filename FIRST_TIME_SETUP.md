# Quick Start Guide

## First Time Setup

Since login isn't working with demo credentials (because the database is empty), follow these steps:

### 1. Set Up Database
```bash
# Run the database schema
mysql -u root -p < database/database_schema.sql
```

### 2. Register Your First Account
1. Navigate to `http://localhost:8080/webapp/`
2. Click **"Register here"** link
3. Fill in the registration form:
   - Full Name: Your Name
   - Roll Number: Any number (e.g., CS001)
   - Email: your.email@example.com
   - Password: Your password
   - Course: Select any course
4. Click **Register**

### 3. Approve Your Account (Since You Need Admin)

**Option A: Quick database update (for first admin)**
```sql
USE student_management_system;

-- Find your user ID
SELECT u.user_id, u.email, s.student_id, s.status 
FROM users u 
JOIN students s ON u.user_id = s.user_id 
WHERE u.email = 'your.email@example.com';

-- Change role to ADMIN and approve student
UPDATE users SET role = 'ADMIN' WHERE email = 'your.email@example.com';
UPDATE students SET status = 'APPROVED' WHERE user_id = (SELECT user_id FROM users WHERE email = 'your.email@example.com');
```

**Option B: Register as student, then approve via another admin**
- If you already have an admin account, login and approve via `/admin/approvals`

### 4. Login
1. Go back to `http://localhost:8080/webapp/`
2. Enter your email and password
3. Login!

## Creating Additional Users

### For Students:
1. Click "Register here" from login page
2. Fill the form
3. Wait for admin approval OR manually approve in database:
```sql
UPDATE students SET status = 'APPROVED' WHERE email = 'student@email.com';
```

### For Admins:
1. First create as student (register)
2. Then change role in database:
```sql
UPDATE users SET role = 'ADMIN' WHERE email = 'new.admin@email.com';
UPDATE students SET status = 'APPROVED' WHERE user_id = (SELECT user_id FROM users WHERE email = 'new.admin@email.com');
```

## Note
The demo credentials (admin@sms.com, rajesh.kumar@student.com) were removed from the login page because they don't exist in a fresh database. You need to create users first as shown above.
