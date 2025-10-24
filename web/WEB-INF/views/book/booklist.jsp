<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Book Collection" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="page-header">
        <h1>Our Book Collection</h1>
        <p>Browse through our extensive catalog of books available for you.</p>
    </div>

    <div class="book-gallery">
        <c:forEach var="book" items="${bookList}">
            <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="book-card">
                <div class="book-cover">
                    <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Cover of ${book.title}">
                </div>
                <div class="book-info">
                    <h3 class="book-title">${book.title}</h3>
                </div>
            </a>
        </c:forEach>
    </div>
</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>