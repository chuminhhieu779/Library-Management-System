<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Online Users - Library Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <style>
            /* ==== RESET ==== */
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

            /* ==== HEADER + NAV ==== */
            header {
                background: rgba(17, 24, 39, 0.95);
                border-bottom: 2px solid #4f46e5;
                padding: 12px 60px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                flex-shrink: 0;
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
                font-size: 1.3em;
                font-weight: 700;
                color: #e5e7eb;
            }

            nav ul {
                list-style: none;
                display: flex;
                gap: 30px;
            }

            nav ul li a {
                color: #fff;
                text-decoration: none;
                font-weight: 500;
                font-size: 16px;
                transition: color 0.3s;
            }

            nav ul li a:hover {
                color: #a5b4fc;
            }

            /* ==== ADMIN MENU ==== */
            .admin-menu {
                position: relative;
                display: inline-block;
            }

            .admin-menu::after {
                content: "";
                position: absolute;
                top: 38px;
                right: 0;
                width: 100%;
                height: 20px;
            }

            .admin-avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                object-fit: cover;
                cursor: pointer;
                border: 2px solid #a5b4fc;
                transition: transform 0.2s ease;
            }

            .admin-avatar:hover {
                transform: scale(1.05);
            }

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

            .admin-menu:hover .dropdown {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .dropdown .admin-info {
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

            .admin-name {
                font-weight: 600;
                font-size: 16px;
                margin: 2px 0;
            }

            .admin-role {
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

            /* ==== MAIN CONTENT ==== */
            main {
                flex: 1 0 auto;
                padding: 40px 60px;
            }

            .avatar-img {
                width: 64px;
                height: 64px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #e5e7eb;
                background-color: #fff;
                box-shadow: 0 4px 12px rgba(0,0,0,0.12);
                transition: all 0.3s ease;
                display: inline-block;
            }

            .avatar-img:hover {
                transform: scale(1.12);
                border-color: #6366f1;
                box-shadow: 0 6px 20px rgba(99, 102, 241, 0.3);
            }

            /* ==== PAGE TITLE ==== */
            .page-title {
                text-align: center;
                margin-bottom: 40px;
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

            /* ==== TOOLBAR ==== */
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
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
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

            .btn-primary {
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                color: #fff;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #3b82f6, #2563eb);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
            }

            .btn-success {
                background: linear-gradient(135deg, #22c55e, #16a34a);
                color: #fff;
            }

            .btn-success:hover {
                background: linear-gradient(135deg, #16a34a, #15803d);
                transform: translateY(-2px);
            }

            .btn-sm {
                padding: 8px 14px;
                font-size: 12px;
                font-weight: 500;
                border-radius: 6px;
                gap: 6px;
            }

            .btn-danger {
                background: linear-gradient(135deg, #ef4444, #dc2626);
                color: #fff;
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #dc2626, #b91c1c);
                transform: translateY(-1px);
                box-shadow: 0 3px 8px rgba(239, 68, 68, 0.3);
            }

            .btn-warning {
                background: linear-gradient(135deg, #f59e0b, #d97706);
                color: #fff;
            }

            .btn-warning:hover {
                background: linear-gradient(135deg, #d97706, #b45309);
                transform: translateY(-1px);
                box-shadow: 0 3px 8px rgba(245, 158, 11, 0.3);
            }

            /* ==== ALERTS ==== */
            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .alert-success {
                background: #ecfdf5;
                color: #065f46;
                border: 1px solid #10b981;
            }

            .alert-danger {
                background: #fef2f2;
                color: #991b1b;
                border: 1px solid #ef4444;
            }

            /* ==== BOOKS TABLE ==== */
            .table-container {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                overflow: hidden;
                padding: 0;
                border: 1px solid #e5e7eb;
            }

            .books-table {
                width: 100%;
                border-collapse: collapse;
                margin: 0;
            }

            .books-table thead {
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                color: #fff;
            }

            .books-table th {
                padding: 18px 20px;
                text-align: left;
                font-weight: 700;
                font-size: 13px;
                text-transform: uppercase;
                letter-spacing: 1px;
                white-space: nowrap;
            }

            .books-table th:first-child {
                text-align: center;
                width: 100px;
            }

            .books-table th:nth-child(2) {
                width: 25%;
            }

            .books-table th:nth-child(3) {
                width: 25%;
            }

            .books-table th:nth-child(4) {
                text-align: center;
                width: 140px;
            }

            .books-table th:last-child {
                text-align: center;
                width: 260px;
            }

            .books-table td {
                padding: 18px 20px;
                border-bottom: 1px solid #f3f4f6;
                font-size: 14px;
                color: #374151;
                vertical-align: middle;
            }

            .books-table td:first-child {
                text-align: center;
                padding: 12px;
            }

            .books-table td:nth-child(4) {
                text-align: center;
            }

            .books-table td:last-child {
                text-align: center;
            }

            .books-table tbody tr {
                transition: all 0.3s ease;
            }

            .books-table tbody tr:hover {
                background: linear-gradient(to right, #f9fafb, #f3f4f6);
                transform: scale(1.01);
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            }

            .books-table tbody tr:last-child td {
                border-bottom: none;
            }

            .status-badge {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                font-size: 10px;
                font-weight: 700;
                padding: 8px 16px;
                border-radius: 24px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                transition: all 0.3s ease;
            }

            .status-active {
                background: linear-gradient(135deg, #ecfdf5, #d1fae5);
                color: #065f46;
                border: 2px solid #10b981;
            }

            .status-active:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
            }

            .status-inactive {
                background: linear-gradient(135deg, #fef2f2, #fee2e2);
                color: #991b1b;
                border: 2px solid #ef4444;
            }

            .status-inactive:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
            }

            .actions {
                display: flex;
                gap: 12px;
                align-items: center;
                justify-content: center;
            }

            .actions .btn-sm {
                min-width: 90px;
                justify-content: center;
                font-weight: 600;
                box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            }

            .actions .btn-sm:hover {
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            /* ==== MODAL ==== */
            .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6);
                z-index: 1000;
                justify-content: center;
                align-items: center;
            }

            .modal.show {
                display: flex;
            }

            .modal-content {
                background: #fff;
                border-radius: 12px;
                padding: 30px;
                max-width: 500px;
                width: 90%;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                max-height: 90vh;
                overflow-y: auto;
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }

            .modal-header h3 {
                font-size: 20px;
                color: #1f2937;
            }

            .close-btn {
                background: none;
                border: none;
                font-size: 24px;
                color: #6b7280;
                cursor: pointer;
                transition: color 0.2s;
            }

            .close-btn:hover {
                color: #ef4444;
            }

            .form-group {
                margin-bottom: 18px;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #374151;
                margin-bottom: 6px;
                font-size: 14px;
            }

            .form-control {
                width: 100%;
                padding: 10px 12px;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                font-size: 14px;
                transition: all 0.3s;
            }

            .form-control:focus {
                outline: none;
                border-color: #4f46e5;
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 20px;
            }

            /* ==== FOOTER ==== */
            .footer {
                background: linear-gradient(135deg, #111827, #1f2937);
                color: #d1d5db;
                text-align: center;
                padding: 15px 20px;
                font-size: 14px;
                border-top: 2px solid #4f46e5;
                flex-shrink: 0;
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

            /* ==== RESPONSIVE ==== */
            @media (max-width: 768px) {
                header {
                    padding: 12px 20px;
                }

                main {
                    padding: 20px;
                }

                .toolbar {
                    flex-direction: column;
                }

                .search-box {
                    max-width: 100%;
                }

                .table-container {
                    overflow-x: auto;
                }

                .books-table {
                    min-width: 900px;
                }
            }

            .notice-center {
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: rgba(17, 24, 39, 0.95);
                color: #fff;
                padding: 15px 20px;
                border-radius: 12px;
                font-size: 16px;
                font-weight: 600;
                box-shadow: 0 6px 25px rgba(0, 0, 0, 0.25);
                display: flex;
                align-items: center;
                gap: 10px;
                z-index: 9999;
                opacity: 0;
                animation: fadeInOut 3s ease forwards;
            }

            .notice-center i {
                font-size: 20px;
            }



            .notice-error {
                background: rgba(17, 24, 39, 0.95);

            }


            @keyframes fadeInOut {
                0% {
                    opacity: 0;
                    transform: translate(-50%, -60%);
                }
                10%, 85% {
                    opacity: 1;
                    transform: translate(-50%, -50%);
                }
                100% {
                    opacity: 0;
                    transform: translate(-50%, -40%);
                }
            }

        </style>
    </head>
    <body>
        <!-- ==== HEADER + NAV ==== -->
        <header>
            <div class="logo-section">
                <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="Logo">
                <h3>Library Management System</h3>
            </div>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/books">Manage Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/users">Manage Users</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/borrowing">Borrowing Records</a></li>
                </ul>
            </nav>

            <div class="admin-menu">
                <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" 
                     alt="Admin Avatar" class="admin-avatar">
                <div class="dropdown">
                    <div class="admin-info">
                        <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" 
                             alt="Admin Avatar" class="avatar-large">
                        <p class="admin-name">${sessionScope.admin.username}</p>
                        <p class="admin-role">Administrator</p>
                    </div>
                    <hr>
                    <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item">
                        <i class="fa-solid fa-user"></i> Profile
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/settings" class="dropdown-item">
                        <i class="fa-solid fa-gear"></i> Settings
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="dropdown-item logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </div>
            </div>
        </header>

        <!-- ==== MAIN CONTENT ==== -->
        <main>
            <div class="page-title">
                <h2>Manage Online Users</h2>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="">
                <div class="alert alert-success">
                    <i class="fa-solid fa-check-circle"></i>
                </div>
            </c:if>
            <c:if test="">
                <div class="alert alert-danger">
                    <i class="fa-solid fa-exclamation-circle"></i>

                </div>
            </c:if>

            <!-- Toolbar -->
            <div class="toolbar">
                <div class="search-box">
                    <input type="text" class="search-input" placeholder="Search users by name or account..." id="searchInput">
                    <button class="btn btn-primary" onclick="searchUsers()">
                        <i class="fa-solid fa-search"></i> Search
                    </button>
                </div>            
                <button class="btn btn-danger" onclick="logoutAllUsers()">
                    <i class="fa-solid fa-door-open"></i> Logout All Users
                </button>
            </div>

            <!-- Users Table -->
            <div class="table-container">
                <table class="books-table">
                    <thead>
                        <tr>
                            <th>Avatar</th>
                            <th>Username</th>
                            <th>Account</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty notice}">
                        <div id="notice" class="notice-center notice-success">
                            <i></i> ${notice}
                        </div>
                        <c:remove var="notice" scope="session" />
                    </c:if>
                    
                    <c:if test="${not empty tmp}">
                        <div id="notice" class="notice-center notice-success">
                            <i></i> ${tmp}
                        </div>
                        <c:remove var="tmp" scope="session" />
                    </c:if>



                    <c:if test="${not empty list}">
                        <c:forEach var="user" items="${list}">
                            <tr>
                                <td>
                                    <img src="${pageContext.request.contextPath}/resources/images/${user.avatar}" alt="avatar" class="avatar-img">
                                </td>

                                <td>${user.fullName}</td>
                                <td>${user.account}</td>                   
                                <td>
                                    <c:choose>
                                        <c:when test="${user.status.value == 'active'}">
                                            <span class="status-badge status-active">
                                                <i class="fa-solid fa-circle-check"></i> Active
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-inactive">
                                                <i class="fa-solid fa-circle-xmark"></i> Inactive
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <div class="actions">
                                        <button class="btn btn-warning btn-sm" onclick="logoutUser('${user.account}')">
                                            <i class="fa-solid fa-right-from-bracket"></i> Logout 
                                        </button>
                                        <button class="btn btn-danger btn-sm" onclick="deleteUser('${user.account}')">
                                            <i class="fa-solid fa-trash"></i> Delete
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>

        </main>

        <!-- ===== Modal Add User ===== -->
        <div class="modal" id="addUserModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3>Add New User</h3>
                    <button class="close-btn" onclick="closeAddUserModal()">&times;</button>
                </div>

                <form action="${pageContext.request.contextPath}/admin/users/add" method="post" enctype="multipart/form-data">
                    <div class="form-group">
                        <label>Full Name</label>
                        <input type="text" class="form-control" name="fullname" required>
                    </div>

                    <div class="form-group">
                        <label>Account</label>
                        <input type="text" class="form-control" name="account" required>
                    </div>

                    <div class="form-group">
                        <label>Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>

                    <div class="form-group">
                        <label>Avatar</label>
                        <input type="file" class="form-control" name="avatar" accept="image/*">
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" onclick="closeAddUserModal()">Cancel</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fa-solid fa-save"></i> Save User
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <footer class="footer">
            <div class="footer-content">
                <a href="#">Privacy Policy</a>
                <a href="#">Terms of Service</a>
                <a href="#">Contact</a>
            </div>
            <p>&copy; 2025 Library Management System. All rights reserved.</p>
        </footer>
        <script>
            function logoutUser(account) {
                if (confirm('Are you sure you want to log out this user?')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/user/logout?account=' + account;
                }
            }

            function deleteUser(account) {
                if (confirm('Are you sure you want to delete this user?')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/user/delete?account=' + account;
                }
            }

            function logoutAllUsers() {
                if (confirm('Logout all users from the system?')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/users/logout-all';
                }
            }

            function searchUsers() {
                const val = document.getElementById('searchInput').value.trim();
                window.location.href = '${pageContext.request.contextPath}/admin/users?search=' + encodeURIComponent(val);
            }

            function openAddUserModal() {
                document.getElementById('addUserModal').classList.add('show');
            }

            function closeAddUserModal() {
                document.getElementById('addUserModal').classList.remove('show');
            }

            window.onclick = function (event) {
                const modal = document.getElementById('addUserModal');
                if (event.target === modal) {
                    closeAddUserModal();
                }
            };
            // Nếu có thẻ notice, sau 5 giây thì ẩn
            window.addEventListener('DOMContentLoaded', () => {
                const notice = document.getElementById('notice');
                if (notice) {
                    setTimeout(() => {
                        notice.style.display = 'none';
                    }, 5000); // 5 giây
                }
            });
        </script>

    </body>
</html>