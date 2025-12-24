<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>My Attendance - Student</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        </head>

        <body style="background: linear-gradient(135deg, #f5f7fa 0%, #e8ecf1 100%);">
            <nav class="navbar navbar-dark"
                style="background: linear-gradient(135deg, #1a237e 0%, #283593 50%, #3f51b5 100%); box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);">
                <div class="container-fluid">
                    <a href="${pageContext.request.contextPath}/student/dashboard" class="navbar-brand">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </div>
            </nav>

            <div class="container mt-4">
                <h2><i class="fas fa-chart-bar"></i> My Attendance Details</h2>

                <div class="card mt-4">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty attendanceStats}">
                                <c:forEach var="stats" items="${attendanceStats}">
                                    <div class="card mb-3 ${stats.defaulter ? 'border-danger' : 'border-success'}">
                                        <div class="card-body">
                                            <div class="row align-items-center">
                                                <div class="col-md-6">
                                                    <h5 class="card-title">${stats.subjectName}</h5>
                                                    <p class="mb-1">Classes Attended:
                                                        <strong>${stats.classesAttended}</strong> /
                                                        ${stats.totalClasses}
                                                    </p>
                                                </div>
                                                <div class="col-md-6 text-end">
                                                    <h2 class="${stats.defaulter ? 'text-danger' : 'text-success'}">
                                                        ${stats.attendancePercentage}%
                                                    </h2>
                                                    <c:choose>
                                                        <c:when test="${stats.defaulter}">
                                                            <span class="badge bg-danger">
                                                                <i class="fas fa-exclamation-triangle"></i> AT RISK
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-success">
                                                                <i class="fas fa-check-circle"></i> SAFE
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>

                                            <div class="progress mt-3" style="height: 25px;">
                                                <div class="progress-bar ${stats.defaulter ? 'bg-danger' : 'bg-success'}"
                                                    role="progressbar" style="width: ${stats.attendancePercentage}%"
                                                    aria-valuenow="${stats.attendancePercentage}" aria-valuemin="0"
                                                    aria-valuemax="100">
                                                    ${stats.attendancePercentage}%
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted">No attendance records found</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>