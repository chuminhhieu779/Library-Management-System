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
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            nav{
                background-color: rgb(215, 186, 147);
                padding: 10px 0;
                border-bottom: 3px solid #9472E5;
            }
            nav ul {
                padding: 3px;
                list-style: none;
                display: flex;
                justify-content: center;
                gap: 20px;
            }
            nav ul li a{
                text-decoration: none;
                color: black;
                font-size: 18px;
            }


            /* Content và Form */
            content {
                display: block;
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 40px 20px;
            }

            form {          
                padding: 40px;
                border-radius: 10px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.2);
                width: 100%;
                max-width: 450px;
            }

            #title {
                text-align: center;
                margin-bottom: 30px;
                border-radius: 5px ;
            }

            #title h2 {
                color: #1f2937;
                font-size: 28px;
                font-weight: 600;

            }
       
            #content-login {
        
                display: flex;
                flex-direction: column;
                gap: 20px;
            }

            #content-login label {
                color: #374151;
                font-size: 15px;
                font-weight: 500;
                margin-bottom: -10px;
            }

            #content-login input {
                padding: 12px 15px;
                border: 2px solid #e5e7eb;
                border-radius: 6px;
                font-size: 15px;
                transition: all 0.3s;
            }

            #content-login input:focus {
                outline: none;
                border-color: #667eea;
                box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
            }

            #content-login button {
                padding: 14px;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                color: white;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: transform 0.2s, box-shadow 0.2s;
                margin-top: 10px;
            }

            #content-login button:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
            }

            #content-login button:active {
                transform: translateY(0);
            }

            #content-login p {
                margin: 0;
                padding: 12px;
                background-color: #fee2e2;
                border-left: 4px solid #ef4444;
                border-radius: 4px;
                font-size: 14px;
                color: #991b1b;
            }

            /* Footer giữ nguyên style inline */
            .footer {
                background: #111827;
                color: #e5e7eb;
                text-align: center;
                padding: 5px 5px;
            }

            .footer-section h3 {
                margin-bottom: 10px;
                font-size: 20px;
                color: #a5b4fc;
            }

            .footer-section p {
                font-size: 15px;
                line-height: 1.6;
                max-width: 600px;
                margin: 0 auto 20px;
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
