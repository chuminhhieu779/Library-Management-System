<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - Library Management System</title>
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
            flex: 1;
            padding: 40px 60px;
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

        .btn-info {
            background: linear-gradient(135deg, #0ea5e9, #0284c7);
            color: #fff;
        }

        .btn-info:hover {
            background: linear-gradient(135deg, #0284c7, #0369a1);
            transform: translateY(-1px);
            box-shadow: 0 3px 8px rgba(14, 165, 233, 0.3);
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

        /* ==== USERS TABLE ==== */
        .table-container {
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
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

        .users-table th {
            padding: 16px;
            text-align: left;
            font-weight: 600;
            font-size: 14px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .users-table td {
            padding: 14px 16px;
            border-bottom: 1px solid #f3f4f6;
            font-size: 14px;
            color: #374151;
        }

        .users-table tbody tr {
            transition: background 0.2s;
        }

        .users-table tbody tr:hover {
            background: #f9fafb;
        }

        .users-table tbody tr:last-child td {
            border-bottom: none;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #e5e7eb;
        }

        .user-details h4 {
            font-size: 14px;
            font-weight: 600;
            color: #1f2937;
            margin-bottom: 2px;
        }

        .user-details p {
            font-size: 12px;
            color: #6b7280;
        }

        .status-badge {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
            display: inline-block;
        }

        .status-active {
            background: #ecfdf5;
            color: #065f46;
        }

        .status-inactive {
            background: #fef2f2;
            color: #991b1b;
        }

        .actions {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .actions .btn-sm {
            min-width: 90px;
            justify-content: center;
        }

        /* ==== PAGINATION ==== */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 25px;
        }

        .page-btn {
            padding: 8px 12px;
            border: 1px solid #d1d5db;
            background: #fff;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.2s;
        }

        .page-btn:hover {
            background: #f3f4f6;
            border-color: #4f46e5;
        }

        .page-btn.active {
            background: #4f46e5;
            color: #fff;
            border-color: #4f46e5;
        }

        .page-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
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

            .users-table {
                min-width: 800px;
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
            <h2>Manage Users</h2>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty successMessage}">
            <div class="alert alert-success">
                <i class="fa-solid fa-check-circle"></i>
                ${successMessage}
            </div>
        </c:if>
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fa-solid fa-exclamation-circle"></i>
                ${errorMessage}
            </div>
        </c:if>

        <!-- Toolbar -->
        <div class="toolbar">
            <div class="search-box">
                <input type="text" class="search-input" placeholder="Search users by name, email, or ID..." id="searchInput">
                <button class="btn btn-primary" onclick="searchUsers()">
                    <i class="fa-solid fa-search"></i> Search
                </button>
            </div>
            <button class="btn btn-success" onclick="openAddModal()">
                <i class="fa-solid fa-user-plus"></i> Add New User
            </button>
        </div>

        <!-- Users Table -->
        <div class="table-container">
            <table class="users-table">
                <thead>
                    <tr>
                        <th>User ID</th>
                        <th>User Info</th>
                        <th>Account</th>
                        <th>Borrowed Books</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr>
                            <td>#${user.userID}</td>
                            <td>
                                <div class="user-info">
                                    <img src="${pageContext.request.contextPath}/resources/images/${user.avatar}" 
                                         alt="User" class="user-avatar">
                                    <div class="user-details">
                                        <h4>${user.fullName}</h4>
                                        <p>${user.email != null ? user.email : 'No email'}</p>
                                    </div>
                                </div>
                            </td>
                            <td>${user.account}</td>
                            <td>${user.borrowedBooks != null ? user.borrowedBooks : '0'} books</td>
                            <td>
                                <span class="status-badge ${user.status == 'Active' ? 'status-active' : 'status-inactive'}">
                                    ${user.status != null ? user.status : 'Active'}
                                </span>
                            </td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-warning btn-sm" 
                                            onclick="logoutUser(${user.userID})">
                                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="deleteUser(${user.userID})">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    
                    <!-- Sample data if no users from backend -->
                    <c:if test="${empty userList}">
                        <tr>
                            <td>#001</td>
                            <td>
                                <div class="user-info">
                                    <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" 
                                         alt="User" class="user-avatar">
                                    <div class="user-details">
                                        <h4>John Doe</h4>
                                        <p>john.doe@email.com</p>
                                    </div>
                                </div>
                            </td>
                            <td>johndoe123</td>
                            <td>3 books</td>
                            <td><span class="status-badge status-active">Active</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-warning btn-sm" onclick="logoutUser(1)">
                                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="deleteUser(1)">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#002</td>
                            <td>
                                <div class="user-info">
                                    <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" 
                                         alt="User" class="user-avatar">
                                    <div class="user-details">
                                        <h4>Jane Smith</h4>
                                        <p>jane.smith@email.com</p>
                                    </div>
                                </div>
                            </td>
                            <td>janesmith456</td>
                            <td>5 books</td>
                            <td><span class="status-badge status-active">Active</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-warning btn-sm" onclick="logoutUser(2)">
                                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                                    </button>
                                    <button class="btn btn-danger btn-sm" onclick="deleteUser(2)">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>#003</td>
                            <td>
                                <div class="user-info">
                                    <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" 
                                         alt="User" class="user-avatar">
                                    <div class="user-details">
                                        <h4>Mike Johnson</h4>
                                        <p>mike.johnson@email.com</p>
                                    </div>
                                </div>
                            </td>
                            <td>mikejohnson789</td>
                            <td>1 book</td>
                            <td><span class="status-badge status-inactive">Inactive</span></td>
                            <td>
                                <div class="actions">
                                    <button class="btn btn-info btn-sm" onclick="logoutUser(3, 'Inactive')">
                                        <i class="fa-solid fa-right-to-bracket"></i> Logout
                                    </button>
                                    <button class="btn btn-danger btn-sm">
                                        <i class="fa-solid fa-trash"></i> Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- Pagination -->
        <div class="pagination">
            <button class="page-btn" disabled>
                <i class="fa-solid fa-chevron-left"></i>
            </button>
            <button class="page-btn active">1</button>
            <button class="page-btn">2</button>
            <button class="page-btn">3</button>
            <button class="page-btn">
                <i class="fa-solid fa-chevron-right"></i>
            </button>
        </div>
    </main>

    <!-- Add/Edit User Modal -->
    <div class="modal" id="userModal">
        <div class="modal-content">
            <div class="modal-header">
                <h3 id="modalTitle">Add New User</h3>
                <button class="close-btn" onclick="closeModal()">&times;</button>
            </div>
            <form action="${pageContext.request.contextPath}/admin/users/save" method="post">
                <input type="hidden" name="userID" id="userID">
                
                <div class="form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" class="form-control" id="fullName" name="fullName" required>
                </div>

                <div class="form-group">
                    <label for="account">Account</label>
                    <input type="text" class="form-control" id="account" name="account" required>
                </div>

                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" class="form-control" id="password" name="password" required>
                </div>

                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" class="form-control" id="email" name="email">
                </div>

                <div class="form-group">
                    <label for="status">Status</label>
                    <select class="form-control" id="status" name="status">
                        <option value="Active">Active</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" onclick="closeModal()">Cancel</button>
                    <button type="submit" class="btn btn-success">
                        <i class="fa-solid fa-save"></i> Save User
                    </button>
                </div>
            </form>
        </div>
    </div>

    <!-- ==== FOOTER ==== -->
    <footer class="footer">
        <div class="footer-content">
            <a href="${pageContext.request.contextPath}/about">About</a>
            <a href="${pageContext.request.contextPath}/contact">Contact</a>
            <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
        </div>
        <p>&copy; 2025 Library Management System — All rights reserved.</p>
    </footer>

    <script>
        function openAddModal() {
            document.getElementById('modalTitle').textContent = 'Add New User';
            document.getElementById('userModal').classList.add('show');
            document.getElementById('userID').value = '';
            document.querySelector('form').reset();
        }

        function closeModal() {
            document.getElementById('userModal').classList.remove('show');
        }

        function logoutUser(userId) {
            window.location.href = '${pageContext.request.contextPath}/admin/users/logout?id=' + userId;
        }

        function deleteUser(userId) {
            window.location.href = '${pageContext.request.contextPath}/admin/users/delete?id=' + userId;
        }

        function searchUsers() {
            const searchValue = document.getElementById('searchInput').value;
            window.location.href = '${pageContext.request.contextPath}/admin/users?search=' + searchValue;
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('userModal');
            if (event.target === modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>