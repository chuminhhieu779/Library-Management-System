<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="${book.title}" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="back-link">
        <a href="${pageContext.request.contextPath}/book/list">
            <i class="fas fa-arrow-left"></i> Back to All Books
        </a>
    </div>

    <div class="book-detail">
        <div class="book-detail__cover">
            <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Cover of ${book.title}">
        </div>

        <div class="book-detail__info">
            <h1 class="book-detail__title">${book.title}</h1>
            
            <ul class="book-detail__meta">
                <li><strong>Author:</strong> ${book.author}</li>
                <li><strong>Category:</strong> ${book.category.name}</li>
                <li><strong>Available:</strong> ${book.quantity} copies</li>
            </ul>

            <div class="book-detail__description">
                <h2>Description</h2>
                <p>${book.description}</p>
            </div>

            <div class="book-detail__actions">
                <form action="${pageContext.request.contextPath}/borrowing/borrow" method="get">
                    <input type="hidden" name="slug" value="${book.slug}">
                    <button type="submit" name="bookID" value="${book.bookID}" class="btn btn--primary">
                        <i class="fas fa-book-open"></i> Borrow Book
                    </button>
                </form>
                <form action="${pageContext.request.contextPath}/favorite/add-book" method="get">
                    <input type="hidden" name="slug" value="${book.slug}">
                    <button type="submit" name="bookID" value="${book.bookID}" class="btn btn--secondary">
                        <i class="fas fa-heart"></i> Favorite
                    </button>
                </form>
            </div>
            
            <c:if test="${not empty success}">
                <div class="message success-message">${success}</div>
                <c:remove var="success" scope="session" />
            </c:if>
            <c:if test="${not empty failed}">
                <div class="message error-message">${failed}</div>
                <c:remove var="failed" scope="session" />
            </c:if>
        </div>
    </div>
</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>