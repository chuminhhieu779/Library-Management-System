<%-- 
    Document   : register
    Created on : Oct 13, 2025, 10:24:59 PM
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/register.css?v=<%=System.currentTimeMillis()%>">
        <title>JSP Page</title>
        <style>
            /* Reset và thiết lập cơ bản */
/* Reset và thiết lập cơ bản */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background-color: #f4f7f6; /* Nền xám nhạt */
    min-height: 100vh; /* Đảm bảo body chiếm toàn bộ chiều cao */
    display: flex;
    flex-direction: column;
}

/* ================== HEADER STYLING ================== */
.header {
    background-color: white; /* Primary blue */
    color: black;
    padding: 10px 0;
}

.header .content {
    margin: 0 0;
    padding: 0 20px; 
    display: flex; 
    align-items: center; 
    /* ĐIỀU CHỈNH 2: Căn chỉnh sang trái (đã đúng) */
    justify-content: flex-start; 
}

.header .content img {
    height: 40px; /* ĐIỀU CHỈNH: Giảm kích thước avatar */
    width: 40px; /* ĐIỀU CHỈNH: Giảm kích thước avatar */
    border-radius: 50%; 
    /* LOẠI BỎ border trắng nếu nền header là trắng, hoặc giữ nếu bạn muốn viền */
    border: none; 
    object-fit: cover; 
    margin-right: 10px; /* Giảm khoảng cách nhẹ */
}

.header .content h3 {
    margin: 0; 
    /* ĐIỀU CHỈNH 3: Giảm kích thước chữ */
    font-size: 1.3em; 
    font-weight: 700; 
    letter-spacing: 0.5px; 
    /* LOẠI BỎ thuộc tính display: flex; */
    /* display: flex; <--- LOẠI BỎ DÒNG NÀY */
    
    /* TÙY CHỌN: Đảm bảo tiêu đề không bị ngắt nếu chiều rộng container bị giới hạn */
    white-space: nowrap; 
}

/* ================== NAVIGATION STYLING ================== */
nav {
    /* Đã thay đổi màu nền để đồng bộ hoặc hiện đại hơn, thay vì rgb(215, 186, 147) */
    background-color: #007bff; 
    /* Đã thay đổi màu viền để đồng bộ hơn với #007bff */
}
nav ul {
    padding: 3px;
    list-style: none;
    display: flex;
    justify-content: center;
    gap: 30px; /* Tăng khoảng cách một chút */
    margin: 0 auto;
    max-width: 1200px;
}
nav ul li a{
    text-decoration: none;
    color: white; /* Màu chữ đen xám đậm */
    font-size: 16px; /* Giảm cỡ chữ một chút để trông gọn gàng hơn */
    font-weight: 600;
    padding: 5px 10px;
    transition: color 0.3s ease;
}

/* ================== CONTENT & FORM STYLING ================== */
content {
    display: block;
    flex: 1;
    /* Dùng min-height 100% để Form luôn ở giữa ngay cả khi nội dung ít */
    min-height: calc(100vh - 70px - 100px); /* 100vh - header - footer */
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 40px 20px;
}

form {      
    background-color: #ffffff; /* Nền trắng cho form */
    padding: 40px;
    border-radius: 10px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1); /* Đổ bóng nhẹ nhàng hơn */
    width: 100%;
    max-width: 450px;
}

#title {
    text-align: center;
    margin-bottom: 30px;
}

#title h2 {
    color: #007bff; /* Dùng màu xanh chủ đạo */
    font-size: 28px;
    font-weight: 700;
    padding-bottom: 10px;
}

#content-login {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

#content-login label {
    color: #374151;
    font-size: 15px;
    font-weight: 600; /* Tăng độ đậm */
    margin-bottom: -10px;
}

#content-login input {
    padding: 12px 15px;
    border: 1px solid #ced4da; /* Viền mỏng và nhẹ hơn */
    border-radius: 6px;
    font-size: 15px;
    transition: all 0.3s;
}

#content-login input:focus {
    outline: none;
    border-color: #007bff; /* Dùng màu xanh chủ đạo */
    box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.25); /* Box shadow rõ ràng hơn */
}

#content-login button {
    padding: 14px;
    /* Đã thay đổi gradient để sử dụng màu xanh chủ đạo */
    background: #007bff; 
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 17px; /* Tăng cỡ chữ */
    font-weight: 600;
    cursor: pointer;
    transition: background-color 0.2s, transform 0.2s, box-shadow 0.2s;
    margin-top: 15px; /* Tăng khoảng cách */
}

#content-login button:hover {
    background-color: #0056b3; /* Darker blue on hover */
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
}

#content-login button:active {
    transform: translateY(0);
}

/* Style cho thông báo lỗi (error message) */
#content-login p {
    margin: 0;
    padding: 12px;
    background-color: #f8d7da; /* Nền đỏ nhạt */
    border-left: 4px solid #dc3545; /* Viền đỏ đậm */
    border-radius: 4px;
    font-size: 14px;
    color: #721c24; /* Chữ đỏ đậm */
    font-weight: 500;
}


/* ================== FOOTER STYLING ================== */
.footer {
    background: #343a40; /* Dark gray background */
    color: #e5e7eb;
    text-align: center;
    padding: 20px 20px; /* Tăng padding để trông đẹp hơn */
    margin-top: auto; /* Đẩy footer xuống dưới cùng */
    border-top: 3px solid #007bff;
}

.footer-section h3 {
    margin-bottom: 10px;
    font-size: 1.2em; /* Kích thước chữ vừa phải */
    color: #ffffff; /* Màu chữ trắng */
}

.footer-section p {
    font-size: 0.9em;
    line-height: 1.6;
    max-width: 600px;
    margin: 0 auto;
}
        </style>
    </head>
    <body>
        <header class="header">
            <div class="content">
                <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg">  
                <h3>Library Management System </h3>
            </div>  
        </header>
        <nav>
            <ul>
                <li><a href="/HomePage/Home.html">Home</a></li>
                <li><a href="/HomePage/About.html">About</a></li>
                <li><a href="/HomePage/Contact.html">Contact</a></li>
                <li><a href="/LoginPage/Login.html"> User Login</a></li>
                <li><a href="/SignUpPage/SignUp.html">Admin Login </a></li>
            </ul>
        </nav>
    <content>
        <form action="${pageContext.request.contextPath}/user/register" method="post">
            <div id="title">
                <h2>Sign Up User</h2>
            </div>
            <div id="content-login">
                <%if(request.getAttribute("error")!= null){%>
                <p style="color: red"><%= request.getAttribute("error") %></p>
                <%}%>
                <label> Enter user name :</label>
                <input type="text"  name="username" >
                <label> Enter account :</label>
                <input type="text"  name="account" >
                <label> Enter password :</label>
                <input type="password"  name="password" >
                <button type="submit">Sign Up</button>            
            </div>  
        </form>
    </content> 
    <footer class="footer">
        <div class="footer-section">
            <h3>About Library</h3>
            <p>A modern library management system providing convenient online book borrowing and returning services.</p>             
        </div>  
    </footer>
</body>
</html>
