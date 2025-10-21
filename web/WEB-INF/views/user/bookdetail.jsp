<%-- 
    Document   : bookdetail
    Created on : Oct 17, 2025, 12:17:30 AM
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            eader{
                gap: 10px;
                background-color: #FCEBCC;

            }
            .header .content{
                margin-top: 10px;
                padding: 5px;
                width: 100%;
                display: flex;
                margin-left: 103px;
                align-items: center;
                gap: 10px;
            }
            .header .content ,img{
                width: 15%;
                margin-bottom: 10px;
                border-radius: 5px ;
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
            .detail-container {
                flex: 1;
            }

            .footer {
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 20px 20px;
                margin-top: auto;
            }
            /* ==== NAVIGATION ==== */
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
            .detail-container {
                max-width: 760px;
                margin: 24px auto;
                padding: 16px;
                margin-top: 50px;
            }
            .back-link {
                display: inline-block;
                margin: 0 0 16px;
                text-decoration: none;
                color: #2a6df4;
            }
            .detail-card {
                display: grid;
                grid-template-columns: 280px 1fr;
                gap: 24px;
                align-items: start;
                background: #fff;
                border: 1px solid #e6e6e6;
                border-radius: 10px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }
            .detail-cover {
                width: 100%;
                height: auto;
                border-radius: 8px;
                object-fit: cover;
            }
            .detail-meta {
                color: #222;
            }
            .detail-title {
                margin: 0 0 10px;
                font-size: 28px;
                line-height: 1.25;
            }
            .detail-rows {
                margin: 8px 0 0;
                padding: 0;
                list-style: none;
            }
            .detail-rows li {
                margin: 6px 0;
            }

            .detail-actions {
                margin-top: 16px;
                display: flex;
                gap: 10px;
            }
            .btn {
                appearance: none;
                border: 1px solid #d0d0d0;
                background: #f7f7f7;
                color: #222;
                padding: 8px 14px;
                border-radius: 6px;
                cursor: pointer;
            }
            .btn-primary {
                background: #2a6df4;
                color: #fff;
                border-color: #2a6df4;
            }

            .detail-description {
                margin-top: 14px;
            }
            .detail-description h2 {
                margin: 16px 0 8px;
                font-size: 20px;
            }
            .detail-description p {
                margin: 0;
                line-height: 1.6;
                color: #444;
            }

            @media (max-width: 680px) {
                .detail-card {
                    grid-template-columns: 1fr;
                }
            }
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

        <header class="header">
            <nav class="navbar">
                <span class="logo">📚 Library System</span>
            </nav>
        </header>


        <div class="detail-container">
            <a class="back-link" href="${pageContext.request.contextPath}/user/booklist">← Back to Library Books</a>

            <div class="detail-card">
                <img class="detail-cover" src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Physics Redefined">
                <div class="detail-meta">
                    <h1 class="detail-title">${book.title}</h1>
                    <ul class="detail-rows">
                        <li><strong>Author:</strong> ${book.author}</li>                        
                        <li><strong>Quantity:</strong> ${book.quantity}</li>
                        <li><strong>Category:</strong> ${book.category.name}</li>                  
                    </ul>
                    <div class="detail-description">
                        <h2>Description</h2>
                        <p>
                            ${book.description}
                        </p>
                    </div>
                    <div class="detail-actions">
                        <form action="${pageContext.request.contextPath}/user/favorite-book" method="get">
                            <input type="hidden" name="slug" value="${book.slug}">
                            <button class="btn btn-primary" type="button">Want to read</button>
                            <button class="btn" type="submit" name="bookID" value="${book.bookID}">Favorite</button>
                        </form>
                    </div>
                    <c:if test="${not empty success}">
                        <div style="margin-top:10px; color:green; font-weight:500;">${success}</div>
                        <c:remove var="success" scope="session" />
                    </c:if>
                    <c:if test="${not empty failed}">
                        <div style="margin-top:10px; color:red; font-weight:500;">${failed}</div>
                        <c:remove var="failed" scope="session"></c:remove>
                    </c:if>                 
                </div>
            </div>
        </div>
        <footer class="footer">
            <%@include file="/WEB-INF/views/components/footer.jsp" %>
        </footer>
    </body>
</html>
