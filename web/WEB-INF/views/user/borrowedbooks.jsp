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
                background: #f9f9ff;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
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

            /* ==== BOOK LIST ==== */
            .book-container {
                flex: 1;
                padding: 40px 60px;
                text-align: center;
            }
            .back-link {
                display: flex;
                margin: 0 0 16px;
                text-decoration: none;
                color: #2a6df4;
            }
            .book-container h2 {
                font-size: 28px;
                margin-bottom: 30px;
                color: #3f3f46;
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

            /* ==== POPUP (DIALOG) ==== */
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
            }

            dialog::backdrop {
                background: rgba(0, 0, 0, 0.6);
            }

            dialog h3 {
                color: #333;
                margin-bottom: 15px;
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

            .toast {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: linear-gradient(135deg, #16a34a, #22c55e);
                color: #ffffff;
                font-size: 18px;
                font-weight: 700;
                text-align: center;
                padding: 20px 40px;
                border-radius: 12px;
                box-shadow: 0 8px 25px rgba(0, 0, 0, 0.3);
                opacity: 0;
                transition: opacity 0.4s ease, transform 0.4s ease;
                z-index: 9999;
            }

            .toast.show {
                opacity: 1;
                transform: translate(-50%, -50%) scale(1.05);
            }




            /* ==== FOOTER ==== */
            .footer {
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 20px 20px;
            }
        </style>
    </head>

    <body>
        <nav class="navbar">
            <span class="logo">📚 Library System</span>
        </nav>

        <div class="book-container">
            <h2>Book List</h2>
            <a class="back-link" href="${pageContext.request.contextPath}/user/dashboard">← Back to DashBoard </a>
            <div class="book-gallery">
                <c:forEach var="book" items="${borrowedBooks}" varStatus="loop">
                    <div class="book-card" onclick="document.getElementById('popup${loop.index}').showModal()">
                        <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Book cover">
                    </div>

                    <!-- Popup dialog -->
                    <dialog id="popup${loop.index}">
                        <button class="close-btn" onclick="this.closest('dialog').close()">&times;</button>
                        <h3>Borrowing Information</h3>
                        <p><strong>Borrow Date:</strong> ${book.borrowDate}</p>
                        <p><strong>Due Date:</strong> ${book.dueDate}</p>

                        <div class="btn-group">
                            <a href="${pageContext.request.contextPath}/user/return-books?name=${book.slug}" class="btn return">Return Book</a>
                            <a href="#" class="btn extend">Extend</a>
                        </div>
                    </dialog>
                </c:forEach>
            </div>
        </div>

        <!-- ✅ Toast Notification -->
        <c:if test="${sessionScope.commitReturnBook}">
            <div id="toast" class="toast">📗 Book returned successfully!</div>
            <script>
                window.onload = () => {
                    const toast = document.getElementById("toast");
                    toast.classList.add("show");
                    setTimeout(() => toast.classList.remove("show"), 3000);
                };
            </script>

            <c:remove var="commitReturnBook" scope="session"/>
        </c:if>



        <footer class="footer">
            <%@include file="/WEB-INF/views/components/footer.jsp" %>
        </footer>
    </body>
</html>
