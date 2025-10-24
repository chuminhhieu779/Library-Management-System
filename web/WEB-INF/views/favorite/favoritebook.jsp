<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="My Favorite Books" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="page-header">
        <h1>My Favorite Books</h1>
        <p>Your personal collection of books you want to read.</p>
    </div>

    <c:choose>
        <c:when test="${empty favoriteBooks}">
            <div class="no-results-message">
                <i class="fas fa-bookmark"></i>
                <h2>No Favorites Yet</h2>
                <p>You can add a book to your favorites from its detail page!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="book-gallery">
                <c:forEach var="book" items="${favoriteBooks}">
                    <div class="book-card favorite-card">
                        <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}">
                            <div class="book-cover">
                                <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Cover of ${book.title}">
                            </div>
                            <div class="book-info">
                                <h3 class="book-title">${book.title}</h3>
                            </div>
                        </a>
                        
                        <form action="${pageContext.request.contextPath}/favorite/remove" method="post" class="favorite-card__remove-form">
                            <input type="hidden" name="bookID" value="${book.bookID}">
                            <button type="submit" class="favorite-card__remove-btn" title="Remove from favorites">&times;</button>
                        </form>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>