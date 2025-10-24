<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="pageTitle" value="Create Account" />
<%@ include file="/WEB-INF/views/components/header.jsp" %>

<main class="container">
    <div class="register-form">
        <h1>Create a New Account</h1>
        <p>Join our community to borrow and discover new books.</p>
        
        <form action="${pageContext.request.contextPath}/user/register" method="post">
            
            <c:if test="${not empty error}">
                <div class="message error-message">
                    ${error}
                </div>
            </c:if>

            <div class="form-group">
                <label for="username">User Name:</label>
                <input type="text" id="username" name="username" placeholder="e.g., John Doe" required>
            </div>

            <div class="form-group">
                <label for="account">Account:</label>
                <input type="text" id="account" name="account" placeholder="e.g., johndoe123" required>
            </div>
            
            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required>
            </div>

            <button type="submit" class="btn">Sign Up</button>
        </form>
    </div>
</main>

<%@ include file="/WEB-INF/views/components/footer.jsp" %>