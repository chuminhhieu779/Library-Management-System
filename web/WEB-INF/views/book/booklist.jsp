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
            padding: 15px 60px;
            display: flex;
            justify-content: center;
            align-items: center;
            position: relative;
            z-index: 10;
        }

        .nav-center ul {
            display: flex;
            list-style: none;
        }

        .nav-center li {
            margin: 0 25px;
        }

        nav a {
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #a5b4fc;
        }

        /* ==== USER / AUTH AREA ==== */
        .nav-right {
            position: absolute;
            right: 60px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .nav-right a {
            background-color: #4f46e5;
            color: white;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 500;
            text-decoration: none;
            transition: background-color 0.3s;
        }

        .nav-right a:hover {
            background-color: #6366f1;
        }

        /* ==== USER MENU ==== */
        .user-menu {
            position: relative;
            display: inline-block;
        }

        .avatar {
            width: 42px;
            height: 42px;
            border-radius: 50%;
            cursor: pointer;
            object-fit: cover;
            border: 2px solid #4f46e5;
            transition: transform 0.2s;
        }

        .avatar:hover {
            transform: scale(1.05);
        }

        .dropdown {
            display: none;
            position: absolute;
            top: 55px;
            right: 0;
            background: #1f2937;
            border-radius: 12px;
            box-shadow: 0 4px 14px rgba(0,0,0,0.25);
            min-width: 210px;
            overflow: hidden;
            z-index: 100;
        }

        .dropdown.show {
            display: block;
        }

        .user-info {
            text-align: center;
            padding: 15px 10px;
            border-bottom: 1px solid #374151;
        }

        .avatar-large {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #4f46e5;
            margin-bottom: 8px;
        }

        .username {
            font-weight: 600;
            color: #f9fafb;
            font-size: 15px;
        }

        .role {
            font-size: 13px;
            color: #9ca3af;
        }

        .dropdown-item {
            display: block;
            padding: 10px 16px;
            color: #f9fafb;
            text-decoration: none;
            font-size: 14px;
            transition: background 0.2s;
        }

        .dropdown-item:hover {
            background-color: #374151;
        }

        .logout {
            color: #f87171;
            font-weight: 500;
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
    </style>
</head>

<body>
    <nav>
        <div class="nav-center">
            <ul>
                <li><a href="${pageContext.request.contextPath}/book/list">Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/book/category">Category</a></li>
                <li><a href="${pageContext.request.contextPath}/book/search">Search Book</a></li>
            </ul>
        </div>

        <div class="nav-right">
            <!-- Nếu chưa đăng nhập -->
            <c:if test="${sessionScope.account == null}">
                <a href="${pageContext.request.contextPath}/user/login">Login</a>
                <a href="${pageContext.request.contextPath}/user/register">Sign Up</a>
            </c:if>

            <!-- Nếu đã đăng nhập -->
            <c:if test="${sessionScope.account != null}">
                <div class="user-menu">
                    <img src="${pageContext.request.contextPath}/resources/images/1.jpg"
                         alt="User Avatar" class="avatar" id="avatarBtn">

                    <div class="dropdown" id="userDropdown">
                        <div class="user-info">
                            <img src="${pageContext.request.contextPath}/resources/images/1.jpg" 
                                 alt="User Avatar Large" class="avatar-large">
                            <p class="username">${sessionScope.account}</p>
                            <p class="role">Library Member</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/user/dashboard" class="dropdown-item">Profile</a>
                        <a href="${pageContext.request.contextPath}/favorite/books" class="dropdown-item">Favorite</a>
                        <a href="${pageContext.request.contextPath}/LogOut" class="dropdown-item logout">Logout</a>
                    </div>
                </div>
            </c:if>
        </div>
    </nav>

    <div class="book-container">
        <h2>Book List</h2>
        <div class="book-gallery">
            <c:forEach var="book" items="${bookList}">
                <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="book-card">
                    <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Book cover">
                </a>
            </c:forEach>
        </div>
    </div>

    <footer class="footer">
        <%@include file="/WEB-INF/views/components/footer.jsp" %>
    </footer>

    <script>
        // Làm dropdown hiển thị khi click, không ẩn khi di chuột ra
        const avatarBtn = document.getElementById('avatarBtn');
        const dropdown = document.getElementById('userDropdown');

        avatarBtn.addEventListener('click', (e) => {
            e.stopPropagation();
            dropdown.classList.toggle('show');
        });

        document.addEventListener('click', (e) => {
            if (!dropdown.contains(e.target) && e.target !== avatarBtn) {
                dropdown.classList.remove('show');
            }
        });
    </script>
</body>
</html>
