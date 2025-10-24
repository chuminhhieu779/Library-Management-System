<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - Online Library Management System</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f2f5; /* Nền xám nhạt */
            color: #333;
        }

        /* --- Header / Navigation Bar --- */
        .navbar {
            background-color: #fff;
            padding: 15px 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px 50px; /* Thêm padding ngang */
        }

        .navbar-brand {
            display: flex;
            align-items: center;
            font-size: 24px;
            font-weight: bold;
            color: #333;
            text-decoration: none;
        }

        .navbar-brand img {
            height: 40px; /* Kích thước logo */
            margin-right: 10px;
        }

        .navbar-links ul {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
        }

        .navbar-links li {
            margin-left: 25px;
        }

        .navbar-links a {
            color: #555;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.3s ease;
        }

        .navbar-links a:hover {
            color: #007bff; /* Màu xanh khi hover */
        }

        /* --- Horizontal Divider / Purple Line --- */
        .divider {
            height: 5px;
            background-color: #6a0dad; /* Màu tím */
            margin-bottom: 30px; /* Khoảng cách với nội dung bên dưới */
        }

        /* --- Main Content Area --- */
        .container {
            max-width: 1000px;
            margin: 30px auto;
            padding: 20px;
        }

        /* --- Page Title / Form Heading --- */
        .page-title {
            font-size: 28px;
            font-weight: bold;
            color: #555;
            margin-bottom: 25px;
            text-align: left; /* Đặt lại thành left như trong ảnh */
        }

        /* --- Login Form Box --- */
        .login-box {
            background-color: #fff;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            max-width: 450px; /* Rộng hơn một chút so với ảnh */
            margin: 0 auto; /* Canh giữa */
            border-top: 5px solid #007bff; /* Viền xanh phía trên như trong ảnh */
        }

        .login-box h3 {
            font-size: 22px;
            font-weight: 600;
            color: #333;
            margin-bottom: 25px;
            text-align: center;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #444;
        }

        .form-control {
            width: 100%;
            padding: 12px;
            border: 1px solid #ced4da;
            border-radius: 5px;
            font-size: 16px;
            box-sizing: border-box; /* Đảm bảo padding không làm tăng width */
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            border-color: #007bff;
            outline: none;
            box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.25);
        }

        .btn-login {
            width: 100%;
            padding: 12px;
            background-color: #007bff; /* Màu xanh dương */
            color: #fff;
            border: none;
            border-radius: 5px;
            font-size: 18px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .btn-login:hover {
            background-color: #0056b3; /* Xanh đậm hơn khi hover */
        }

        /* --- Messages (Optional, for error/success) --- */
        .alert {
            padding: 10px;
            margin-bottom: 20px;
            border-radius: 5px;
            text-align: center;
        }
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        /* --- Scroll Arrows (Not implemented in static HTML, just for visual reference) --- */
        .scroll-arrow {
            position: fixed;
            right: 20px;
            background-color: #555;
            color: #fff;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 20px;
            cursor: pointer;
            z-index: 1000;
            opacity: 0.7;
        }
        .scroll-up { top: 100px; } /* Vị trí giả định */
        .scroll-down { top: 150px; } /* Vị trí giả định */
    </style>
</head>
<body>

    <div class="navbar">
        <a href="#" class="navbar-brand">
            <img src="images/library-logo.png" alt="Library Logo"> Library Management System
        </a>
        <div class="navbar-links">
            <ul>
                <li><a href="${pageContext.request.contextPath}/Login">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/Login">User login</a></li>
                <li><a href="${pageContext.request.contextPath}/user/register">User Sign Up</a></li>
        </div>
    </div>

    <div class="divider"></div>

    <div class="container">
        <h2 class="page-title">Admin login form</h2>

        <div class="login-box">
            <h3>LOGIN FORM</h3>

            <%-- Hiển thị thông báo lỗi/thành công từ Servlet --%>
            <c:if test="${not empty requestScope.errorMessage}">
                <div class="alert alert-danger">${requestScope.errorMessage}</div>
            </c:if>
            <c:if test="${not empty requestScope.successMessage}">
                <div class="alert alert-success">${requestScope.successMessage}</div>
            </c:if>

            <form action="Admin" method="post"> 
                <div class="form-group">
                    <label for="username">Enter Username</label>
                    <input type="text" id="username" name="adminUsername" class="form-control"  required>
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="adminPassword" class="form-control"  required>
                </div>
                <button type="submit" class="btn-login">LOGIN</button>
            </form>
        </div>
    </div>


</body>
</html>