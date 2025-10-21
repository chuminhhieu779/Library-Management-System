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

            /* ==== OPTION ==== */
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
            <ul>
                
                <li><a href="${pageContext.request.contextPath}/user/dashboard"> DashBoard</a></li>
                <li><a href="${pageContext.request.contextPath}/user/book-category">Category</a></li>
                <li><a href="${pageContext.request.contextPath}/user/search-books"> Search Book </a></li>
                <li><a href="/HomePage/Contact.html">Account</a></li>
           
            </ul>
        </nav>
      

        <div class="book-container">
            <h2>Book List</h2>            

            <div class="book-gallery">
                <c:forEach var="book" items="${bookList}">
                    <a href="${pageContext.request.contextPath}/user/bookdetail?name=${book.slug}" class="book-card" >
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
