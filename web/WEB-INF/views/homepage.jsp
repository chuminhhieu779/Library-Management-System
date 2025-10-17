<%-- 
    Document   : homepage
    Created on : Oct 10, 2025, 10:06:37 PM
    Author     : hieuchu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/homepage.css?v=<%=System.currentTimeMillis()%>">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>

        <header class="header">
            <%@include file="/WEB-INF/views/components/header.jsp" %>
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
        <main>
            <marquee behavior="scroll" direction="left" scrollamount="10">
                <h2>Welcome to Library Management System</h2>
            </marquee>
            <div class="image-container">
                <img src="${pageContext.request.contextPath}/resources/images/1.jpg">
            </div>
            
                        
            <div class="login">
                <form action="Login" method="post">
                    <div class="title">
                        <h3> Login Form </h3>
                    </div>
                    <div class="login-content">
                        <%if(request.getAttribute("error")!= null){%>
                        <p style="color: red"><%= request.getAttribute("error")%></p>
                        <%}%>
                        <%if(request.getAttribute("success")!= null){%>
                        <p style="color: #28a745"><%= request.getAttribute("success") %></p>
                        <%}%>
                        <label for="">Enter your account:</label>
                        <input type="text" name="account">
                        <label for="">Enter your password:</label>
                        <input type="password" name="password">
                        <div class="button">
                            <button type="submit">Login</button>
                            <div id="sign-up">
                                <a href="${pageContext.request.contextPath}/user/register">Sign Up</a>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </main>
        <footer class="footer">
            <%@include file="/WEB-INF/views/components/footer.jsp" %>
        </footer>
    </body>
</html>
