<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Users - Library Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; }
            html, body { height: 100%; }
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
            .logo-section { display: flex; align-items: center; }
            .logo-section img { height: 42px; width: 42px; border-radius: 50%; object-fit: cover; margin-right: 10px; border: 2px solid #6366f1; }
            .logo-section h3 { color: #e5e7eb; font-weight: 700; }
            nav ul { list-style: none; display: flex; gap: 30px; }
            nav ul li a { color: #fff; text-decoration: none; transition: 0.3s; }
            nav ul li a:hover { color: #a5b4fc; }

            main { flex: 1 0 auto; padding: 40px 60px; }
            .page-title { text-align: center; margin-bottom: 40px; }
            .page-title h2 {
                font-size: 22px; font-weight: 700; color: #1f2937;
                text-transform: uppercase; letter-spacing: 1px;
                position: relative; display: inline-block;
            }
            .page-title h2::after {
                content: ""; display: block; width: 60%; height: 3px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                margin: 8px auto 0; border-radius: 2px;
            }

            .toolbar {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 25px;
                gap: 15px;
                flex-wrap: wrap;
            }
            .search-box {
                display: flex;
                gap: 10px;
                flex: 1;
                max-width: 500px;
            }
            .search-input {
                flex: 1;
                padding: 12px 16px;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s;
            }
            .search-input:focus {
                outline: none;
                border-color: #4f46e5;
                box-shadow: 0 0 0 3px rgba(79,70,229,0.1);
            }
            .btn {
                padding: 12px 20px;
                border: none;
                border-radius: 8px;
                font-size: 14px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                text-decoration: none;
            }
            .btn-primary { background: linear-gradient(135deg, #4f46e5, #3b82f6); color: #fff; }
            .btn-success { background: linear-gradient(135deg, #22c55e, #16a34a); color: #fff; }

            .table-container {
                background: #fff;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
                overflow: hidden;
            }
            .users-table { width: 100%; border-collapse: collapse; }
            .users-table thead { background: linear-gradient(135deg, #4f46e5, #3b82f6); color: #fff; }
            .users-table th, .users-table td { padding: 14px 16px; text-align: left; font-size: 14px; }

            /* fix spacing cột status */
            .users-table td:last-child {
                width: 120px;
                text-align: center;
                padding-right: 20px;
            }

            .user-info { display: flex; align-items: center; gap: 12px; }

            /* title sách */
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
            .status-active { background: #dcfce7; color: #166534; }
            .status-inactive { background: #fee2e2; color: #991b1b; }

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
                main{ padding:20px; }
                .users-table{ min-width:800px; }
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
                    <li><a href="${pageContext.request.contextPath}/admin/borrowing">Borrowing Records</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <div class="page-title"><h2>Manage Users</h2></div>

            <div class="toolbar">
                <div class="search-box">
                    <input type="text" class="search-input" placeholder="Search users..." id="searchInput">
                    <button class="btn btn-primary" onclick="searchUsers()">
                        <i class="fa-solid fa-search"></i> Search
                    </button>
                </div>
                <button class="btn btn-success" onclick="openAddModal()">
                    <i class="fa-solid fa-user-plus"></i> Add New User
                </button>
            </div>

            <div class="table-container">
                <table class="users-table">
                    <thead>
                        <tr>
                            <th>User ID</th>
                            <th>User Info</th>
                            <th>Borrowed Books</th>
                            <th>Status</th>
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
                                        <c:when test="${user.status.name() == 'BORROWING'}">
                                            <span class="status-badge status-active">${user.status.name}</span>
                                        </c:when>
                                        <c:when test="${user.status.name() == 'RETURNED'}">
                                            <span class="status-badge status-inactive">${user.status.name}</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">Unknown</span>
                                        </c:otherwise>
                                    </c:choose>
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

        <script>
            function openAddModal() {}
            function searchUsers() {
                const val = document.getElementById('searchInput').value;
                window.location.href = '${pageContext.request.contextPath}/admin/users?search=' + val;
            }
        </script>
    </body>
</html>
