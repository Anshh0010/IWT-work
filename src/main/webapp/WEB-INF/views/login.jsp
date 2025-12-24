<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login - Student Management System</title>
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
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 20px;
            }

            .login-container {
                background: white;
                border-radius: 20px;
                box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
                overflow: hidden;
                max-width: 450px;
                width: 100%;
                animation: slideIn 0.5s ease-out;
            }

            @keyframes slideIn {
                from {
                    opacity: 0;
                    transform: translateY(-30px);
                }

                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .login-header {
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                padding: 40px 30px;
                text-align: center;
            }

            .login-header h1 {
                font-size: 28px;
                margin-bottom: 10px;
                font-weight: 600;
            }

            .login-header p {
                font-size: 14px;
                opacity: 0.9;
            }

            .login-body {
                padding: 40px 30px;
            }

            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                color: #333;
                font-weight: 500;
                font-size: 14px;
            }

            .form-group input {
                width: 100%;
                padding: 14px 16px;
                border: 2px solid #e0e0e0;
                border-radius: 10px;
                font-size: 15px;
                transition: all 0.3s ease;
                background: #f8f9fa;
            }

            .form-group input:focus {
                outline: none;
                border-color: #667eea;
                background: white;
                box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            }

            .error-message {
                background: #fee;
                color: #c33;
                padding: 14px 16px;
                border-radius: 10px;
                margin-bottom: 20px;
                border-left: 4px solid #c33;
                font-size: 14px;
                animation: shake 0.4s ease;
            }

            @keyframes shake {

                0%,
                100% {
                    transform: translateX(0);
                }

                25% {
                    transform: translateX(-10px);
                }

                75% {
                    transform: translateX(10px);
                }
            }

            .login-button {
                width: 100%;
                padding: 16px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 10px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                box-shadow: 0 4px 15px rgba(102, 126, 234, 0.4);
            }

            .login-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(102, 126, 234, 0.6);
            }

            .login-button:active {
                transform: translateY(0);
            }

            .demo-credentials {
                margin-top: 30px;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 12px;
                border: 2px dashed #667eea;
            }

            .demo-credentials h3 {
                color: #667eea;
                font-size: 16px;
                margin-bottom: 12px;
                font-weight: 600;
                text-align: center;
            }

            .demo-item {
                background: white;
                padding: 12px 16px;
                margin-bottom: 10px;
                border-radius: 8px;
                font-size: 13px;
                border-left: 3px solid #667eea;
            }

            .demo-item:last-child {
                margin-bottom: 0;
            }

            .demo-item strong {
                color: #667eea;
                display: inline-block;
                width: 80px;
            }

            .demo-item code {
                background: #f0f0f0;
                padding: 2px 8px;
                border-radius: 4px;
                font-family: 'Courier New', monospace;
                color: #333;
            }

            .footer-text {
                text-align: center;
                margin-top: 20px;
                color: #666;
                font-size: 13px;
            }

            @media (max-width: 480px) {
                .login-container {
                    border-radius: 15px;
                }

                .login-header {
                    padding: 30px 20px;
                }

                .login-body {
                    padding: 30px 20px;
                }
            }
        </style>
    </head>

    <body>
        <div class="login-container">
            <div class="login-header">
                <h1>🎓 Student Management</h1>
                <p>Sign in to your account</p>
            </div>

            <div class="login-body">
                <% String error=(String) request.getAttribute("error"); if (error !=null) { %>
                    <div class="error-message">
                        ⚠️ <%= error %>
                    </div>
                    <% } %>

                        <form method="post" action="<%= request.getContextPath() %>/login">
                            <div class="form-group">
                                <label for="email">Email Address</label>
                                <input type="email" id="email" name="email" placeholder="Enter your email"
                                    value="<%= request.getAttribute(" email") !=null ? request.getAttribute("email")
                                    : "" %>"
                                required
                                autofocus>
                            </div>

                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" placeholder="Enter your password"
                                    required>
                            </div>

                            <button type="submit" class="login-button">
                                Login →
                            </button>
                        </form>

                        <div class="demo-credentials">
                            <h3>🔑 Demo Credentials</h3>
                            <div class="demo-item">
                                <strong>Student 1:</strong>
                                <code>test@test.com</code> / <code>test</code>
                            </div>
                            <div class="demo-item">
                                <strong>Student 2:</strong>
                                <code>student@student.com</code> / <code>student</code>
                            </div>
                        </div>

                        <p class="footer-text">
                            Need help? Contact administrator
                        </p>
            </div>
        </div>
    </body>

    </html>