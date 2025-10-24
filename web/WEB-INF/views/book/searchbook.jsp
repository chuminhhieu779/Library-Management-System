<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Books - Library Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                padding: 15px 30px;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            nav ul {
                display: flex;
                list-style: none;
                gap: 20px;
            }

            nav a {
                text-decoration: none;
                color: #fff;
                font-weight: 500;
                transition: color 0.3s;
            }

            nav a:hover {
                color: #e0e7ff;
            }

            /* === LOGIN SIGNUP BUTTONS === */
            .auth-buttons {
                display: flex;
                gap: 15px;
            }

            .auth-buttons a {
                color: white;
                text-decoration: none;
                padding: 8px 16px;
                border-radius: 6px;
                transition: all 0.3s ease;
                font-weight: 500;
            }

            .auth-buttons a.login {
                background: linear-gradient(135deg, #4f46e5, #6d28d9);
            }

            .auth-buttons a.signup {
                background: transparent;
                border: 1.5px solid #6d28d9;
            }

            .auth-buttons a.login:hover {
                opacity: 0.9;
            }

            .auth-buttons a.signup:hover {
                background: #6d28d9;
                color: #fff;
            }

            /* ==== MAIN ==== */
            .search-container {
                flex: 1;
                padding: 40px 60px;
                text-align: center;
            }

            .search-container h2 {
                font-size: 28px;
                margin-bottom: 20px;
                color: #3f3f46;
            }

            .search-wrapper {
                max-width: 600px;
                margin: 0 auto 40px;
                position: relative;
            }

            .search-form {
                display: flex;
                gap: 10px;
                background: #fff;
                padding: 5px;
                border-radius: 50px;
                box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            }

            .search-input {
                flex: 1;
                border: none;
                outline: none;
                padding: 12px 20px;
                font-size: 14px;
                border-radius: 50px;
                color: #333;
                background: transparent;
            }

            .search-btn {
                background: linear-gradient(135deg, #4f46e5, #6d28d9);
                color: #fff;
                border: none;
                padding: 10px 20px;
                border-radius: 50px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                gap: 8px;
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

            .footer {
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 10px 5px;
            }

            @media (max-width: 768px) {
                nav {
                    flex-direction: column;
                    gap: 10px;
                }
            }
        </style>
    </head>

    <body>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/book/list">Book List</a></li>
                <li><a href="${pageContext.request.contextPath}/book/category">Category</a></li>
                <li><a href="${pageContext.request.contextPath}/book/search">Search Book</a></li>      
            </ul>

            <!-- Auth Buttons -->
            <div class="auth-buttons">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/LogOut" class="signup">Logout</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/login" class="login">Login</a>
                        <a href="${pageContext.request.contextPath}/user/register" class="signup">Sign up</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <div class="search-container">
            <h2>Search Books</h2>

            <div class="search-wrapper">
                <form action="${pageContext.request.contextPath}/book/search" method="get" class="search-form">
                    <input 
                        type="text" 
                        name="query" 
                        class="search-input" 
                        placeholder="Search by title, author, or category..."
                        value="${param.query}"
                        required>
                    <button type="submit" class="search-btn">
                        <i class="fas fa-search"></i>
                        Search
                    </button>
                </form>
            </div>

            <div class="book-container">        
                <div class="book-gallery">
                    <c:forEach var="book" items="${searchBook}">
                        <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="book-card" >                            
                            <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Book cover">
                        </a>
                    </c:forEach>
                </div>
            </div>
        </div>

        <footer class="footer">
            <%@include file="/WEB-INF/views/components/footer.jsp" %>
        </footer>
    </body>
</html>
