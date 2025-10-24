<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="pageTitle" value="Search Books" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="page-header">
        <h1>Search Our Collection</h1>
        <p>Find your next favorite book by title, author, or category.</p>
    </div>

    <div class="search-form-wrapper">
        <form action="${pageContext.request.contextPath}/book/search" method="get" class="search-form">
            <input 
                type="text" 
                name="query" 
                class="search-input" 
                placeholder="Enter a keyword..."
                value="${param.query}"
                required>
            <button type="submit" class="btn">
                <i class="fas fa-search"></i> Search
            </button>
        </form>
    </div>

    <c:if test="${not empty param.query}">
        <c:choose>
            <c:when test="${not empty searchBook}">
                <div class="search-results-info">
                    Found <strong>${fn:length(searchBook)}</strong> result(s) for "<strong>${param.query}</strong>"
                </div>
                <div class="book-gallery">
                    <c:forEach var="book" items="${searchBook}">
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
            </c:when>
            <c:otherwise>
                <div class="no-results-message">
                    <i class="fas fa-search-minus"></i>
                    <h2>No Results Found</h2>
                    <p>We couldn't find any books matching "<strong>${param.query}</strong>". Please try a different keyword.</p>
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>

</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>