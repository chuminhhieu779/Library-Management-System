<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="User Dashboard" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="dashboard-welcome">
        <h1>Welcome back, ${sessionScope.user.name}!</h1>
        <p>What would you like to do today?</p>
    </div>

    <div class="dashboard-grid">
        <a href="${pageContext.request.contextPath}/book/list" class="dashboard-card">
            <i class="fas fa-book-open"></i>
            <h3>Browse Books</h3>
            <p>Explore the full collection and find new books.</p>
        </a>

        <a href="${pageContext.request.contextPath}/borrowing/borrowed" class="dashboard-card">
            <i class="fas fa-hand-holding-hand"></i>
            <h3>My Borrowed Books</h3>
            <p>View your current loans and extend due dates.</p>
        </a>

        <a href="${pageContext.request.contextPath}/borrowing/returned" class="dashboard-card">
            <i class="fas fa-history"></i>
            <h3>My History</h3>
            <p>See the history of all books you have returned.</p>
        </a>
        
        <a href="${pageContext.request.contextPath}/favorite/books" class="dashboard-card">
            <i class="fas fa-bookmark"></i>
            <h3>My Favorites</h3>
            <p>Manage your personal collection of favorite books.</p>
        </a>
    </div>
</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>