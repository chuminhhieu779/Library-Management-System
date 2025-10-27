<%-- 
    Document   : homepage
    Created on : Oct 10, 2025, 10:06:37 PM
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Library Management - Home</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

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
            padding: 15px 60px;
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

        /* ==== MAIN ==== */
        main {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
        }

        marquee h2 {
            font-size: 26px;
            font-weight: 700;
            color: #a5b4fc;
            margin-bottom: 25px;
            text-shadow: 0 0 8px rgba(99, 102, 241, 0.6);
        }

        /* ==== LOGIN FORM ==== */
        .login {
            display: flex;
            justify-content: center;
            width: 100%;
        }

        form {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.25);
            max-width: 420px;
            width: 100%;
            text-align: left;
            backdrop-filter: blur(5px);
        }

        .title h3 {
            text-align: center;
            color: #4f46e5;
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 25px;
        }

        .login-content {
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .login-content label {
            font-weight: 600;
            color: #374151;
        }

        .login-content input {
            padding: 12px;
            border-radius: 6px;
            border: 1px solid #ced4da;
            font-size: 15px;
            transition: all 0.3s;
        }

        .login-content input:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79,70,229,0.25);
        }

        .login-content button {
            background: linear-gradient(90deg, #4f46e5, #7c3aed);
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 600;
            padding: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .login-content button:hover {
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            transform: translateY(-2px);
        }

        #sign-up {
            text-align: center;
            margin-top: 10px;
        }

        #sign-up a {
            color: #4f46e5;
            text-decoration: none;
            font-weight: 600;
        }

        #sign-up a:hover {
            color: #7c3aed;
            text-decoration: underline;
        }

        .login-content p {
            padding: 10px;
            border-radius: 6px;
            font-size: 14px;
            text-align: center;
            font-weight: 500;
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
    <!-- ==== HEADER + NAV COMBINED ==== -->
    <header>
        <div class="logo-section">
            <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="logo">
            <h3>Library Management System</h3>
        </div>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/book/list">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/user/login">User Login</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/login">Admin Login</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <marquee behavior="scroll" direction="left" scrollamount="10">
            <h2>Welcome to Library Management System</h2>
        </marquee>

        <div class="login">
            <form action="${pageContext.request.contextPath}/user/login" method="post">
                <div class="title">
                    <h3>Login Form</h3>
                </div>
                <div class="login-content">
                    <% if (request.getAttribute("error") != null) { %>
                        <p style="background-color:#f8d7da; color:#721c24; border-left:4px solid #dc3545;">
                            <%= request.getAttribute("error") %>
                        </p>
                    <% } %>
                    <% if (request.getAttribute("success") != null) { %>
                        <p style="background-color:#d4edda; color:#155724; border-left:4px solid #28a745;">
                            <%= request.getAttribute("success") %>
                        </p>
                    <% } %>

                    <label>Enter your account:</label>
                    <input type="text" name="account">
                    <label>Enter your password:</label>
                    <input type="password" name="password">
                    <button type="submit">Login</button>
                    <div id="sign-up">
                        <a href="${pageContext.request.contextPath}/user/register">Sign Up</a>
                    </div>
                </div>
            </form>
        </div>
    </main>

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
