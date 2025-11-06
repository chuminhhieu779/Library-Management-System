<%-- 
    Document   : dashboard
    Created on : Oct 18, 2025
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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

            /* ==== NAVBAR ==== */
            .navbar {
                background: #111827;
                color: #e5e7eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 5px;
            }

            .navbar .logo {
                font-weight: 600;
                font-size: 16px;
                padding-left: 20px;
            }

            /* ==== USER MENU ==== */
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

            /* Dropdown menu */
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
                border: 2px solid #6366f1;
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
                transition: color 0.25s;
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

            /* ==== DASHBOARD CONTENT ==== */
            .dashboard {
                flex: 1;
                padding: 40px;
                text-align: center;
            }

            /* ✅ Title with gradient underline */
            .dashboard h2 {
                font-size: 22px;
                font-weight: 700;
                color: #1f2937;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                position: relative;
                display: inline-block;
                margin-top: 20px;
            }

            .dashboard h2::after {
                content: "";
                display: block;
                width: 60%;
                height: 3px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                margin: 6px auto 0;
                border-radius: 2px;
            }

            /* ==== STAT CARDS ==== */
            .stats {
                display: flex;
                justify-content: center;
                flex-wrap: wrap;
                gap: 30px;
                margin-top: 70px;
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

            /* ==== FOOTER ==== */
            .footer {
                background: linear-gradient(135deg, #111827, #1f2937);
                color: #d1d5db;
                text-align: center;
                padding: 15px 20px;
                font-size: 14px;
                border-top: 2px solid #4f46e5;
                margin-top: auto;
            }

            .footer-content {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 40px;
                flex-wrap: wrap;
            }

            .footer-content a {
                color: #a5b4fc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .footer-content a:hover {
                color: #818cf8;
            }

            .footer p {
                margin-top: 10px;
                font-size: 13px;
                color: #9ca3af;
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

            /* ==== USER REVIEW HISTORY ==== */
            .review-history {
                background: #fff;
                padding: 30px 40px;
                border-radius: 16px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.06);
                margin: 20px 240px 200px;
                max-width: 80%;
                width: calc(70% - 50px);
            }

            .review-history .section-header {
                font-size: 20px;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 25px;
                position: relative;
                padding-bottom: 12px;
                text-align: center ;
            }

            .review-history .section-header::after {
                content: "";
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%); 
                width: 80px;
                height: 4px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                border-radius: 2px;
            }


            .review-list {
                list-style: none;
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr)); /* Giảm min-width để fit nhiều cột */
                gap: 24px;
            }

            .review-item {
                display: flex;
                flex-direction: column;
                background: #f9fafb;
                border-radius: 12px;
                border: 1px solid #e5e7eb;
                cursor: pointer;
                transition: all 0.3s ease;
                overflow: hidden;
                position: relative;
            }

            .review-item::before {
                content: "";
                position: absolute;
                top: 0;
                left: 50%;
                right: 0;
                height: 4px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                transform: scaleX(0);
                transition: transform 0.3s ease;
            }

            .review-item:hover {
                background: #fff;
                border-color: #6366f1;
                box-shadow: 0 8px 20px rgba(99, 102, 241, 0.15);
                transform: translateY(-4px);
            }

            .review-item:hover::before {
                transform: scaleX(1);
            }

            /* Book Cover - Square/Portrait */
            .review-cover {
                width: 100%;
                height: 320px;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .review-item:hover .review-cover {
                transform: scale(1.05);
            }

            /* Review Content */
            .review-content {
                padding: 20px;
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            .review-content h6 {
                font-size: 16px;
                font-weight: 600;
                color: #111827;
                margin-bottom: 10px;
                line-height: 1.3;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                min-height: 42px;
            }

            /* Rating Stars */
            .review-rating {
                display: flex;
                gap: 3px;
                margin-bottom: 10px;
            }

            .review-rating i {
                color: #fbbf24;
                font-size: 14px;
            }

            .review-content p {
                font-size: 14px;
                color: #6b7280;
                line-height: 1.6;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                text-overflow: ellipsis;
                margin-bottom: 12px;
                flex: 1;
            }

            /* Review Meta Info */
            .review-meta {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 12px;
                border-top: 1px solid #e5e7eb;
                font-size: 12px;
                color: #9ca3af;
            }

            .review-meta span {
                display: flex;
                align-items: center;
                gap: 5px;
            }

            .review-meta i {
                font-size: 12px;
            }

            .review-time {
                font-size: 12px;
                font-weight: 600;
                color: #6366f1;
                display: flex;
                align-items: center;
                gap: 5px;
            }

            /* Empty State - No Button */
            .no-review {
                text-align: center;
                padding: 80px 20px;
                color: #9ca3af;
                grid-column: 1 / -1;
            }

            .no-review i {
                font-size: 64px;
                color: #c7d2fe;
                margin-bottom: 20px;
                display: block;
            }

            .no-review p {
                font-size: 16px;
                color: #6b7280;
                margin-top: 10px;
            }

            /* Responsive */
            @media (max-width: 1400px) {
                .review-list {
                    grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
                }
            }

            @media (max-width: 1024px) {
                .review-history {
                    margin: 40px 20px 20px;
                    padding: 25px 30px;
                }

                .review-list {
                    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                    gap: 20px;
                }

                .review-cover {
                    height: 280px;
                }
            }

            @media (max-width: 768px) {
                .review-history {
                    margin: 40px 15px 20px;
                    padding: 20px;
                }

                .review-list {
                    grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                    gap: 16px;
                }

                .review-cover {
                    height: 240px;
                }

                .review-content {
                    padding: 16px;
                }

                .review-content h6 {
                    font-size: 15px;
                    min-height: 38px;
                }

                .review-content p {
                    font-size: 13px;
                    -webkit-line-clamp: 2;
                }
            }

            @media (max-width: 480px) {
                .review-list {
                    grid-template-columns: 1fr;
                }

                .review-cover {
                    height: 300px;
                }

                .review-history .section-header {
                    font-size: 18px;
                }

                .no-review {
                    padding: 60px 20px;
                }

                .no-review i {
                    font-size: 48px;
                }
            }
        </style>
    </head>

    <body>
        <!-- Navbar -->
        <nav class="navbar">
            <span class="logo">📚 Library System</span>

            <div class="user-menu">
                <img src="${pageContext.request.contextPath}/resources/images/${sessionScope.user.avatar}" 
                     alt="User Avatar" class="avatar">

                <div class="dropdown">
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/resources/images/${sessionScope.user.avatar}" 
                             alt="User Avatar Large" class="avatar-large">
                        <p class="username">${sessionScope.user.fullName}</p>
                        <p class="role">Library Member</p>
                    </div>
                    <hr>
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="dropdown-item">
                        <i class="fa-solid fa-user"></i> DashBoard
                    </a>     
                    <a href="${pageContext.request.contextPath}/favorite/books" class="dropdown-item">
                        <i class="fa-solid fa-heart"></i> Favorite 
                    </a>     
                    <a href="${pageContext.request.contextPath}/user/setting" class="dropdown-item">
                        <i class="fa-solid fa-gear"></i> Setting
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
        <!-- ==== USER REVIEW HISTORY ==== -->
        <!-- ==== USER REVIEW HISTORY ==== -->
        <section class="review-history">
            <h3 class="section-header">📝 Recent Reviews Activity </h3>
            <c:choose>
                <c:when test="${not empty reviewList}">
                    <ul class="review-list">
                        <c:forEach var="r" items="${reviewList}">
                            <li class="review-item" onclick="location.href = '${pageContext.request.contextPath}/book/detail?slug=${r.bookSlug}&bookID=${r.bookID}'">
                                <img src="${pageContext.request.contextPath}/resources/images${r.coverImage}" 
                                     alt="${r.bookTitle}" class="review-cover">

                                <div class="review-content">
                                    <h6>${r.bookTitle}</h6>

                                    <!-- Rating -->
                                    <c:if test="${not empty r.rating}">
                                        <div class="review-rating">
                                            <c:forEach begin="1" end="${r.rating}">
                                                <i class="fa-solid fa-star"></i>
                                            </c:forEach>
                                            <c:forEach begin="${r.rating + 1}" end="5">
                                                <i class="fa-regular fa-star"></i>
                                            </c:forEach>
                                        </div>
                                    </c:if>

                                    <p>
                                        <c:choose>
                                            <c:when test="${fn:length(r.content) > 120}">
                                                ${fn:substring(r.content, 0, 120)}...
                                            </c:when>
                                            <c:otherwise>
                                                ${r.content}
                                            </c:otherwise>
                                        </c:choose>
                                    </p>

                                    <div class="review-meta">
                                        <span><i class="fa-solid fa-calendar"></i> ${r.createdAt}</span>
                                        <span class="review-time">
                                            <i class="fa-regular fa-clock"></i> ${r.timeAgo}
                                        </span>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>               
            </c:choose>
        </section>


        <!-- Footer -->
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
