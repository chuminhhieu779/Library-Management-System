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

            /* Toàn trang */
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


            /* ==== MAIN CONTENT ==== */
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

            /* ==== SEARCH BOX ==== */
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
                transition: box-shadow 0.3s ease;
            }

            .search-form:focus-within {
                box-shadow: 0 6px 20px rgba(79, 70, 229, 0.25);
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

            .search-input::placeholder {
                color: #9ca3af;
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

            .search-btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(79, 70, 229, 0.4);
            }

            .search-btn:active {
                transform: translateY(0);
            }



            /* ==== RESULTS INFO ==== */
            .results-info {
                margin-bottom: 25px;
                color: #6b7280;
                font-size: 15px;
            }

            .results-info strong {
                color: #4f46e5;
                font-weight: 600;
            }

            /* ==== NO RESULTS ==== */
            .no-results {
                text-align: center;
                padding: 60px 20px;
            }

            .no-results i {
                font-size: 80px;
                color: #d1d5db;
                margin-bottom: 20px;
            }

            .no-results h3 {
                font-size: 24px;
                color: #6b7280;
                margin-bottom: 10px;
            }

            .no-results p {
                color: #9ca3af;
                font-size: 16px;
            }

            /* ==== BOOK GALLERY ==== */
            .book-container option {
                padding: 10px;
                font-size: 15px;
                color: #333;
                background-color: #fff;
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
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 10px 5px;
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

            /* ==== RESPONSIVE ==== */
            @media (max-width: 768px) {
                .search-container {
                    padding: 30px 20px;
                }

                .search-form {
                    flex-direction: column;
                    border-radius: 15px;
                }

                .search-btn {
                    justify-content: center;
                    border-radius: 10px;
                }

                .book-gallery {
                    grid-template-columns: repeat(auto-fill, minmax(140px, 1fr));
                    gap: 20px;
                }
            }
        </style>
    </head>

    <body>
        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/user/dashboard">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/user/booklist"> Book List </a></li>
                <li><a href="${pageContext.request.contextPath}/user/book-category">Category</a></li>      
            </ul>
        </nav>

        <div class="search-container">
            <h2>Search Books</h2>

            <!-- Search Form -->
            <div class="search-wrapper">
                <form action="${pageContext.request.contextPath}/user/search-books" method="get" class="search-form">
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

            <!-- Book Gallery -->
            <div class="book-container">        
                <div class="book-gallery">
                    <c:forEach var="book" items="${searchBook}">
                        <a href="${pageContext.request.contextPath}/user/bookdetail?slug=${book.slug}&bookID=${book.bookID}" class="book-card" >                            
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