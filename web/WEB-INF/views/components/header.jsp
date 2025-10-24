<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <title>${not empty pageTitle ? pageTitle : "Library Management System"}</title>

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/homepage.css?v=<%=System.currentTimeMillis()%>">
</head>
<body>

<header class="header">
    <div class="header-container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">Library System</a>
        </div>
        <nav class="navigation">
            <ul>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <%-- Menu for LOGGED-IN users --%>
                        <li><a href="${pageContext.request.contextPath}/book/list">Browse Books</a></li>
                        <li><a href="${pageContext.request.contextPath}/book/search">Search</a></li>
                        <li class="user-menu">
                            <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="User Avatar" class="user-menu__avatar">
                            <div class="user-menu__dropdown">
                                <p class="user-menu__name">${sessionScope.user.name}</p>
                                <hr>
                                <a href="${pageContext.request.contextPath}/borrowing/borrowed" class="user-menu__item">Borrowed Books</a>
                                <a href="${pageContext.request.contextPath}/favorite/books" class="user-menu__item">My Favorites</a>
                                <a href="${pageContext.request.contextPath}/logout" class="user-menu__item user-menu__item--logout">Logout</a>
                            </div>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <%-- Menu for PUBLIC users --%>
                        <li><a href="${pageContext.request.contextPath}/">Home</a></li>
                        <li><a href="${pageContext.request.contextPath}/book/list">Books</a></li>
                        <li><a href="${pageContext.request.contextPath}/user/login" class="nav-button">Login</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</header>