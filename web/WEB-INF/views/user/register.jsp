<%-- 
    Document   : register
    Created on : Oct 13, 2025, 10:24:59 PM
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>User Register - Library Management</title>
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

        /* ==== MAIN CONTENT ==== */
        content {
            display: flex;
            justify-content: center;
            align-items: center;
            flex: 1;
            padding: 50px 20px;
        }

        form {
            background-color: rgba(255, 255, 255, 0.95);
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.25);
            width: 100%;
            max-width: 420px;
            text-align: center;
            backdrop-filter: blur(5px);
        }

        #title h2 {
            font-size: 26px;
            font-weight: 700;
            color: #4f46e5;
            margin-bottom: 25px;
        }

        #content-login {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        #content-login label {
            text-align: left;
            font-weight: 600;
            color: #374151;
        }

        #content-login input {
            padding: 12px 14px;
            border: 1px solid #ced4da;
            border-radius: 6px;
            font-size: 15px;
            transition: 0.3s;
        }

        #content-login input:focus {
            outline: none;
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79,70,229,0.25);
        }

        #content-login button {
            background: linear-gradient(90deg, #4f46e5, #7c3aed);
            color: white;
            padding: 13px;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            margin-top: 8px;
            transition: all 0.3s;
        }

        #content-login button:hover {
            background: linear-gradient(90deg, #6366f1, #8b5cf6);
            transform: translateY(-2px);
        }

        #content-login p {
            background-color: #f8d7da;
            border-left: 4px solid #dc3545;
            border-radius: 4px;
            font-size: 14px;
            color: #721c24;
            padding: 10px;
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
    <!-- ==== HEADER + MENU ==== -->
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

    <!-- ==== MAIN CONTENT ==== -->
    <content>
        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div id="title">
                <h2>Sign Up User</h2>
            </div>
            <div id="content-login">
                <% if (request.getAttribute("error") != null) { %>
                    <p><%= request.getAttribute("error") %></p>
                <% } %>
                <label>Enter user name:</label>
                <input type="text" name="username">
                <label>Enter account:</label>
                <input type="text" name="account">
                <label>Enter password:</label>
                <input type="password" name="password">
                <button type="submit">Sign Up</button>
            </div>
        </form>
    </content>

    <!-- ==== FOOTER ==== -->
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
