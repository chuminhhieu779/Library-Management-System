<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User Borrowing Records - Library Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }
            html, body {
                height: 100%;
            }
            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background: #f4f6f8;
                color: #333;
            }

            header {
                background: rgba(17, 24, 39, 0.95);
                border-bottom: 2px solid #4f46e5;
                padding: 12px 60px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .logo-section {
                display: flex;
                align-items: center;
            }
            .logo-section img {
                height: 42px;
                width: 42px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 10px;
                border: 2px solid #6366f1;
            }
            .logo-section h3 {
                color: #e5e7eb;
                font-weight: 700;
            }
            nav ul {
                list-style: none;
                display: flex;
                gap: 30px;
            }
            nav ul li a {
                color: #fff;
                text-decoration: none;
                transition: 0.3s;
            }
            nav ul li a:hover {
                color: #a5b4fc;
            }

            main {
                flex: 1 0 auto;
                padding: 40px 60px;
            }
            .page-title {
                text-align: center;
                margin-bottom: 40px;
            }
            .page-title h2 {
                font-size: 22px;
                font-weight: 700;
                color: #1f2937;
                text-transform: uppercase;
                letter-spacing: 1px;
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

            .table-container {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
                overflow: hidden;
            }
            .users-table {
                width: 100%;
                border-collapse: collapse;
            }
            .users-table thead {
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                color: #fff;
            }
            .users-table th, .users-table td {
                padding: 14px 16px;
                text-align: left;
                font-size: 14px;
            }

            /* fix spacing cột status */
            .users-table td:last-child {
                width: 120px;
                text-align: center;
                padding-right: 20px;
            }

            .user-info {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .book-title {
                font-weight: 500;
                font-size: 15px;
                color: #4338ca;
            }

            /* badge status */
            .status-badge {
                padding: 3px 10px;
                border-radius: 12px;
                font-size: 13px;
                font-weight: 600;
                display: inline-block;
                text-transform: lowercase;
            }
            .status-active {
                background: #dcfce7;
                color: #166534;
            }
            .status-inactive {
                background: #fee2e2;
                color: #991b1b;
            }

            /* CSS for approve button */
            .approve-btn {
                background: linear-gradient(135deg, #22c55e, #16a34a);
                border: none;
                color: white;
                padding: 8px 16px;
                border-radius: 8px;
                cursor: pointer;
                font-size: 13px;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                gap: 6px;
                transition: all 0.3s ease;
                box-shadow: 0 2px 8px rgba(34, 197, 94, 0.3);
            }

            .approve-btn:hover {
                background: linear-gradient(135deg, #16a34a, #15803d);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(34, 197, 94, 0.4);
            }

            .approve-btn:active {
                transform: translateY(0);
                box-shadow: 0 2px 6px rgba(34, 197, 94, 0.3);
            }

            .footer {
                background: linear-gradient(135deg, #111827, #1f2937);
                color: #d1d5db;
                text-align: center;
                padding: 15px 20px;
                font-size: 14px;
                border-top: 2px solid #4f46e5;
                margin-top: auto;
            }

            @media (max-width:768px){
                main{
                    padding:20px;
                }
                .users-table{
                    min-width:800px;
                }
            }
        </style>
    </head>
    <body>
        <header>
            <div class="logo-section">
                <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="Logo">
                <h3>Library Management System</h3>
            </div>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/books">Manage Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/user-manager">Manage Users</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="page-title"><h2>User Borrowing Records</h2></div>

            <div class="table-container">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>User Info</th>
                            <th>Borrowed Books</th>
                            <th>Status</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="user" items="${userList}">
                            <tr>
                                <td>#${user.userID}</td>
                                <td>
                                    <div class="user-info">
                                        <div class="user-details">
                                            <h4>${user.fullName}</h4>
                                        </div>
                                    </div>
                                </td>
                                <td class="book-title">
                                    ${user.borrowedBook != null ? user.borrowedBook : '0'} books
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status.name() eq 'PENDING'}">
                                            <span class="status-badge" style="background:#fef3c7; color:#92400e;">Pending</span>
                                        </c:when>
                                        <c:when test="${user.status.name() eq 'BORROWING'}">
                                            <span class="status-badge status-active">${user.status.value}</span>
                                        </c:when>
                                        <c:when test="${user.status.name() eq 'RETURNED'}">
                                            <span class="status-badge status-inactive">${user.status.value}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Unknown</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>

                                <td style="text-align:center;">
                                    <c:if test="${user.status.name() eq 'PENDING'}">
                                        <form action="${pageContext.request.contextPath}/admin/approveBorrow" method="post" style="display:inline;">
                                            <input type="hidden" name="borrowId" value="${user.borrowingID}">
                                            <input type="hidden" name="bookID" value="${user.bookID}">
                                            <button type="submit" class="approve-btn">
                                                <i class="fa-solid fa-check"></i> Approve
                                            </button>
                                        </form>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>                    
                </table>
            </div>
        </main>
        <footer class="footer">
            <p>&copy; 2025 Library Management System — All rights reserved.</p>
        </footer>
        <!-- Toast thông báo -->
        <div id="toast"
             style="position: fixed; bottom: 30px; right: 30px; background: #22c55e;
             color: white; padding: 12px 20px; border-radius: 8px;
             box-shadow: 0 2px 10px rgba(0,0,0,0.25); font-size: 14px;
             font-weight: 500; opacity: 0; transform: translateY(20px);
             transition: all 0.4s ease; z-index: 9999;">
        </div>
        <script>
            function showToast(message, type = 'success') {
                const toast = document.getElementById('toast');
                if (!toast)
                    return;

                // Màu theo loại
                if (type === 'error') {
                    toast.style.background = '#ef4444'; // đỏ
                } else if (type === 'warning') {
                    toast.style.background = '#f59e0b'; // vàng
                } else {
                    toast.style.background = '#22c55e'; // xanh
                }

                toast.textContent = message;
                toast.style.opacity = '1';
                toast.style.transform = 'translateY(0)';

                // Ẩn sau 3 giây
                setTimeout(() => {
                    toast.style.opacity = '0';
                    toast.style.transform = 'translateY(20px)';
                }, 3000);
            }

            // ✅ Gọi hàm showToast khi có param trên URL
            <c:if test="${param.success eq 'approved'}">
            showToast("✅ Borrow request approved successfully!", "success");
            </c:if>
            <c:if test="${param.error eq 'failed'}">
            showToast("❌ Failed to approve borrow request.", "error");
            </c:if>
        </script>


    </body>
</html>