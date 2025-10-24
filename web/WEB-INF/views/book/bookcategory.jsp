<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Gallery - Library Management</title>
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
            }

            /* Căn giữa các menu */
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

            /* Login / Sign Up góc phải */
            .nav-right {
                position: absolute;
                right: 60px;
                display: flex;
                align-items: center;
            }

            .nav-right a {
                margin-left: 15px;
                background-color: #4f46e5;
                color: white;
                padding: 8px 16px;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 500;
                transition: background-color 0.3s;
            }

            .nav-right a:hover {
                background-color: #6366f1;
            }

            /* ==== CATEGORY ==== */
            .category {
                position: absolute;
                top: 80px;
                left: 20px;
            }

            .category form select {
                padding: 10px 14px;
                border-radius: 8px;
                border: 1.5px solid #6c63ff;
                background: linear-gradient(135deg, #ffffff, #f4f4ff);
                font-size: 16px;
                font-weight: bold;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
                outline: none;
                transition: all 0.3s ease;
                cursor: pointer;
            }

            .category form select:hover {
                border-color: #4b47e0;
                box-shadow: 0 0 8px rgba(108, 99, 255, 0.3);
            }

            .category form select:focus {
                border-color: #3f3bd1;
                box-shadow: 0 0 10px rgba(63, 59, 209, 0.4);
                background: #fff;
            }

            .category form select option {
                background-color: #fff;
                color: #333;
            }

            /* ==== MAIN CONTENT ==== */
            .book-container {
                flex: 1;
                padding: 40px 60px;
                text-align: center;
            }

            .book-container h2 {
                font-size: 28px;
                margin-bottom: 30px;
                color: #3f3f46;
            }

            .book-container select {
                position: relative;
                display: inline-block;
                padding: 10px 14px;
                font-size: 16px;
                color: #333;
                border: 2px solid #667eea;
                border-radius: 8px;
                background: #f8faff;
                cursor: pointer;
                transition: all 0.2s ease;
                box-shadow: 0 3px 6px rgba(0,0,0,0.05);
                outline: none;
                margin-bottom: 25px;
            }

            .book-container select:hover,
            .book-container select:focus {
                border-color: #764ba2;
                box-shadow: 0 0 8px rgba(118,75,162,0.3);
            }

            .book-container option {
                padding: 10px;
                font-size: 15px;
                color: #333;
                background-color: #fff;
            }

            /* ==== GALLERY ==== */
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
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 10px 10px;
            }

            .footer-section h3 {
                margin-bottom: 10px;
                font-size: 15px;
                color: #a5b4fc;
            }

            .footer-section p {
                font-size: 14px;
                line-height: 1.6;
                max-width: 600px;
                margin: 0 auto 20px;
            }

        </style>
    </head>

    <body>
        <nav>
            <div class="nav-center">
                <ul>                
                    <li><a href="${pageContext.request.contextPath}/book/list">Book List</a></li>
                    <li><a href="${pageContext.request.contextPath}/book/category">Category</a></li>
                    <li><a href="${pageContext.request.contextPath}/book/search">Search Book</a></li>      
                </ul>
            </div>

            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/user/login">Login</a>
                <a href="${pageContext.request.contextPath}/user/register">Sign Up</a>
            </div>
        </nav>

        <div class="category">
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

        <div class="book-container">
            <h2>Book - Classification</h2>            

            <div class="book-gallery">
                <c:forEach var="book" items="${categorizeBook}">
                    <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="book-card">
                        <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Book cover">
                    </a>
                </c:forEach>
            </div>
        </div>

        <footer class="footer">
            <%@include file="/WEB-INF/views/components/footer.jsp" %>
        </footer>
    </body>
</html>
