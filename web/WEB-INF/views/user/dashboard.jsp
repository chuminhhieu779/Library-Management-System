<%-- 
    Document   : dashboard
    Created on : Oct 18, 2025
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Dashboard</title>

        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

        <style>
            /* Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f9f9ff;
            }
            .user-menu {
                position: relative;
                display: inline-block;
            }
            .user-menu::after {
                content: "";
                position: absolute;
                top: 38px;
                right: 0;
                width: 100%;
                height: 20px;
            }

            /* Avatar small */
            .avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                object-fit: cover;
                cursor: pointer;
                border: 2px solid #a5b4fc;
                transition: transform 0.2s ease;
            }
            .avatar:hover {
                transform: scale(1.05);
            }

            /* Dropdown */
            .dropdown {
                opacity: 0;
                visibility: hidden;
                position: absolute;
                right: 0;
                top: 55px;
                background: #1f2937;
                color: #e5e7eb;
                width: 220px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
                z-index: 10;
                padding: 15px;
                transition: opacity 0.2s ease, transform 0.2s ease;
                transform: translateY(-5px);
            }

            .user-menu:hover .dropdown {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .dropdown .user-info {
                text-align: center;
            }
            .avatar-large {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                border: 2px solid #a5b4fc;
                object-fit: cover;
                margin-bottom: 8px;
            }
            .username {
                font-weight: 600;
                font-size: 16px;
                margin: 2px 0;
            }
            .role {
                font-size: 13px;
                color: #9ca3af;
            }

            .dropdown-item {
                display: block;
                color: #e5e7eb;
                text-decoration: none;
                font-size: 14px;
                padding: 8px 0;
            }
            .dropdown-item:hover {
                color: #a5b4fc;
            }
            .logout {
                color: #f87171;
            }
            .logout:hover {
                color: #ef4444;
            }

            /* Navbar */
            .navbar {
                background: #111827;
                color: #e5e7eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 40px;
            }
            .navbar .logo {
                font-weight: 600;
                font-size: 18px;
            }

            /* Dashboard */
            .dashboard {
                flex: 1;
                padding: 40px;

            }

            .dashboard h2 {
                display: flex;
                justify-content: center;
                margin-top: 20px;
                font-size: 22px;
                font-weight: 600;
                color: #444;
            }

            .stats {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 30px;
                margin-top: 80px;
            }

            .card {
                text-decoration: none;
                color: inherit;
                background: #fff;
                width: 250px;
                padding: 25px 20px;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
                text-align: center;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 18px rgba(99,102,241,0.15);
            }

            .icon {
                font-size: 38px;
                margin-bottom: 8px;
            }

            .blue {
                color: #3b82f6;
            }
            .green {
                color: #22c55e;
            }
            .orange {
                color: #f59e0b;
            }

            .card h3 {
                font-size: 28px;
                margin: 8px 0;
                color: #2d3436;
            }

            .card p {
                color: #636e72;
                font-size: 14px;
            }

            /* Footer */
            .footer {
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 25px 10px;
                border-top: 1px solid #1f2937;
            }

            .footer-section h3 {
                margin-bottom: 6px;
                font-size: 18px;
                color: #a5b4fc;
            }

            .footer-section p {
                font-size: 13px;
                line-height: 1.5;
                max-width: 600px;
                margin: 0 auto;
            }

            @media (max-width: 768px) {
                .stats {
                    flex-direction: column;
                    align-items: center;
                }
                .card {
                    width: 80%;
                }
            }
        </style>
    </head>

    <body>
        <!-- Navbar -->
        <nav class="navbar">
            <span class="logo">📚 Library System</span>

            <div class="user-menu">
                <img src="${pageContext.request.contextPath}/resources/images/1.jpg" 
                     alt="User Avatar" class="avatar">

                <div class="dropdown">
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/resources/images/1.jpg" 
                             alt="User Avatar Large" class="avatar-large">
                        <p class="username">${sessionScope.user.name}</p>
                        <p class="role">Library Member</p>
                    </div>
                    <hr>
                    <a href="${pageContext.request.contextPath}/user/profile" class="dropdown-item">
                        <i class="fa-solid fa-user"></i> Profile
                    </a>     
                    <a href="${pageContext.request.contextPath}/favorite/books" class="dropdown-item">
                        <i class="fa-solid fa-user"></i> Favorite 
                    </a>     
                    <a href="${pageContext.request.contextPath}/LogOut" class="dropdown-item logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </div>
            </div>
        </nav>

        <!-- Dashboard -->
        <section class="dashboard">
            <h2>User Dashboard</h2>

            <div class="stats">
                <a href="${pageContext.request.contextPath}/book/list" class="card">
                    <i class="fa-solid fa-book-open icon blue"></i>
                    <h3>${totalBook}</h3>
                    <p>Total Books</p>
                </a>

                <a href="${pageContext.request.contextPath}/borrowing/borrowed" class="card">
                    <i class="fa-solid fa-recycle icon green"></i>
                    <h3>${totalBorrowedBook}</h3>
                    <p>Borrowed Books</p>
                </a>

                <a href="${pageContext.request.contextPath}/borrowing/returned" class="card">
                    <i class="fa-solid fa-hand-holding icon orange"></i>
                    <h3>${totalReturnedBooks}</h3>
                    <p>Returned Books</p>
                </a>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <%@include file="/WEB-INF/views/components/footer.jsp" %>
        </footer>
    </body>
</html>
