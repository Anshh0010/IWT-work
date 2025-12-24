<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Pending Approvals - Admin</title>
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
                    <span class="text-white">${sessionScope.userEmail}</span>
                </div>
            </nav>

            <div class="container mt-4">
                <h2><i class="fas fa-user-clock"></i> Pending Student Approvals</h2>

                <c:if test="${not empty sessionScope.success}">
                    <div class="alert alert-success">${sessionScope.success}</div>
                    <c:remove var="success" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div class="alert alert-danger">${sessionScope.error}</div>
                    <c:remove var="error" scope="session" />
                </c:if>

                <div class="card mt-4">
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${not empty pendingStudents}">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Roll No</th>
                                            <th>Name</th>
                                            <th>Email</th>
                                            <th>Course</th>
                                            <th>Registered Date</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="student" items="${pendingStudents}">
                                            <tr>
                                                <td>${student.rollNo}</td>
                                                <td>${student.fullName}</td>
                                                <td>${student.email}</td>
                                                <td>${student.courseName}</td>
                                                <td>${student.registeredDate}</td>
                                                <td>
                                                    <form action="${pageContext.request.contextPath}/admin/approvals"
                                                        method="post" style="display: inline;">
                                                        <input type="hidden" name="studentId"
                                                            value="${student.studentId}">
                                                        <input type="hidden" name="action" value="approve">
                                                        <button type="submit" class="btn btn-success btn-sm">
                                                            <i class="fas fa-check"></i> Approve
                                                        </button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/admin/approvals"
                                                        method="post" style="display: inline;">
                                                        <input type="hidden" name="studentId"
                                                            value="${student.studentId}">
                                                        <input type="hidden" name="action" value="reject">
                                                        <button type="submit" class="btn btn-danger btn-sm">
                                                            <i class="fas fa-times"></i> Reject
                                                        </button>
                                                    </form>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <p class="text-center text-muted">No pending approvals</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>