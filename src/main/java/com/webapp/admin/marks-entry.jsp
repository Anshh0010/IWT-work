<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <title>Enter Marks - Admin</title>
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
                <h2><i class="fas fa-edit"></i> Enter Marks (Auto-Grading Enabled)</h2>

                <c:if test="${not empty success}">
                    <div class="alert alert-success"><i class="fas fa-check-circle"></i> ${success}</div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">${error}</div>
                </c:if>

                <div class="card mt-4">
                    <div class="card-body">
                        <div class="alert alert-info">
                            <strong>Grading Logic:</strong> 90-100: A+ | 80-89: A | 70-79: B | 60-69: C | <60: F </div>

                                <form method="post">
                                    <div class="mb-3">
                                        <label for="studentId" class="form-label">Student</label>
                                        <select class="form-select" id="studentId" name="studentId" required>
                                            <option value="">Select student</option>
                                            <c:forEach var="student" items="${students}">
                                                <option value="${student.studentId}">${student.rollNo} -
                                                    ${student.fullName}</option>
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
                                        <label for="semester" class="form-label">Semester</label>
                                        <select class="form-select" id="semester" name="semester" required>
                                            <option value="1">Semester 1</option>
                                            <option value="2">Semester 2</option>
                                            <option value="3">Semester 3</option>
                                            <option value="4">Semester 4</option>
                                            <option value="5">Semester 5</option>
                                            <option value="6">Semester 6</option>
                                            <option value="7">Semester 7</option>
                                            <option value="8">Semester 8</option>
                                        </select>
                                    </div>

                                    <div class="mb-3">
                                        <label for="marks" class="form-label">Marks (0-100)</label>
                                        <input type="number" class="form-control" id="marks" name="marks" min="0"
                                            max="100" step="0.01" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="examType" class="form-label">Exam Type</label>
                                        <select class="form-select" id="examType" name="examType" required>
                                            <option value="MIDTERM">Midterm</option>
                                            <option value="ENDTERM">Endterm</option>
                                            <option value="ASSIGNMENT">Assignment</option>
                                            <option value="FINAL" selected>Final</option>
                                        </select>
                                    </div>

                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-magic"></i> Enter Marks (Auto-Grade)
                                    </button>
                                </form>
                        </div>
                    </div>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>