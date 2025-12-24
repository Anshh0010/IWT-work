<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Attendance Defaulters - Admin</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body style="background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);">
            <nav class="navbar navbar-dark"
                style="background: linear-gradient(135deg, #1a237e 0%, #283593 50%, #3f51b5 100%); box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);">
                <div class="container-fluid">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="navbar-brand">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </nav>

            <div class="container mt-4">
                <h2><i class="fas fa-exclamation-triangle text-danger"></i> Attendance Defaulters Report</h2>
                <p class="text-muted">Students with attendance < 75%</p>

                        <div class="card mt-4">
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty defaulters}">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Roll No</th>
                                                    <th>Name</th>
                                                    <th>Subject</th>
                                                    <th>Total Classes</th>
                                                    <th>Attended</th>
                                                    <th>Percentage</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="defaulter" items="${defaulters}">
                                                    <tr class="table-danger">
                                                        <td>${defaulter.rollNo}</td>
                                                        <td>${defaulter.studentName}</td>
                                                        <td>${defaulter.subjectName}</td>
                                                        <td>${defaulter.totalClasses}</td>
                                                        <td>${defaulter.classesAttended}</td>
                                                        <td>
                                                            <strong
                                                                class="text-danger">${defaulter.attendancePercentage}%</strong>
                                                        </td>
                                                        <td>
                                                            <span class="badge bg-danger">
                                                                <i class="fas fa-exclamation-triangle"></i> AT RISK
                                                            </span>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                        <p class="text-end text-muted">Total Defaulters: ${defaulters.size()}</p>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-center text-success">
                                            <i class="fas fa-check-circle fa-3x mb-3"></i><br>
                                            No attendance defaulters found! All students have ≥75% attendance.
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>