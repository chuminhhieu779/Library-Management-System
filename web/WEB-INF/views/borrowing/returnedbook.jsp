<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="My Book History" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="page-header">
        <h1>Returned Books</h1>
        <p>This is the history of books you have borrowed and returned.</p>
    </div>

    <c:choose>
        <c:when test="${empty returnedBooks}">
            <div class="no-results-message">
                <i class="fas fa-history"></i>
                <h2>No History Yet</h2>
                <p>You haven't returned any books yet.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="borrowed-book-list">
                <c:forEach var="book" items="${returnedBooks}">
                    <div class="borrowed-book-card">
                        <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="borrowed-book__cover">
                            <img src="${pageContext.request.contextPath}/resources/images/${book.coverImage}" alt="Cover of ${book.title}">
                        </a>
                        <div class="borrowed-book__info">
                            <a href="${pageContext.request.contextPath}/book/detail?slug=${book.slug}&bookID=${book.bookID}" class="borrowed-book__title-link">
                                <h3 class="borrowed-book__title">${book.title}</h3>
                            </a>
                            <div class="borrowed-book__meta">
                                <span><strong>Borrowed:</strong> ${book.borrowDate}</span>
                                <span><strong>Returned:</strong> ${book.returnDate}</span>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>