<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://jakarta.ee/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Settings - Library Management</title>
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

            /* ==== USER MENU ==== */
            .user-menu {
                position: relative;
                display: inline-block;
            }

            .user-menu::after {
                content: "";
                position: absolute;
                top: 38px;
                right: 0;
                width: 100%;
                height: 20px;
            }

            .avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                object-fit: cover;
                cursor: pointer;
                border: 2px solid #a5b4fc;
                transition: transform 0.2s ease;
            }

            .avatar:hover {
                transform: scale(1.05);
            }

            /* Dropdown menu */
            .dropdown {
                opacity: 0;
                visibility: hidden;
                position: absolute;
                right: 0;
                top: 55px;
                background: #1f2937;
                color: #e5e7eb;
                width: 220px;
                border-radius: 12px;
                box-shadow: 0 5px 20px rgba(0,0,0,0.2);
                z-index: 10;
                padding: 15px;
                transition: opacity 0.2s ease, transform 0.2s ease;
                transform: translateY(-5px);
            }

            .user-menu:hover .dropdown {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .dropdown .user-info {
                text-align: center;
            }

            .avatar-large {
                width: 60px;
                height: 60px;
                border-radius: 50%;
                border: 2px solid #6366f1;
                object-fit: cover;
                margin-bottom: 8px;
            }

            .username {
                font-weight: 600;
                font-size: 16px;
                margin: 2px 0;
            }

            .role {
                font-size: 13px;
                color: #9ca3af;
            }

            .dropdown-item {
                display: block;
                color: #e5e7eb;
                text-decoration: none;
                font-size: 14px;
                padding: 8px 0;
                transition: color 0.25s;
            }

            .dropdown-item:hover {
                color: #a5b4fc;
            }

            .logout {
                color: #f87171;
            }

            .logout:hover {
                color: #ef4444;
            }


            /* ==== MAIN CONTENT ==== */
            .settings-container {
                flex: 1;
                padding: 40px 60px;
                max-width: 1200px;
                margin: 0 auto;
                width: 100%;
            }

            /* ==== BACK LINK ==== */
            .back-link {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                margin-bottom: 20px;
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
                margin-bottom: 40px;
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

            /* ==== SETTINGS SECTIONS ==== */
            .settings-grid {
                display: grid;
                gap: 30px;
            }

            .settings-section {
                background: #fff;
                border-radius: 12px;
                padding: 30px;
                box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
            }

            .section-title {
                font-size: 18px;
                font-weight: 700;
                color: #1f2937;
                margin-bottom: 20px;
                padding-bottom: 10px;
                border-bottom: 2px solid #f3f4f6;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .section-title i {
                color: #4f46e5;
                font-size: 20px;
            }

            /* ==== FORM STYLES ==== */
            .form-group {
                margin-bottom: 20px;
            }

            .form-group label {
                display: block;
                font-weight: 600;
                color: #374151;
                margin-bottom: 8px;
            }

            .form-control {
                width: 100%;
                padding: 12px;
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
            }

            /* ==== BUTTONS ==== */
            .btn {
                padding: 12px 24px;
                border: none;
                border-radius: 8px;
                font-size: 15px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }

            .btn-primary {
                background: linear-gradient(135deg, #4f46e5, #3b82f6);
                color: #fff;
            }

            .btn-primary:hover {
                background: linear-gradient(135deg, #3b82f6, #2563eb);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(59, 130, 246, 0.3);
            }

            .btn-danger {
                background: linear-gradient(135deg, #ef4444, #dc2626);
                color: #fff;
            }

            .btn-danger:hover {
                background: linear-gradient(135deg, #dc2626, #b91c1c);
                transform: translateY(-2px);
                box-shadow: 0 4px 10px rgba(239, 68, 68, 0.3);
            }

            .btn-secondary {
                background: #6b7280;
                color: #fff;
            }

            .btn-secondary:hover {
                background: #4b5563;
            }

            /* ==== ALERTS ==== */
            .alert {
                padding: 12px 16px;
                border-radius: 8px;
                margin-bottom: 20px;
                font-size: 14px;
                display: flex;
                align-items: center;
                gap: 10px;
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

            /* ==== PROFILE INFO ==== */
            .profile-info {
                display: flex;
                align-items: center;
                gap: 20px;
                padding: 20px;
                background: #f9fafb;
                border-radius: 12px;
                margin-bottom: 25px;
            }

            .profile-avatar {
                width: 80px;
                height: 80px;
                border-radius: 50%;
                object-fit: cover;
                border: 3px solid #4f46e5;
            }

            .profile-details h3 {
                font-size: 20px;
                color: #1f2937;
                margin-bottom: 5px;
            }

            .profile-details p {
                color: #6b7280;
                font-size: 14px;
            }

            /* ==== PREFERENCE ITEMS ==== */
            .preference-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 0;
                border-bottom: 1px solid #f3f4f6;
            }

            .preference-item:last-child {
                border-bottom: none;
            }

            .preference-label {
                font-weight: 500;
                color: #374151;
            }

            .preference-description {
                font-size: 13px;
                color: #6b7280;
                margin-top: 4px;
            }

            /* ==== TOGGLE SWITCH ==== */
            .toggle-switch {
                position: relative;
                width: 50px;
                height: 26px;
            }

            .toggle-switch input {
                opacity: 0;
                width: 0;
                height: 0;
            }

            .toggle-slider {
                position: absolute;
                cursor: pointer;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background-color: #d1d5db;
                transition: 0.3s;
                border-radius: 34px;
            }

            .toggle-slider:before {
                position: absolute;
                content: "";
                height: 18px;
                width: 18px;
                left: 4px;
                bottom: 4px;
                background-color: white;
                transition: 0.3s;
                border-radius: 50%;
            }

            input:checked + .toggle-slider {
                background-color: #4f46e5;
            }

            input:checked + .toggle-slider:before {
                transform: translateX(24px);
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

            @media (max-width: 768px) {
                .settings-container {
                    padding: 20px;
                }

                .profile-info {
                    flex-direction: column;
                    text-align: center;
                }
            }
        </style>

        <script>
     
            function toggleEdit(fieldId) {
                const input = document.getElementById(fieldId);
                const saveBtn = document.getElementById('saveProfileBtn');

                // Kiểm tra xem input có phải là type="file" không
                const isFile = input.type === 'file';

                let isCurrentlyLocked = isFile ? input.disabled : input.readOnly;

                if (isCurrentlyLocked) {
                    // Mở khóa trường nhập liệu
                    if (isFile) {
                        input.disabled = false; // Dùng disabled cho file
                    } else {
                        input.readOnly = false; // Dùng readOnly cho text
                        input.focus();
                    }

 
                    saveBtn.style.display = 'inline-flex';
                } else {
       
                    if (isFile) {
                        input.disabled = true;
                    } else {
                        input.readOnly = true;
                    }
  
                }
            }

            // Preview avatar before upload
            function previewAvatar(input) {
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('profileAvatarPreview').src = e.target.result;
                    };
                    reader.readAsDataURL(input.files[0]);
                }
            }
        </script>
    </head>

    <body>
        <!-- ==== NAVBAR ==== -->
        <nav class="navbar">
            <span class="logo">📚 Library System</span>

            <div class="user-menu">
                <img src="${pageContext.request.contextPath}/resources/images/${sessionScope.user.avatar}" 
                     alt="User Avatar" class="avatar">

                <div class="dropdown">
                    <div class="user-info">
                        <img src="${pageContext.request.contextPath}/resources/images/${sessionScope.user.avatar}" 
                             alt="User Avatar Large" class="avatar-large">
                        <p class="username">${sessionScope.user.fullName}</p>
                        <p class="role">Library Member</p>
                    </div>
                    <hr>
                    <a href="${pageContext.request.contextPath}/user/dashboard" class="dropdown-item">
                        <i class="fa-solid fa-user"></i> DashBoard
                    </a>     
                    <a href="${pageContext.request.contextPath}/favorite/books" class="dropdown-item">
                        <i class="fa-solid fa-heart"></i> Favorite 
                    </a>     
                    <a href="${pageContext.request.contextPath}/user/setting" class="dropdown-item">
                        <i class="fa-solid fa-gear"></i> Setting
                    </a> 
                    <a href="${pageContext.request.contextPath}/LogOut" class="dropdown-item logout">
                        <i class="fa-solid fa-right-from-bracket"></i> Logout
                    </a>
                </div>
            </div>
        </nav>

        <!-- ==== MAIN CONTENT ==== -->
        <div class="settings-container">
            <a class="back-link" href="${pageContext.request.contextPath}/user/dashboard">
                <i class="fa-solid fa-arrow-left"></i> Back to Dashboard
            </a>

            <div class="page-title">
                <h2>Account Settings</h2>
            </div>

            <!-- Success/Error Messages -->


            <div class="settings-grid">
                <!-- Profile Information -->
                <div class="settings-section">
                    <h3 class="section-title">
                        <i class="fa-solid fa-user-circle"></i>
                        Profile Information
                    </h3>

                    <div class="profile-info">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.avatar}">
                                <img src="${pageContext.request.contextPath}/resources/images/${sessionScope.user.avatar}" 
                                     alt="Profile" class="profile-avatar" id="profileAvatarPreview">
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/images/1.jpg" 
                                     alt="Default Avatar" class="profile-avatar" id="profileAvatarPreview">
                            </c:otherwise>
                        </c:choose>

                    </div>
                    <c:if test="${not empty isUpdated}">
                        <div class="alert alert-info">${isUpdated}</div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/user/update-profile" method="post" enctype="multipart/form-data">
                        <div class="form-group">
                            <label for="userID">User ID</label>
                            <input type="text" id="userID" class="form-control" 
                                   value="${sessionScope.user.userID}" readonly>
                        </div>

                        <div class="form-group">
                            <label for="fullname">Full Name</label>
                            <div style="display: flex; gap: 10px;">
                                <input type="text" id="fullname" name="fullName" class="form-control" 
                                       value="${sessionScope.user.fullName}" readonly required>
                                <button type="button" class="btn btn-secondary" onclick="toggleEdit('fullname')">
                                    <i class="fa-solid fa-pen"></i> Edit
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="account">Account</label>
                            <div style="display: flex; gap: 10px;">
                                <input type="text" id="account" name="account" class="form-control" 
                                       value="${sessionScope.user.account}" readonly required>
                                <button type="button" class="btn btn-secondary" onclick="toggleEdit('account')">
                                    <i class="fa-solid fa-pen"></i> Edit
                                </button>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="avatar">Avatar</label>
                            <div style="display: flex; gap: 10px; align-items: center;">
                                <input type="file" id="avatar" name="avatar" class="form-control" 
                                       accept="image/*" disabled onchange="previewAvatar(this)">
                                <button type="button" class="btn btn-secondary" onclick="toggleEdit('avatar')">
                                    <i class="fa-solid fa-pen"></i> Edit
                                </button>
                            </div>
                            <small style="color: #6b7280; display: block; margin-top: 5px;">
                                Current: ${sessionScope.user.avatar != null ? sessionScope.user.avatar : 'Default avatar'}
                            </small>
                        </div>

                        <button type="submit" class="btn btn-primary" id="saveProfileBtn" style="display: none;">
                            <i class="fa-solid fa-floppy-disk"></i> Save Changes
                        </button>
                    </form>
                </div>

                <!-- Change Password -->
                <div class="settings-section">
                    <h3 class="section-title">
                        <i class="fa-solid fa-lock"></i>
                        Change Password
                    </h3>

                    <form action="${pageContext.request.contextPath}/user/change-password" method="post">
                        <div class="form-group">
                            <label for="currentPassword">Current Password</label>
                            <input type="password" id="currentPassword" name="currentPassword" 
                                   class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="newPassword">New Password</label>
                            <input type="password" id="newPassword" name="newPassword" 
                                   class="form-control" required>
                        </div>

                        <div class="form-group">
                            <label for="confirmPassword">Confirm New Password</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" 
                                   class="form-control" required>
                        </div>

                        <button type="submit" class="btn btn-primary">
                            <i class="fa-solid fa-key"></i> Update Password
                        </button>
                    </form>
                </div>

                <!-- Notification Preferences -->
                <div class="settings-section">
                    <h3 class="section-title">
                        <i class="fa-solid fa-bell"></i>
                        Notification Preferences
                    </h3>

                    <form action="${pageContext.request.contextPath}/user/update-notifications" method="post">
                        <div class="preference-item">
                            <div>
                                <div class="preference-label">Email Notifications</div>
                                <div class="preference-description">Receive email updates about your borrowed books</div>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" name="emailNotifications" checked>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>

                        <div class="preference-item">
                            <div>
                                <div class="preference-label">Due Date Reminders</div>
                                <div class="preference-description">Get reminded 3 days before book due date</div>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" name="dueDateReminders" checked>
                                <span class="toggle-slider"></span>
                            </label>
                        </div>

                        <div class="preference-item">
                            <div>
                                <div class="preference-label">New Book Alerts</div>
                                <div class="preference-description">Be notified when new books are added</div>
                            </div>
                            <label class="toggle-switch">
                                <input type="checkbox" name="newBookAlerts">
                                <span class="toggle-slider"></span>
                            </label>
                        </div>

                        <button type="submit" class="btn btn-primary" style="margin-top: 15px;">
                            <i class="fa-solid fa-floppy-disk"></i> Save Preferences
                        </button>
                    </form>
                </div>


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
