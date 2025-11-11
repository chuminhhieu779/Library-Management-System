<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Borrowed Books - Library Management</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f9f9ff;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

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

            .book-container {
                flex: 1;
                padding: 40px 60px;
                text-align: center;
            }

            /* ✅ BACK LINK */
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

            /* ✅ PAGE TITLE WITH GRADIENT UNDERLINE */
            .page-title {
                text-align: center;
                margin-bottom: 25px;
            }

            .page-title h2 {
                font-size: 22px;
                font-weight: 700;
                color: #1f2937;
                letter-spacing: 1px;
                text-transform: uppercase;
                position: relative;
                display: inline-block;
            }

            .page-title h2::after {
                content: "";
                display: block;
                width: 60%;
                height: 3px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                margin: 8px auto 0;
                border-radius: 2px;
            }

            /* ==== BOOK GALLERY ==== */
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
                cursor: pointer;
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

            /* ==== POPUP DIALOG ==== */
            dialog {
                border: none;
                border-radius: 12px;
                padding: 25px 30px;
                width: 380px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
                text-align: center;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: #fff;
            }

            dialog::backdrop {
                background: rgba(0, 0, 0, 0.6);
            }

            dialog h3 {
                color: #333;
                margin-bottom: 15px;
                font-weight: 700;
            }

            dialog p {
                margin: 8px 0;
                color: #555;
            }

            .btn-group {
                margin-top: 20px;
                display: flex;
                justify-content: center;
                gap: 15px;
            }

            .btn {
                padding: 10px 18px;
                border: none;
                border-radius: 6px;
                font-weight: 600;
                cursor: pointer;
                color: white;
                text-decoration: none;
            }

            .btn.return {
                background: #ef4444;
            }

            .btn.extend {
                background: #2563eb;
            }

            .close-btn {
                position: absolute;
                top: 10px;
                right: 15px;
                font-size: 24px;
                color: #888;
                background: none;
                border: none;
                cursor: pointer;
            }

            .extend-box {
                display: none;
                margin-top: 15px;
                background: #f3f4f6;
                padding: 15px;
                border-radius: 8px;
            }

            .extend-box input {
                width: 70%;
                padding: 6px;
                border-radius: 6px;
                border: 1px solid #ccc;
                margin: 10px 0;
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

            /* ✅ TOAST NOTIFICATION */
            .toast {
                position: fixed;
                top: 20%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0.9);
                background: rgb(19, 24, 39);
                color: #fff;
                padding: 16px 28px;
                border-radius: 12px;
                font-weight: 600;
                font-size: 16px;
                text-align: center;
                box-shadow: 0 8px 20px rgba(0,0,0,0.25);
                opacity: 0;
                transition: all 0.4s ease;
                z-index: 9999;
            }

            .toast.show {
                opacity: 1;
                transform: translate(-50%, -50%) scale(1);
            }
        </style>
    </head>

    <body>
        <nav class="navbar">
            <span class="logo">📚 Library System</span>
        </nav>

        <div class="book-container">
            <div class="page-title">
                <h2>Borrowed Books</h2>
            </div>

            <a class="back-link" href="${pageContext.request.contextPath}/user/dashboard">← Back to Dashboard</a>

            <div class="book-gallery">
                <c:forEach var="book" items="${borrowedBooks}" varStatus="loop">
                    <div class="book-card" onclick="document.getElementById('popup${loop.index}').showModal()">
                        <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Book cover">
                    </div>

                    <!-- Popup dialog -->
                    <dialog id="popup${loop.index}" 
                            ${(targetBookID == book.bookID) || (param.bookID == (book.bookID).toString()) ? "open" : ""}>
                        <button class="close-btn" onclick="this.closest('dialog').close()">&times;</button>
                        <h3>Borrowing Information</h3>

                        <!-- ✅ Extend success -->
                        <c:if test="${not empty sessionScope.extendSuccess && (param.bookID == (book.bookID).toString())}">
                            <p style="background:#ecfdf5;color:#065f46;border:1px solid #10b981;
                               padding:10px;border-radius:8px;font-weight:600;margin-bottom:10px;
                               display:flex;align-items:center;justify-content:center;gap:6px;">
                                <span style="font-size:18px;">✅</span>
                                ${sessionScope.extendSuccess}
                            </p>
                            <c:remove var="extendSuccess" scope="session" />
                        </c:if>

                        <p><strong>Borrow Date:</strong> ${book.borrowDate}</p>
                        <p><strong>Due Date:</strong> ${book.dueDate}</p>

                        <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/borrowing/return?slug=${book.slug}" class="btn return">Return Book</a>
                            <button class="btn extend" onclick="document.getElementById('extendBox${loop.index}').style.display = 'block'">Extend</button>
                        </div>

                        <!-- Extend form -->
                        <div id="extendBox${loop.index}" 
                             class="extend-box"
                             style="${not empty error && targetBookID == book.bookID ? 'display:block;' : 'display:none;'}">

                            <c:if test="${not empty error && targetBookID == book.bookID}">
                                <p style="color: #ef4444; font-weight: 600; margin-bottom: 8px;">
                                    ⚠ ${error}
                                </p>
                                <c:remove var="errorr" scope="session" />
                            </c:if>
                                                                                

                            <form action="${pageContext.request.contextPath}/borrowing/extend" method="post">
                                <label>Choose new due date:</label><br>
                                <input type="date" name="newDueDate" min="${book.borrowDate}" required>
                                <input type="hidden" name="bookID" value="${book.bookID}">
                                <div class="btn-group">
                                    <button type="submit" class="btn extend">Confirm</button>
                                    <button type="button" class="btn return"
                                            onclick="this.closest('.extend-box').style.display = 'none'">Cancel</button>
                                </div>
                            </form>
                        </div>
                    </dialog>
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

        <!-- ✅ Return success toast -->
        <c:if test="${not empty sessionScope.returnSuccess}">
            <div id="returnToast" class="toast">
                ✅ ${sessionScope.returnSuccess}
            </div>
            <c:remove var="returnSuccess" scope="session" />
            <script>
                const toast = document.getElementById('returnToast');
                setTimeout(() => toast.classList.add('show'), 100);
                setTimeout(() => toast.classList.remove('show'), 4000);
            </script>
        </c:if>
    </body>
</html>
