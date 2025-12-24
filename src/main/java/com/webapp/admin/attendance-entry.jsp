<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Mark Attendance - Admin</title>
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
                <h2><i class="fas fa-clipboard-check"></i> Mark Attendance</h2>

                <c:if test="${not empty success}">
                    <div class="alert alert-success">${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <div class="card mt-4">
                    <div class="card-body">
                        <form method="post">
                            <div class="mb-3">
                                <label for="studentId" class="form-label">Student</label>
                                <select class="form-select" id="studentId" name="studentId" required>
                                    <option value="">Select student</option>
                                    <c:forEach var="student" items="${students}">
                                        <option value="${student.studentId}">${student.rollNo} - ${student.fullName}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="subjectId" class="form-label">Subject</label>
                                <select class="form-select" id="subjectId" name="subjectId" required>
                                    <option value="">Select subject</option>
                                    <c:forEach var="subject" items="${subjects}">
                                        <option value="${subject.subjectId}">${subject.subjectCode} -
                                            ${subject.subjectName}</option>
                                    </c:forEach>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label for="date" class="form-label">Date</label>
                                <input type="date" class="form-control" id="date" name="date" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Status</label>
                                <div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" id="present"
                                            value="PRESENT" required>
                                        <label class="form-check-label" for="present">Present</label>
                                    </div>
                                    <div class="form-check form-check-inline">
                                        <input class="form-check-input" type="radio" name="status" id="absent"
                                            value="ABSENT">
                                        <label class="form-check-label" for="absent">Absent</label>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Mark Attendance
                            </button>
                        </form>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            <script>
                // Set today's date as default
                document.getElementById('date').valueAsDate = new Date();
            </script>
        </body>

        </html>