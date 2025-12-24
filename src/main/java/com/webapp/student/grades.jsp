<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>My Grades - Student</title>
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
                <h2><i class="fas fa-graduation-cap"></i> My Marks & Grades</h2>

                <div class="alert alert-info mt-3">
                    <strong>Grading System:</strong> A+ (90-100) | A (80-89) | B (70-79) | C (60-69) | F (<60) </strong>
                </div>

                <div class="row">
                    <div class="col-md-8">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h5><i class="fas fa-list"></i> Subject-wise Marks & Grades</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty grades}">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>Subject</th>
                                                    <th>Semester</th>
                                                    <th>Marks</th>
                                                    <th>Grade</th>
                                                    <th>Grade Points</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="grade" items="${grades}">
                                                    <tr>
                                                        <td>${grade.subjectName}</td>
                                                        <td>Sem ${grade.semester}</td>
                                                        <td>
                                                            <c:forEach var="mark" items="${marks}">
                                                                <c:if
                                                                    test="${mark.subjectId == grade.subjectId && mark.semester == grade.semester}">
                                                                    ${mark.marksObtained}/100
                                                                </c:if>
                                                            </c:forEach>
                                                        </td>
                                                        <td>
                                                            <span class="badge ${
                                                        grade.grade == 'A+' ? 'bg-success' :
                                                        grade.grade == 'A' ? 'bg-info' :
                                                        grade.grade == 'B' ? 'bg-primary' :
                                                        grade.grade == 'C' ? 'bg-warning' :
                                                        'bg-danger'
                                                    }">${grade.grade}</span>
                                                        </td>
                                                        <td>${grade.gradePoints}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-center text-muted">No grades available yet</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <div class="card mb-3">
                            <div class="card-header bg-success text-white">
                                <h5><i class="fas fa-star"></i> Overall CGPA</h5>
                            </div>
                            <div class="card-body text-center">
                                <h1 class="display-3 text-success">${cgpa}</h1>
                                <p class="text-muted">out of 10.0</p>
                            </div>
                        </div>

                        <div class="card">
                            <div class="card-header bg-info text-white">
                                <h5><i class="fas fa-chart-line"></i> SGPA by Semester</h5>
                            </div>
                            <div class="card-body">
                                <c:choose>
                                    <c:when test="${not empty sgpaMap}">
                                        <c:forEach var="entry" items="${sgpaMap}">
                                            <div
                                                class="d-flex justify-content-between align-items-center mb-2 p-2 bg-light rounded">
                                                <strong>Semester ${entry.key}</strong>
                                                <span class="badge bg-primary">${String.format("%.2f",
                                                    entry.value)}</span>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted text-center small">No SGPA data</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>