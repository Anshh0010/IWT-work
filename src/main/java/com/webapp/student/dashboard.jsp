<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Student Dashboard - SMS</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);
                    min-height: 100vh;
                    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
                    position: relative;
                }

                body::before {
                    content: '';
                    position: absolute;
                    top: 0;
                    left: 0;
                    right: 0;
                    bottom: 0;
                    background-image:
                        linear-gradient(30deg, transparent 48%, rgba(63, 81, 181, 0.02) 48%, rgba(63, 81, 181, 0.02) 52%, transparent 52%),
                        linear-gradient(-30deg, transparent 48%, rgba(0, 188, 212, 0.02) 48%, rgba(0, 188, 212, 0.02) 52%, transparent 52%);
                    background-size: 60px 60px;
                    pointer-events: none;
                    z-index: 0;
                }

                .container {
                    position: relative;
                    z-index: 1;
                }

                .navbar {
                    background: linear-gradient(135deg, #1a237e 0%, #283593 50%, #3f51b5 100%);
                    box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
                    padding: 1rem 0;
                }

                .navbar-brand {
                    font-weight: 700;
                    font-size: 1.25rem;
                    letter-spacing: -0.3px;
                }

                .welcome-card {
                    background: linear-gradient(135deg, #1a237e 0%, #283593 50%, #3f51b5 100%);
                    color: white;
                    border-radius: 16px;
                    padding: 35px;
                    margin-bottom: 30px;
                    box-shadow: 0 8px 32px rgba(26, 35, 126, 0.25);
                    position: relative;
                    overflow: hidden;
                }

                .welcome-card::before {
                    content: '';
                    position: absolute;
                    top: -50%;
                    right: -10%;
                    width: 300px;
                    height: 300px;
                    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
                    border-radius: 50%;
                }

                .welcome-card h2 {
                    position: relative;
                    z-index: 1;
                    font-weight: 700;
                    font-size: 1.75rem;
                    margin-bottom: 15px;
                }

                .welcome-card p {
                    position: relative;
                    z-index: 1;
                    opacity: 0.95;
                }

                .info-card {
                    background: white;
                    border-radius: 16px;
                    padding: 28px;
                    margin-bottom: 20px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                    border: 1px solid rgba(0, 0, 0, 0.05);
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                }

                .info-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 8px 30px rgba(0, 0, 0, 0.12);
                }

                .info-card h4 {
                    color: #2c3e50;
                    font-weight: 700;
                    margin-bottom: 20px;
                    font-size: 1.25rem;
                }

                .info-card h5 {
                    color: #2c3e50;
                    font-weight: 600;
                }

                .badge-defaulter {
                    background: linear-gradient(135deg, #e53935 0%, #c62828 100%);
                    padding: 10px 18px;
                    border-radius: 25px;
                    font-size: 0.9rem;
                    font-weight: 600;
                    box-shadow: 0 4px 12px rgba(229, 57, 53, 0.3);
                }

                .badge-safe {
                    background: linear-gradient(135deg, #43a047 0%, #2e7d32 100%);
                    padding: 10px 18px;
                    border-radius: 25px;
                    font-size: 0.9rem;
                    font-weight: 600;
                    box-shadow: 0 4px 12px rgba(67, 160, 71, 0.3);
                }

                .attendance-item {
                    border-left: 4px solid;
                    padding: 18px;
                    margin-bottom: 15px;
                    background: #f8f9fc;
                    border-radius: 8px;
                    transition: all 0.3s ease;
                }

                .attendance-item:hover {
                    background: #f0f3ff;
                    transform: translateX(4px);
                }

                .attendance-safe {
                    border-left-color: #43a047;
                }

                .attendance-risk {
                    border-left-color: #e53935;
                }

                .btn-primary {
                    background: linear-gradient(135deg, #1a237e 0%, #3f51b5 100%);
                    border: none;
                    padding: 12px 24px;
                    font-weight: 600;
                    letter-spacing: 0.3px;
                    box-shadow: 0 4px 12px rgba(63, 81, 181, 0.3);
                    transition: all 0.3s ease;
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(63, 81, 181, 0.4);
                    background: linear-gradient(135deg, #283593 0%, #5c6bc0 100%);
                }

                .btn-success {
                    background: linear-gradient(135deg, #2e7d32 0%, #43a047 100%);
                    border: none;
                    padding: 12px 24px;
                    font-weight: 600;
                    letter-spacing: 0.3px;
                    box-shadow: 0 4px 12px rgba(67, 160, 71, 0.3);
                    transition: all 0.3s ease;
                }

                .btn-success:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 6px 20px rgba(67, 160, 71, 0.4);
                    background: linear-gradient(135deg, #388e3c 0%, #66bb6a 100%);
                }

                .btn-light {
                    font-weight: 600;
                    transition: all 0.2s ease;
                }

                .btn-light:hover {
                    background-color: #f8f9fa;
                    transform: scale(1.05);
                }

                .alert-danger {
                    background-color: #ffebee;
                    border: none;
                    border-left: 4px solid #e53935;
                    border-radius: 8px;
                    color: #c62828;
                }

                .text-primary {
                    color: #3f51b5 !important;
                }

                hr {
                    opacity: 0.1;
                    margin: 20px 0;
                }

                .display-4 {
                    font-weight: 700;
                    letter-spacing: -1px;
                }

                .badge.bg-danger {
                    background: linear-gradient(135deg, #e53935 0%, #c62828 100%) !important;
                    padding: 4px 10px;
                    font-weight: 600;
                }
            </style>
        </head>

        <body>
            <nav class="navbar navbar-dark">
                <div class="container-fluid">
                    <span class="navbar-brand mb-0 h1"><i class="fas fa-user-graduate"></i> Student Dashboard</span>
                    <div>
                        <span class="text-white me-3"><i class="fas fa-user"></i> ${sessionScope.studentName}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-light btn-sm">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </nav>

            <div class="container mt-4">
                <div class="welcome-card">
                    <h2><i class="fas fa-hand-wave"></i> Welcome, ${student.fullName}!</h2>
                    <p class="mb-2"><strong>Roll No:</strong> ${student.rollNo}</p>
                    <p class="mb-2"><strong>Course:</strong> ${student.courseName}</p>
                    <p class="mb-0"><strong>Email:</strong> ${student.email}</p>
                </div>

                <c:if test="${isDefaulter}">
                    <div class="alert alert-danger">
                        <h5><i class="fas fa-exclamation-triangle"></i> Attendance Warning!</h5>
                        <p class="mb-0">Your attendance is below 75% in one or more subjects. Please improve your
                            attendance.</p>
                    </div>
                </c:if>

                <div class="row">
                    <div class="col-md-6">
                        <div class="info-card">
                            <h4><i class="fas fa-clipboard-check"></i> Attendance Overview</h4>
                            <hr>
                            <h2 class="text-center mb-3">${overallAttendance}%</h2>
                            <p class="text-center text-muted">Overall Attendance</p>

                            <h6 class="mt-4 mb-3">Subject-wise Attendance:</h6>
                            <c:choose>
                                <c:when test="${not empty attendanceStats}">
                                    <c:forEach var="stats" items="${attendanceStats}">
                                        <div
                                            class="attendance-item ${stats.defaulter ? 'attendance-risk' : 'attendance-safe'}">
                                            <div class="d-flex justify-content-between align-items-center">
                                                <div>
                                                    <strong>${stats.subjectName}</strong>
                                                    <p class="mb-0 small text-muted">
                                                        ${stats.classesAttended}/${stats.totalClasses} classes</p>
                                                </div>
                                                <div class="text-end">
                                                    <h5 class="mb-0">${stats.attendancePercentage}%</h5>
                                                    <c:if test="${stats.defaulter}">
                                                        <span class="badge bg-danger small">AT RISK</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <p class="text-muted text-center">No attendance records found</p>
                                </c:otherwise>
                            </c:choose>

                            <a href="${pageContext.request.contextPath}/student/attendance"
                                class="btn btn-primary w-100 mt-3">
                                <i class="fas fa-chart-bar"></i> View Detailed Attendance
                            </a>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="info-card">
                            <h4><i class="fas fa-star"></i> Academic Performance</h4>
                            <hr>
                            <div class="text-center mb-4">
                                <h1 class="display-4 text-primary">${cgpa}</h1>
                                <p class="text-muted">Overall CGPA</p>
                            </div>

                            <a href="${pageContext.request.contextPath}/student/grades" class="btn btn-success w-100">
                                <i class="fas fa-graduation-cap"></i> View Marks & Grades
                            </a>
                        </div>

                        <div class="info-card mt-4">
                            <h5><i class="fas fa-info-circle"></i> Quick Info</h5>
                            <hr>
                            <ul class="list-unstyled">
                                <li class="mb-2"><i class="fas fa-check-circle text-success"></i> Auto-grading enabled
                                </li>
                                <li class="mb-2"><i class="fas fa-check-circle text-success"></i> Real-time CGPA
                                    calculation</li>
                                <li class="mb-0"><i class="fas fa-check-circle text-success"></i> Attendance tracking
                                    active</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>