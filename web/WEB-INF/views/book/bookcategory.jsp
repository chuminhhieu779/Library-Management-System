<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Category - Library Management</title>
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
                padding: 15px 60px;
                display: flex;
                justify-content: center;
                align-items: center;
                position: relative;
                z-index: 10;
            }

            .nav-center ul {
                display: flex;
                list-style: none;
            }

            .nav-center li {
                margin: 0 25px;
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

            /* ==== USER / AUTH AREA ==== */
            .nav-right {
                position: absolute;
                right: 25px;
                display: flex;
                align-items: center;
                gap: 12px;
            }
            .user-menu1 {
                display: flex;
                gap: 15px;
                align-items: center;
                justify-content: center;
                margin-right: -20px;
            }

            .user-menu1 a {
                text-decoration: none;
                color: #fff;
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                padding: 4px 10px;
                border-radius: 8px;
                font-weight: 500;
                font-size: 15px;
                transition: all 0.3s ease;
            }

            .user-menu1 a:hover {
                background: linear-gradient(135deg, #3b82f6, #2563eb);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(59,130,246,0.3);
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
            /* ==== PAGE TITLE ==== */
            .page-title {
                text-align: center;
                margin-top: 40px;
                margin-bottom: 10px;
            }

            .page-title h1 {
                font-size: 22px;
                font-weight: 700;
                color: #1f2937;
                letter-spacing: 1px;
                text-transform: uppercase;
                position: relative;
                display: inline-block;
            }

            .page-title h1::after {
                content: "";
                display: block;
                width: 60%;
                height: 3px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                margin: 8px auto 0;
                border-radius: 2px;
            }

            /* ==== CATEGORY HEADER ==== */
            .category-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin: 30px 60px 20px 60px;
            }

            .category-header select {
                padding: 10px 14px;
                border-radius: 8px;
                border: 1.5px solid #6c63ff;
                background: linear-gradient(135deg, #ffffff, #f4f4ff);
                font-size: 16px;
                font-weight: bold;
                color: #333;
                outline: none;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .category-header select:hover {
                border-color: #4b47e0;
                box-shadow: 0 0 8px rgba(108, 99, 255, 0.3);
            }

            .category-header h2 {
                font-size: 26px;
                color: #3f3f46;
                font-weight: 600;
            }

            /* ==== GALLERY ==== */
            .book-container {
                flex: 1;
                padding: 0 60px 40px 60px;
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
        <!-- ======= NAVIGATION ======= -->
        <nav>
            <div class="nav-center">
                <ul>
                    <li><a href="${pageContext.request.contextPath}/book/list">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/book/category">Category</a></li>
                    <li><a href="${pageContext.request.contextPath}/book/search">Search Book</a></li>
                </ul>
            </div>

            <div class="nav-right">
                <c:if test="${sessionScope.account == null}">
                    <div class="user-menu1">
                        <a href="${pageContext.request.contextPath}/user/login">Login</a>
                        <a href="${pageContext.request.contextPath}/user/register">Sign Up</a>
                    </div>                   
                </c:if>

                <c:if test="${sessionScope.account != null}">
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
                                <i class="fa-solid fa-user"></i> Dashboard
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
                </c:if>
            </div>
        </nav>

        <!-- ======= PAGE TITLE ======= -->
        <div class="page-title">
            <h1>Book Category</h1>
        </div>

        <!-- ======= CATEGORY HEADER ======= --> 
        <div class="category-header">
            <form action="category" method="post">
                <select name="category-select" onchange="this.form.submit()">
                    <option value="Action" ${selected eq 'Action' ? 'selected="selected"' : ''}>Action</option>
                    <option value="English" ${selected eq 'English' ? 'selected="selected"' : ''}>English</option>
                    <option value="Romance" ${selected eq 'Romance' ? 'selected="selected"' : ''}>Romance</option>
                    <option value="Soft Skill" ${selected eq 'Soft Skill' ? 'selected="selected"' : ''}>Soft-Skill</option>
                    <option value="Technology" ${selected eq 'Technology' ? 'selected="selected"' : ''}>Technology</option>
                </select>
            </form>
        </div>

        <!-- ======= MAIN GALLERY ======= -->
        <div class="book-container">
            <div class="book-gallery">
                <c:forEach var="book" items="${categorizeBook}">
                    <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="book-card">
                        <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Book cover">
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


        <script>
            const avatarBtn = document.getElementById('avatarBtn');
            const dropdown = document.getElementById('userDropdown');

            if (avatarBtn && dropdown) {
                avatarBtn.addEventListener('click', (e) => {
                    e.stopPropagation();
                    dropdown.classList.toggle('show');
                });

                document.addEventListener('click', (e) => {
                    if (!dropdown.contains(e.target) && e.target !== avatarBtn) {
                        dropdown.classList.remove('show');
                    }
                });
            }
        </script>
    </body>
</html>
