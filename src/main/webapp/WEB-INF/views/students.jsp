<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.sms.model.Student" %>
            <%@ page import="com.sms.model.Course" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Student Management</title>
                    <style>
                        * {
                            margin: 0;
                            padding: 0;
                            box-sizing: border-box;
                        }

                        body {
                            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            min-height: 100vh;
                            padding: 20px;
                        }

                        .container {
                            max-width: 1200px;
                            margin: 0 auto;
                        }

                        h1 {
                            color: white;
                            text-align: center;
                            margin-bottom: 30px;
                            font-size: 32px;
                        }

                        .add-student-card {
                            background: white;
                            border-radius: 15px;
                            padding: 30px;
                            margin-bottom: 30px;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                        }

                        .add-student-card h2 {
                            color: #667eea;
                            margin-bottom: 20px;
                        }

                        .form-row {
                            display: grid;
                            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                            gap: 15px;
                            margin-bottom: 15px;
                        }

                        .form-group {
                            display: flex;
                            flex-direction: column;
                        }

                        .form-group label {
                            margin-bottom: 5px;
                            color: #333;
                            font-weight: 500;
                            font-size: 14px;
                        }

                        .form-group input,
                        .form-group select {
                            padding: 12px;
                            border: 2px solid #e0e0e0;
                            border-radius: 8px;
                            font-size: 14px;
                            transition: all 0.3s ease;
                        }

                        .form-group input:focus,
                        .form-group select:focus {
                            outline: none;
                            border-color: #667eea;
                            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
                        }

                        .submit-btn {
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            padding: 14px 30px;
                            border: none;
                            border-radius: 8px;
                            font-size: 16px;
                            font-weight: 600;
                            cursor: pointer;
                            transition: all 0.3s ease;
                            margin-top: 10px;
                        }

                        .submit-btn:hover {
                            transform: translateY(-2px);
                            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
                        }

                        .message {
                            padding: 12px 16px;
                            border-radius: 8px;
                            margin-bottom: 20px;
                            font-size: 14px;
                        }

                        .success {
                            background: #d4edda;
                            color: #155724;
                            border-left: 4px solid #28a745;
                        }

                        .error {
                            background: #f8d7da;
                            color: #721c24;
                            border-left: 4px solid #dc3545;
                        }

                        .students-list {
                            background: white;
                            border-radius: 15px;
                            padding: 30px;
                            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
                        }

                        .students-list h2 {
                            color: #667eea;
                            margin-bottom: 20px;
                        }

                        table {
                            width: 100%;
                            border-collapse: collapse;
                        }

                        th {
                            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                            color: white;
                            padding: 12px;
                            text-align: left;
                            font-weight: 600;
                        }

                        td {
                            padding: 12px;
                            border-bottom: 1px solid #e0e0e0;
                        }

                        tr:hover {
                            background: #f8f9fa;
                        }

                        .status {
                            padding: 4px 12px;
                            border-radius: 12px;
                            font-size: 12px;
                            font-weight: 600;
                        }

                        .status-approved {
                            background: #d4edda;
                            color: #155724;
                        }

                        .status-pending {
                            background: #fff3cd;
                            color: #856404;
                        }

                        .back-link {
                            display: inline-block;
                            color: white;
                            text-decoration: none;
                            margin-bottom: 20px;
                            padding: 8px 16px;
                            background: rgba(255, 255, 255, 0.2);
                            border-radius: 8px;
                            transition: all 0.3s ease;
                        }

                        .back-link:hover {
                            background: rgba(255, 255, 255, 0.3);
                        }
                    </style>
                </head>

                <body>
                    <div class="container">
                        <a href="<%= request.getContextPath() %>/login" class="back-link">← Back to Login</a>

                        <h1>🎓 Student Management</h1>

                        <!-- Add Student Form -->
                        <div class="add-student-card">
                            <h2>Add New Student</h2>

                            <% String success=(String) request.getAttribute("success"); if (success !=null) { %>
                                <div class="message success">✓ <%= success %>
                                </div>
                                <% } %>

                                    <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                                        <div class="message error">⚠ <%= error %>
                                        </div>
                                        <% } %>

                                            <form method="post" action="<%= request.getContextPath() %>/students">
                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="fullName">Full Name *</label>
                                                        <input type="text" id="fullName" name="fullName" required
                                                            placeholder="John Doe">
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="rollNo">Roll Number *</label>
                                                        <input type="text" id="rollNo" name="rollNo" required
                                                            placeholder="CS001">
                                                    </div>
                                                </div>

                                                <div class="form-row">
                                                    <div class="form-group">
                                                        <label for="email">Email *</label>
                                                        <input type="email" id="email" name="email" required
                                                            placeholder="john@example.com">
                                                    </div>

                                                    <div class="form-group">
                                                        <label for="password">Password *</label>
                                                        <input type="password" id="password" name="password" required
                                                            placeholder="Enter password">
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="courseId">Course *</label>
                                                    <select id="courseId" name="courseId" required>
                                                        <option value="">-- Select Course --</option>
                                                        <% List<Course> courses = (List<Course>)
                                                                request.getAttribute("courses");
                                                                if (courses != null) {
                                                                for (Course course : courses) { %>
                                                                <option value="<%= course.getCourseId() %>">
                                                                    <%= course.getCourseName() %>
                                                                </option>
                                                                <% } } %>
                                                    </select>
                                                </div>

                                                <button type="submit" class="submit-btn">Add Student</button>
                                            </form>
                        </div>

                        <!-- Students List -->
                        <div class="students-list">
                            <h2>All Students (<%= ((List<Student>) request.getAttribute("students")).size() %>)</h2>

                            <table>
                                <thead>
                                    <tr>
                                        <th>Roll No</th>
                                        <th>Name</th>
                                        <th>Email</th>
                                        <th>Course</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% List<Student> students = (List<Student>) request.getAttribute("students");
                                            if (students != null && !students.isEmpty()) {
                                            for (Student student : students) { %>
                                            <tr>
                                                <td><strong>
                                                        <%= student.getRollNo() %>
                                                    </strong></td>
                                                <td>
                                                    <%= student.getFullName() %>
                                                </td>
                                                <td>
                                                    <%= student.getEmail() %>
                                                </td>
                                                <td>
                                                    <%= student.getCourseName() %>
                                                </td>
                                                <td>
                                                    <span class="status <%= student.getStatus().equals(" APPROVED")
                                                        ? "status-approved" : "status-pending" %>">
                                                        <%= student.getStatus() %>
                                                    </span>
                                                </td>
                                            </tr>
                                            <% } } else { %>
                                                <tr>
                                                    <td colspan="5" style="text-align: center; color: #999;">No students
                                                        found</td>
                                                </tr>
                                                <% } %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </body>

                </html>