<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Admin Dashboard - SMS</title>
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

                h2,
                h3 {
                    color: #2c3e50;
                    font-weight: 700;
                }

                .stat-card {
                    border-radius: 16px;
                    padding: 28px;
                    margin-bottom: 20px;
                    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
                    transition: transform 0.3s ease, box-shadow 0.3s ease;
                    position: relative;
                    overflow: hidden;
                }

                .stat-card::before {
                    content: '';
                    position: absolute;
                    top: -50%;
                    right: -20%;
                    width: 200px;
                    height: 200px;
                    background: radial-gradient(circle, rgba(255, 255, 255, 0.2) 0%, transparent 70%);
                    border-radius: 50%;
                }

                .stat-card:hover {
                    transform: translateY(-4px);
                    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.18);
                }

                .stat-icon {
                    font-size: 3rem;
                    opacity: 0.8;
                    position: relative;
                    z-index: 1;
                }

                .stat-card h2,
                .stat-card h6 {
                    position: relative;
                    z-index: 1;
                }

                .stat-card-1 {
                    background: linear-gradient(135deg, #1a237e 0%, #3f51b5 100%);
                    color: white;
                }

                .stat-card-2 {
                    background: linear-gradient(135deg, #d32f2f 0%, #e57373 100%);
                    color: white;
                }

                .stat-card-3 {
                    background: linear-gradient(135deg, #00acc1 0%, #4dd0e1 100%);
                    color: white;
                }

                .stat-card-4 {
                    background: linear-gradient(135deg, #388e3c 0%, #66bb6a 100%);
                    color: white;
                }

                .menu-card {
                    background: white;
                    border-radius: 16px;
                    padding: 35px 30px;
                    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                    border: 1px solid rgba(0, 0, 0, 0.05);
                    margin-bottom: 20px;
                    text-align: center;
                    transition: all 0.3s ease;
                }

                .menu-card:hover {
                    transform: translateY(-6px);
                    box-shadow: 0 12px 36px rgba(0, 0, 0, 0.15);
                }

                .menu-card h5 {
                    color: #2c3e50;
                    font-weight: 700;
                    margin-top: 15px;
                    margin-bottom: 10px;
                }

                .menu-icon {
                    font-size: 3.5rem;
                    margin-bottom: 10px;
                }

                .text-primary {
                    color: #3f51b5 !important;
                }

                .text-success {
                    color: #43a047 !important;
                }

                .text-warning {
                    color: #fb8c00 !important;
                }

                .text-danger {
                    color: #e53935 !important;
                }

                .btn-light {
                    font-weight: 600;
                    transition: all 0.2s ease;
                }

                .btn-light:hover {
                    background-color: #f8f9fa;
                    transform: scale(1.05);
                }
            </style>
        </head>

        <body>
            <nav class="navbar navbar-dark">
                <div class="container-fluid">
                    <span class="navbar-brand mb-0 h1"><i class="fas fa-user-shield"></i> Admin Dashboard</span>
                    <div>
                        <span class="text-white me-3"><i class="fas fa-user"></i> ${sessionScope.userEmail}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-light btn-sm">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </div>
            </nav>

            <div class="container mt-4">
                <h2 class="mb-4"><i class="fas fa-chart-line"></i> Dashboard Overview</h2>

                <div class="row">
                    <div class="col-md-3">
                        <div class="stat-card stat-card-1">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">Total Students</h6>
                                    <h2 class="mb-0">${totalStudents}</h2>
                                </div>
                                <i class="fas fa-users stat-icon"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="stat-card stat-card-2">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">Pending Approvals</h6>
                                    <h2 class="mb-0">${pendingApprovals}</h2>
                                </div>
                                <i class="fas fa-clock stat-icon"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="stat-card stat-card-3">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">Attendance Defaulters</h6>
                                    <h2 class="mb-0">${defaultersCount}</h2>
                                </div>
                                <i class="fas fa-exclamation-triangle stat-icon"></i>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="stat-card stat-card-4">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="mb-1">Average CGPA</h6>
                                    <h2 class="mb-0">${averageCGPA}</h2>
                                </div>
                                <i class="fas fa-star stat-icon"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <h3 class="mt-5 mb-4"><i class="fas fa-th-large"></i> Quick Actions</h3>

                <div class="row">
                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/admin/approvals" class="text-decoration-none">
                            <div class="menu-card">
                                <i class="fas fa-user-check menu-icon text-primary"></i>
                                <h5>Approve Students</h5>
                                <p class="text-muted mb-0">Manage registration approvals</p>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/admin/attendance" class="text-decoration-none">
                            <div class="menu-card">
                                <i class="fas fa-clipboard-check menu-icon text-success"></i>
                                <h5>Mark Attendance</h5>
                                <p class="text-muted mb-0">Record student attendance</p>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/admin/marks" class="text-decoration-none">
                            <div class="menu-card">
                                <i class="fas fa-edit menu-icon text-warning"></i>
                                <h5>Enter Marks</h5>
                                <p class="text-muted mb-0">Auto-grading enabled</p>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-3">
                        <a href="${pageContext.request.contextPath}/admin/defaulters" class="text-decoration-none">
                            <div class="menu-card">
                                <i class="fas fa-exclamation-circle menu-icon text-danger"></i>
                                <h5>View Defaulters</h5>
                                <p class="text-muted mb-0">Attendance < 75%</p>
                            </div>
                        </a>
                    </div>
                </div>
            </div>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>

        </html>