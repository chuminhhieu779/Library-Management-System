<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Manage Books - Library Management System</title>
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
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
                overflow: hidden;
            }

            .books-table {
                width: 100%;
                border-collapse: collapse;
            }

            .books-table thead {
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                color: #fff;
            }

            .books-table th {
                padding: 16px;
                text-align: left;
                font-weight: 600;
                font-size: 14px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .books-table td {
                padding: 14px 16px;
                border-bottom: 1px solid #f3f4f6;
                font-size: 14px;
                color: #374151;
            }

            .books-table tbody tr {
                transition: background 0.2s;
            }

            .books-table tbody tr:hover {
                background: #f9fafb;
            }

            .books-table tbody tr:last-child td {
                border-bottom: none;
            }

            .book-info {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .book-cover {
                width: 50px;
                height: 70px;
                border-radius: 4px;
                object-fit: cover;
                border: 2px solid #e5e7eb;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }

            .book-details h4 {
                font-size: 14px;
                font-weight: 600;
                color: #1f2937;
                margin-bottom: 2px;
            }

            .book-details p {
                font-size: 12px;
                color: #6b7280;
            }

            .category-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                display: inline-block;
                background: #dbeafe;
                color: #1e40af;
            }

            .quantity-badge {
                padding: 4px 12px;
                border-radius: 20px;
                font-size: 12px;
                font-weight: 600;
                display: inline-block;
            }

            .quantity-high {
                background: #ecfdf5;
                color: #065f46;
            }

            .quantity-low {
                background: #fef3c7;
                color: #92400e;
            }

            .quantity-out {
                background: #fef2f2;
                color: #991b1b;
            }

            .actions {
                display: flex;
                gap: 10px;
                align-items: center;
            }

            .actions .btn-sm {
                min-width: 80px;
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
                <h2>Manage Books</h2>
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
                    <input type="text" class="search-input" placeholder="Search books by title, author, or category..." id="searchInput">
                    <button class="btn btn-primary" onclick="searchBooks()">
                        <i class="fa-solid fa-search"></i> Search
                    </button>
                </div>
                <button class="btn btn-success" onclick="openAddModal()">
                    <i class="fa-solid fa-book-medical"></i> Add New Book
                </button>
            </div>

            <!-- Books Table -->
            <div class="table-container">
                <table class="books-table">
                    <thead>
                        <tr>
                            <th>Book Info</th>
                            <th>Author</th>
                            <th>Category</th>
                            <th>Quantity</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty bookList}">
                            <c:forEach var="book" items="${bookList}">
                                <tr>
                                    <td>
                                        <div class="book-info">
                                            <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage != null ? book.coverImage : 'default-book.jpg'}" 
                                                 alt="Book Cover" class="book-cover">
                                            <div class="book-details">
                                                <h4>${book.title}</h4>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${book.author}</td>
                                    <td><span class="category-badge">${book.category.name}</span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${book.quantity > 10}">
                                                <span class="quantity-badge quantity-high">${book.quantity} books</span>
                                            </c:when>
                                            <c:when test="${book.quantity > 0}">
                                                <span class="quantity-badge quantity-low">${book.quantity} books</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="quantity-badge quantity-out">Out of stock</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="actions">
                                            <button class="btn btn-warning btn-sm" onclick="editBook(${book.bookID})">
                                                <i class="fa-solid fa-pen-to-square"></i> Edit
                                            </button>
                                            <button class="btn btn-danger btn-sm" onclick="deleteBook(${book.bookID})">
                                                <i class="fa-solid fa-trash"></i> Delete
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:if>

                        <!-- Nếu danh sách rỗng -->
                        <c:if test="${empty bookList}">
                            <tr>
                                <td colspan="6" style="text-align:center; color:gray;">
                                    No books available in the system.
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

        <!-- Add/Edit Book Modal -->
        <div class="modal" id="bookModal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3 id="modalTitle">Add New Book</h3>
                    <button class="close-btn" onclick="closeModal()">&times;</button>
                </div>
                <form action="${pageContext.request.contextPath}/admin/books/save" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="bookID" id="bookID">

                    <div class="form-group">
                        <label for="name">Book Title</label>
                        <input type="text" class="form-control" id="name" name="name" required>
                    </div>

                    <div class="form-group">
                        <label for="author">Author</label>
                        <input type="text" class="form-control" id="author" name="author" required>
                    </div>

                    <div class="form-group">
                        <label for="category">Category</label>
                        <select class="form-control" id="category" name="category" required>
                            <option value="">Select Category</option>
                            <option value="Classic Fiction">Classic Fiction</option>
                            <option value="Literary Fiction">Literary Fiction</option>
                            <option value="Dystopian Fiction">Dystopian Fiction</option>
                            <option value="Science Fiction">Science Fiction</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="Mystery">Mystery</option>
                            <option value="Thriller">Thriller</option>
                            <option value="Romance">Romance</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Biography">Biography</option>
                            <option value="History">History</option>
                            <option value="Self-Help">Self-Help</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="quantity">Quantity</label>
                        <input type="number" class="form-control" id="quantity" name="quantity" min="0" required>
                    </div>

                    <div class="form-group">
                        <label for="coverImage">Cover Image</label>
                        <input type="file" class="form-control" id="coverImage" name="coverImage" accept="image/*">
                        <small style="color: #6b7280; font-size: 12px; display: block; margin-top: 4px;">
                            Upload a cover image for the book (JPG, PNG, GIF)
                        </small>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" onclick="closeModal()">Cancel</button>
                        <button type="submit" class="btn btn-success">
                            <i class="fa-solid fa-save"></i> Save Book
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
            // ===== Open "Add Book" Modal =====
            function openAddModal() {
                document.getElementById('modalTitle').textContent = 'Add New Book';
                document.getElementById('bookModal').classList.add('show');
                document.getElementById('bookID').value = '';
                document.querySelector('#bookModal form').reset();
            }

            // ===== Close Modal =====
            function closeModal() {
                document.getElementById('bookModal').classList.remove('show');
            }

            // ===== Edit Book =====
            function editBook(bookID) {
                // Gửi yêu cầu đến servlet để lấy thông tin sách cần sửa
                window.location.href = '${pageContext.request.contextPath}/admin/books/edit?id=' + bookID;
            }

            // ===== Delete Book =====
            function deleteBook(bookID) {
                if (confirm('Are you sure you want to delete this book? This action cannot be undone.')) {
                    window.location.href = '${pageContext.request.contextPath}/admin/books/delete?id=' + bookID;
                }
            }

            // ===== Search Books =====
            function searchBooks() {
                const searchValue = document.getElementById('searchInput').value.trim();
                window.location.href = '${pageContext.request.contextPath}/admin/books?search=' + encodeURIComponent(searchValue);
            }

            // ===== Close Modal When Clicking Outside =====
            window.onclick = function (event) {
                const modal = document.getElementById('bookModal');
                if (event.target === modal) {
                    closeModal();
                }
            };

            // ===== Press Enter to Search =====
            document.getElementById('searchInput').addEventListener('keypress', function (e) {
                if (e.key === 'Enter') {
                    e.preventDefault();
                    searchBooks();
                }
            });
        </script>
    </body>
</html>