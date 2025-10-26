<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Returned Books - Library Management</title>
        <style>
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
                padding: 12px 40px;
            }

            .navbar .logo {
                font-weight: 600;
                font-size: 18px;
            }

            /* ==== BACK LINK ==== */
            .back-link {
                display: flex;
                margin: 0 0 16px;
                text-decoration: none;
                color: #2563eb;
                font-weight: 500;
                align-items: center;
                gap: 6px;
            }

            .back-link:hover {
                text-decoration: underline;
                color: #1d4ed8;
            }

            /* ==== MAIN CONTENT ==== */
            .book-container {
                flex: 1;
                padding: 40px 60px;
                text-align: center;
            }

            /* ✅ PAGE TITLE (22px + gradient underline) */
            .page-title {
                text-align: center;
                margin-bottom: 25px;
            }

            .page-title h2 {
                font-size: 22px;
                font-weight: 700;
                color: #1f2937;
                text-transform: uppercase;
                display: inline-block;
                position: relative;
                letter-spacing: 0.5px;
            }

            .page-title h2::after {
                content: "";
                display: block;
                width: 60%;
                height: 3px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                margin: 6px auto 0;
                border-radius: 2px;
            }

            /* ==== BOOK GALLERY ==== */
            .book-gallery {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
                gap: 25px;
                justify-items: center;
                margin-top: 15px;
            }

            .book-card {
                background: #fff;
                border-radius: 12px;
                overflow: hidden;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
                transition: transform 0.25s ease, box-shadow 0.25s ease;
                width: 150px;
            }

            .book-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 6px 18px rgba(0, 0, 0, 0.15);
            }

            .book-card img {
                width: 100%;
                height: 200px;
                object-fit: cover;
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
    </head>

    <body>
        <nav class="navbar">
            <span class="logo">📚 Library System</span>
        </nav>

        <div class="book-container">
            <div class="page-title">
                <h2>Returned Books</h2>
            </div>

            <a class="back-link" href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a>

            <div class="book-gallery">
                <c:forEach var="book" items="${returnedBooks}">
                    <a class="book-card">
                        <img src="${pageContext.request.contextPath}/resources/images/${book.value}" alt="Book cover">
                    </a>
                </c:forEach>
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
