<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Books by Category" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="page-header">
        <h1>Browse by Category</h1>
        <p>Select a category to explore our curated collection of books.</p>
    </div>

    <div class="category-filter">
        <form action="${pageContext.request.contextPath}/book/category" method="post">
            <label for="category-select">Choose a category:</label>
            <select name="category-select" id="category-select" class="category-select" onchange="this.form.submit()">
                <option value="Action" ${selected eq 'Action' ? 'selected' : ''}>Action</option>
                <option value="English" ${selected eq 'English' ? 'selected' : ''}>English</option>
                <option value="Romance" ${selected eq 'Romance' ? 'selected' : ''}>Romance</option>
                <option value="Soft Skill" ${selected eq 'Soft Skill' ? 'selected' : ''}>Soft Skill</option>
                <option value="Technology" ${selected eq 'Technology' ? 'selected' : ''}>Technology</option>
            </select>
        </form>
    </div>

    <c:if test="${not empty selected}">
        <div class="search-results-info">
            Showing books in the "<strong>${selected}</strong>" category
        </div>
    </c:if>

    <div class="book-gallery">
        <c:forEach var="book" items="${categorizeBook}">
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