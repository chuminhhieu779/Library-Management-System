<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Favorite Books - Library Management</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f4f6f8;
                color: #333;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* ==== NAVIGATION ==== */
            nav {
                background: rgb(19, 24, 39);
                padding: 15px 0;
            }
            nav ul {
                display: flex;
                justify-content: center;
                list-style: none;
            }
            nav li {
                margin: 0 20px;
            }
            nav a {
                text-decoration: none;
                color: #fff;
                font-weight: 500;
                transition: color 0.3s;
            }
            nav a:hover {
                color: #a5b4fc;
            }

            /* ==== MAIN ==== */
            .book-container {
                flex: 1;
                padding: 40px 60px;
                text-align: center;
            }

            .book-container h2 {
                font-size: 26px;
                margin-bottom: 30px;
                color: #3f3f46;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
            }

            .book-container h2 i {
                color: #3b82f6;
            }

            .book-gallery {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 25px;
                justify-items: center;
            }

            .book-card {
                background: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.25s ease, box-shadow 0.25s ease;
                width: 160px;
                text-align: center;
                position: relative;
            }

            .book-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
            }

            .book-card img {
                width: 100%;
                height: 210px;
                object-fit: cover;
            }

            .book-info {
                padding: 10px 8px;
            }

            .book-title {
                font-weight: 600;
                color: #111827;
                font-size: 15px;
                margin-bottom: 5px;
            }

            .book-chapter {
                font-size: 13px;
                color: #6b7280;
                margin-bottom: 6px;
            }

            .remove-btn {
                display: inline-block;
                font-size: 13px;
                color: #ef4444;
                text-decoration: none;
                transition: color 0.2s;
            }

            .remove-btn:hover {
                color: #b91c1c;
                text-decoration: underline;
            }


            .time-badge {
                position: absolute;
                top: 8px;
                left: 8px;
                background: rgba(59,130,246,0.9);
                color: #fff;
                font-size: 12px;
                padding: 3px 6px;
                border-radius: 6px;
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

        </style>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/book/category">Category</a></li>
                <li><a href="${pageContext.request.contextPath}/book/search">Search Book</a></li>
            </ul>
        </nav>

        <div class="book-container">
            <h2><i class="fa-solid fa-flag"></i> Truyện Đang Theo Dõi</h2>

            <div class="book-gallery">
                <c:forEach var="book" items="${favoriteBooks}">
                    <div class="book-card">
                        <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="book-card" >
                            <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}">      
                        </a>
                    </div>
                </c:forEach>
                <c:if test="${empty favoriteBooks}">
                    <p style="color:#6b7280;">Bạn chưa theo dõi truyện nào.</p>
                </c:if>                
            </div>
        </div>

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
