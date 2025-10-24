<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="My Borrowed Books" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="page-header">
        <h1>My Borrowed Books</h1>
        <p>Here are the books you are currently borrowing.</p>
    </div>

    <c:choose>
        <c:when test="${empty borrowedBooks}">
            <div class="no-results-message">
                <i class="fas fa-book-reader"></i>
                <h2>No Books Borrowed</h2>
                <p>You haven't borrowed any books yet. Go explore our collection!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="borrowed-book-list">
                <c:forEach var="book" items="${borrowedBooks}" varStatus="loop">
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
                                <span><strong>Due:</strong> ${book.dueDate}</span>
                            </div>
                        </div>
                        <div class="borrowed-book__actions">
                            <a href="${pageContext.request.contextPath}/borrowing/return?slug=${book.slug}&bookID=${book.bookID}" class="btn btn--secondary">Return</a>
                            <button class="btn btn--primary" onclick="document.getElementById('popup${loop.index}').showModal()">Extend</button>
                        </div>
                    </div>

                    <dialog id="popup${loop.index}" class="modal">
                        <button class="modal__close-btn" onclick="this.closest('dialog').close()">&times;</button>
                        <h3>Extend Due Date</h3>
                        <p><strong>Book:</strong> ${book.title}</p>
                        <p><strong>Current Due Date:</strong> ${book.dueDate}</p>
                        
                        <div class="extend-form-box">
                            <c:if test="${not empty error && targetBookID == book.bookID}">
                                <div class="message error-message">⚠ ${error}</div>
                            </c:if>
                            
                            <form action="${pageContext.request.contextPath}/borrowing/extend" method="post">
                                <div class="form-group">
                                    <label for="newDueDate${loop.index}">Choose new due date:</label>
                                    <input type="date" id="newDueDate${loop.index}" name="newDueDate" min="${book.borrowDate}" required>
                                </div>
                                <input type="hidden" name="bookID" value="${book.bookID}">
                                <button type="submit" class="btn btn--primary">Confirm Extension</button>
                            </form>
                        </div>
                    </dialog>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</main>

<c:if test="${not empty sessionScope.returnSuccess}">
    <div id="returnToast" class="toast">✅ ${sessionScope.returnSuccess}</div>
    <c:remove var="returnSuccess" scope="session" />
    <script>
        const toast = document.getElementById('returnToast');
        setTimeout(() => toast.classList.add('show'), 100);
        setTimeout(() => toast.classList.remove('show'), 4000);
    </script>
</c:if>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>