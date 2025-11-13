<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Book Extension Request - Library Management</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html, body {
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: #f4f6f8;
                color: #333;
            }

            /* ==== NAVBAR ==== */
            .navbar {
                background: #111827;
                color: #e5e7eb;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 40px;
            }

            .navbar .logo {
                font-weight: 600;
                font-size: 18px;
            }

            /* ==== MAIN CONTENT ==== */
            .form-container {
                flex: 1;
                padding: 40px 20px;
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .extension-form-wrapper {
                background: #fff;
                border-radius: 16px;
                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                padding: 40px;
                max-width: 600px;
                width: 100%;
            }

            /* ==== BACK LINK ==== */
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                margin-bottom: 25px;
                text-decoration: none;
                color: #2563eb;
                font-weight: 500;
                transition: color 0.3s;
            }

            .back-link:hover {
                color: #1d4ed8;
                text-decoration: underline;
            }

            /* ==== PAGE TITLE ==== */
            .page-title {
                text-align: center;
                margin-bottom: 35px;
            }

            .page-title h2 {
                font-size: 22px;
                font-weight: 700;
                color: #1f2937;
                letter-spacing: 1px;
                text-transform: uppercase;
                position: relative;
                display: inline-block;
            }

            .page-title h2::after {
                content: "";
                display: block;
                width: 60%;
                height: 3px;
                background: linear-gradient(90deg, #4f46e5, #6366f1);
                margin: 8px auto 0;
                border-radius: 2px;
            }

            .page-title p {
                margin-top: 10px;
                color: #6b7280;
                font-size: 14px;
            }

            /* ==== FORM STYLES ==== */
            .form-group {
                margin-bottom: 22px;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #374151;
                margin-bottom: 8px;
                font-size: 14px;
            }

            .form-group label i {
                color: #4f46e5;
                margin-right: 6px;
            }

            .form-control {
                width: 100%;
                padding: 12px 16px;
                border: 1px solid #d1d5db;
                border-radius: 8px;
                font-size: 15px;
                transition: all 0.3s;
                background: #f9fafb;
            }

            .form-control:focus {
                outline: none;
                border-color: #4f46e5;
                box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
                background: #fff;
            }

            .form-control:disabled {
                background: #e5e7eb;
                cursor: not-allowed;
                color: #6b7280;
            }

            .form-control.readonly {
                background: #f3f4f6;
                cursor: not-allowed;
            }

            textarea.form-control {
                resize: vertical;
                min-height: 100px;
                font-family: inherit;
            }

            /* ==== INFO BOX ==== */
            .info-box {
                background: linear-gradient(135deg, #dbeafe, #e0e7ff);
                border-left: 4px solid #4f46e5;
                padding: 15px 18px;
                border-radius: 8px;
                margin-bottom: 25px;
            }

            .info-box p {
                color: #1f2937;
                font-size: 14px;
                line-height: 1.6;
                margin: 5px 0;
            }

            .info-box strong {
                color: #4f46e5;
            }

            /* ==== EXTENSION CALCULATOR ==== */
            .extension-calculator {
                background: #f9fafb;
                border: 2px dashed #d1d5db;
                border-radius: 12px;
                padding: 20px;
                margin-bottom: 25px;
            }

            .calculator-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 12px;
                font-size: 14px;
            }

            .calculator-row:last-child {
                margin-bottom: 0;
                padding-top: 12px;
                border-top: 2px solid #e5e7eb;
                font-weight: 700;
                font-size: 16px;
                color: #1f2937;
            }

            .calculator-label {
                color: #6b7280;
            }

            .calculator-value {
                color: #1f2937;
                font-weight: 600;
            }

            .new-date {
                color: #4f46e5;
            }

            /* ==== BUTTONS ==== */
            .form-actions {
                display: flex;
                gap: 12px;
                margin-top: 30px;
            }

            .btn {
                flex: 1;
                padding: 14px 24px;
                border: none;
                border-radius: 8px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                color: #fff;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #3b82f6, #2563eb);
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
            }

            .btn-secondary {
                background: #6b7280;
                color: #fff;
            }

            .btn-secondary:hover {
                background: #4b5563;
                transform: translateY(-2px);
            }

            /* ==== ALERTS ==== */
            .alert {
                padding: 14px 18px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .alert i {
                font-size: 18px;
            }

            .alert-success {
                background: #ecfdf5;
                color: #065f46;
                border: 1px solid #10b981;
            }

            .alert-danger {
                background: #fef2f2;
                color: #991b1b;
                border: 1px solid #ef4444;
            }

            .alert-info {
                background: #eff6ff;
                color: #1e40af;
                border: 1px solid #3b82f6;
            }

            /* ==== FOOTER ==== */
            .footer {
                background: linear-gradient(135deg, #111827, #1f2937);
                color: #d1d5db;
                text-align: center;
                padding: 15px 20px;
                font-size: 14px;
                border-top: 2px solid #4f46e5;
                margin-top: auto;
            }

            .footer-content {
                display: flex;
                justify-content: center;
                align-items: center;
                gap: 40px;
                flex-wrap: wrap;
            }

            .footer-content a {
                color: #a5b4fc;
                text-decoration: none;
                transition: color 0.3s ease;
            }

            .footer-content a:hover {
                color: #818cf8;
            }

            .footer p {
                margin-top: 10px;
                font-size: 13px;
                color: #9ca3af;
            }

            /* ==== RESPONSIVE ==== */
            @media (max-width: 768px) {
                .extension-form-wrapper {
                    padding: 25px 20px;
                }

                .form-actions {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                }
            }
            .toast {
                visibility: hidden;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%) scale(0.9);
                background-color: #111827; /* màu giống navbar */
                color: #f9fafb;
                padding: 20px 28px;
                border-radius: 12px;
                box-shadow: 0 8px 30px rgba(0, 0, 0, 0.4);
                font-size: 16px;
                font-weight: 600;
                text-align: center;
                z-index: 9999;
                opacity: 0;
                transition: all 0.4s ease;
            }

            .toast.show {
                visibility: visible;
                opacity: 1;
                transform: translate(-50%, -50%) scale(1);
            }


        </style>


    </head>

    <body>
        <script>
            function showToast(message) {
                const toast = document.getElementById("toast");
                toast.textContent = message;
                toast.classList.add("show");
                setTimeout(() => toast.classList.remove("show"), 2000);
            }

            document.addEventListener('DOMContentLoaded', () => {
                const form = document.querySelector("form");
                const submitBtn = form.querySelector('button[type="submit"]');

                submitBtn.addEventListener("click", (e) => {
                    e.preventDefault(); 
                    showToast("Renewal has been sent");
                    setTimeout(() => form.submit(), 1500); 
                });
            });
        </script>


        <!-- ==== NAVBAR ==== -->
        <nav class="navbar">
            <span class="logo">📚 Library System</span>
        </nav>
        <!-- ==== TOAST ==== -->
        <div id="toast" class="toast">Renewal has been sent</div>

        <!-- ==== MAIN CONTENT ==== -->
        <div class="form-container">
            <div class="extension-form-wrapper">
                <a class="back-link" href="${pageContext.request.contextPath}/borrowing/borrowed">
                    <i class="fa-solid fa-arrow-left"></i> Back to Borrowed Books
                </a>

                <div class="page-title">
                    <h2><i class="fa-solid fa-clock-rotate-left"></i> Book Extension Request</h2>
                    <p>Request to extend your book borrowing period</p>
                </div>

                <!-- Success/Error Messages -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success">
                        <i class="fa-solid fa-circle-check"></i>
                        ${successMessage}
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        <i class="fa-solid fa-circle-exclamation"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <!-- Info Box -->
                <div class="info-box">
                    <p><i class="fa-solid fa-info-circle"></i> <strong>Lưu ý:</strong></p>
                    <p>• Mỗi cuốn sách có thể được gia hạn tối đa 2 lần</p>
                    <p>• Thời gian gia hạn tối đa là 30 ngày mỗi lần</p>
                    <p>• Không thể gia hạn sách đã quá hạn trả</p>
                </div>

                <!-- Extension Form -->
                <form action="${pageContext.request.contextPath}/user/request-extend-book" 
                      method="post">

                    <div class="form-group">
                        <label for="account">
                            <i class="fa-solid fa-user"></i> Account
                        </label>
                        <input type="text" id="account" name="account" class="form-control readonly" 
                               value="${sessionScope.user.account}" readonly required>
                    </div>

                    <div class="form-group">
                        <label for="fullName">
                            <i class="fa-solid fa-id-card"></i> Full Name
                        </label>
                        <input type="text" id="fullName" name="fullName" class="form-control readonly" 
                               value="${sessionScope.user.fullName}" readonly required>
                    </div>

                    <div class="form-group">
                        <label for="bookID">
                            <i class="fa-solid fa-book"></i> Book ID
                        </label>
                        <input type="text" id="bookID" name="bookID" class="form-control" 
                               value="${dto.bookID}" readonly required>
                    </div>

                    <div class="form-group">
                        <label for="bookTitle">
                            <i class="fa-solid fa-bookmark"></i> Book Title
                        </label>
                        <input type="text" id="bookTitle" value="${dto.name}" class="form-control" readonly required >

                    </div>

                    <div class="form-group">
                        <label for="currentDueDate">
                            <i class="fa-solid fa-calendar-xmark"></i> Current Due Date
                        </label>
                        <input type="date" id="currentDueDate" name="currentDueDate" class="form-control" 
                               value="${dto.dueDate}" readonly required>
                    </div>

                    <div class="form-group">
                        <label for="extensionDays">
                            <i class="fa-solid fa-calendar-plus"></i> Number of Days to Extend (Max: 30 days)
                        </label>
                        <input type="number" id="extensionDays" name="extensionDays" class="form-control" 
                               min="1" max="30" placeholder="Enter number of days (1-30)" required>
                    </div>


                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" 
                                onclick="window.location.href = '${pageContext.request.contextPath}/borrowing/borrowed'">
                            <i class="fa-solid fa-xmark"></i> Cancel
                        </button>
                        <button type="submit" class="btn btn-primary">                    
                            <i class="fa-solid fa-paper-plane"></i> Submit Request
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <!-- ==== FOOTER ==== -->
        <footer class="footer">
            <div class="footer-content">
                <a href="${pageContext.request.contextPath}/about">About</a>
                <a href="${pageContext.request.contextPath}/contact">Contact</a>
                <a href="${pageContext.request.contextPath}/terms">Terms of Service</a>
            </div>
            <p>&copy; 2025 Library Management System — All rights reserved.</p>
        </footer>
    </body>
</html>