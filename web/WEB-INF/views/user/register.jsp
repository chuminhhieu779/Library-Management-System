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
        <%@include file="/WEB-INF/views/components/footer.jsp" %>
    </footer>
</body>
</html>
