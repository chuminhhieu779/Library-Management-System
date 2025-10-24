<%--
    Document   : homepage
    Created on : Oct 10, 2025, 10:06:37 PM
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Library Management System</title>
        <%-- Nạp file CSS, thêm tham số version để tránh lỗi cache trình duyệt --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/homepage.css?v=<%=System.currentTimeMillis()%>">
        <%-- Font Awesome CDN --%>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <%-- Google Fonts (Tùy chọn, để có font chữ đẹp hơn) --%>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
    </head>
    <body>

        <%-- Header và Navigation được gộp chung để dễ quản lý --%>
        <header class="header">
            <div class="header-container">
                <div class="logo">
                    <%-- Bạn có thể thêm logo ở đây --%>
                    <a href="${pageContext.request.contextPath}/">Library Management System</a>
                </div>
                <nav class="navigation">
                    <ul>
                        <li><a href="#">Home</a></li>
                        <li><a href="#">About</a></li>
                        <li><a href="#">Contact</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/login" class="nav-button">User Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/login" class="nav-button">Admin Login</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <main>
            <%-- Hero section chứa ảnh nền, tiêu đề và form --%>
            <section class="hero-section">
                <div class="hero-content">
                    <div class="hero-text">
                        <h1>Welcome to Our Library</h1>
                        <p>Your gateway to a world of knowledge. Access thousands of books, articles, and resources.</p>
                    </div>

                    <div class="login-wrapper">
                        <form action="${pageContext.request.contextPath}/user/login" method="post" class="login-form">
                            <h3>Member Login</h3>

                            <%-- Hiển thị thông báo lỗi hoặc thành công bằng JSTL --%>
                            <c:if test="${not empty error}">
                                <div class="message error-message">${error}</div>
                            </c:if>
                            <c:if test="${not empty success}">
                                <div class="message success-message">${success}</div>
                            </c:if>

                            <div class="input-group">
                                <i class="fas fa-user"></i>
                                <input type="text" name="account" placeholder="Enter your account" required>
                            </div>

                            <div class="input-group">
                                <i class="fas fa-lock"></i>
                                <input type="password" name="password" placeholder="Enter your password" required>
                            </div>

                            <button type="submit" class="login-button">Login</button>

                            <div class="form-footer">
                                <p>Don't have an account? <a href="${pageContext.request.contextPath}/user/register">Sign Up</a></p>
                            </div>
                        </form>
                    </div>
                </div>
            </section>
        </main>

        <footer class="footer">
            <%-- Giả sử bạn có file footer.jsp, nếu không có thể thay bằng nội dung HTML --%>
            <%-- <%@include file="/WEB-INF/views/components/footer.jsp" %> --%>
            <p>&copy; 2025 Library Management System. All rights reserved.</p>
        </footer>

    </body>
</html>