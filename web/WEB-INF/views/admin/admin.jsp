<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Library Management System</title>
    <style>
        /* ==== RESET ==== */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            background: linear-gradient(
                rgba(17, 24, 39, 0.85),
                rgba(17, 24, 39, 0.85)
            ),
            url("${pageContext.request.contextPath}/resources/images/1.jpg") center/cover no-repeat;
            background-attachment: fixed;
            color: #f9fafb;
        }

        /* ==== HEADER + NAV MERGED ==== */
        header {
            background: rgba(17, 24, 39, 0.9);
            border-bottom: 2px solid #4f46e5;
            padding: 12px 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo-section {
            display: flex;
            align-items: center;
        }

        .logo-section img {
            height: 42px;
            width: 42px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
            border: 2px solid #6366f1;
        }

        .logo-section h3 {
            font-size: 1.3em;
            font-weight: 700;
            color: #e5e7eb;
        }

        nav ul {
            list-style: none;
            display: flex;
            gap: 30px;
        }

        nav ul li a {
            color: #fff;
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            transition: color 0.3s;
        }

        nav ul li a:hover {
            color: #a5b4fc;
        }

        /* ==== MAIN CONTENT ==== */
        .container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 50px 20px;
        }

        .login-box {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.25);
            max-width: 420px;
            width: 100%;
            text-align: center;
            backdrop-filter: blur(5px);
        }

        .login-box h3 {
            font-size: 24px;
            font-weight: 700;
            color: #4f46e5;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 20px;
            text-align: left;
        }

        .form-group label {
            font-weight: 600;
            color: #374151;
            display: block;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 15px;
            transition: 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79,70,229,0.25);
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(90deg, #4f46e5, #7c3aed);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-login:hover {
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            transform: translateY(-2px);
        }

        /* ==== ALERTS ==== */
        .alert {
            padding: 10px;
            border-radius: 6px;
            font-size: 14px;
            margin-bottom: 18px;
            text-align: center;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }

        /* ==== FOOTER ==== */
        .footer {
            background: rgba(17, 24, 39, 0.9);
            color: #d1d5db;
            text-align: center;
            padding: 20px;
            border-top: 2px solid #4f46e5;
        }

        .footer-content {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
            margin-bottom: 10px;
        }

        .footer-content a {
            color: #a5b4fc;
            text-decoration: none;
            transition: color 0.3s;
        }

        .footer-content a:hover {
            color: #818cf8;
        }

        .footer p {
            font-size: 13px;
            color: #9ca3af;
        }
    </style>
</head>

<body>
    <!-- ===== HEADER + NAVIGATION ===== -->
    <header>
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="Logo">
            <h3>Library Management System</h3>
        </div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/book/list">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/login">User Login</a></li>
                <li><a href="${pageContext.request.contextPath}/user/register">User Sign Up</a></li>
            </ul>
        </nav>
    </header>

    <!-- ===== MAIN CONTENT ===== -->
    <div class="container">
        <div class="login-box">
            <h3>Admin Login</h3>

            <c:if test="${not empty requestScope.errorMessage}">
                <div class="alert alert-danger">${requestScope.errorMessage}</div>
            </c:if>
            <c:if test="${not empty requestScope.successMessage}">
                <div class="alert alert-success">${requestScope.successMessage}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/login" method="post">
                <div class="form-group">
                    <label for="username">Enter Username</label>
                    <input type="text" id="username" name="adminUsername" class="form-control" required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="adminPassword" class="form-control" required>
                </div>
                <button type="submit" class="btn-login">LOGIN</button>
            </form>
        </div>
    </div>

    <!-- ===== FOOTER ===== -->
    <footer class="footer">
        <div class="footer-content">
            <a href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
        </div>
        <p>&copy; 2025 Library Management System — All rights reserved.</p>
    </footer>
</body>
</html>
