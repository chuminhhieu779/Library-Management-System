<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - Library Management System</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
        <style>
            /* ==== RESET ==== */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            html, body {
                height: 100%;
            }

            body {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                background: #f4f6f8;
                color: #333;
            }

            /* ==== HEADER ==== */
            header {
                background: rgba(17, 24, 39, 0.95);
                border-bottom: 2px solid #4f46e5;
                padding: 12px 60px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .logo-section {
                display: flex;
                align-items: center;
            }
            .logo-section img {
                height: 42px;
                width: 42px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 10px;
                border: 2px solid #6366f1;
            }
            .logo-section h3 {
                font-size: 1.3em;
                font-weight: 700;
                color: #e5e7eb;
            }

            nav ul {
                list-style: none;
                display: flex;
                gap: 30px;
            }
            nav ul li a {
                color: #fff;
                text-decoration: none;
                font-weight: 500;
                font-size: 16px;
                transition: color 0.3s;
            }
            nav ul li a:hover {
                color: #a5b4fc;
            }

            /* ==== ADMIN MENU ==== */
            .admin-menu {
                position: relative;
                display: inline-block;
            }
            .admin-avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                object-fit: cover;
                cursor: pointer;
                border: 2px solid #a5b4fc;
                transition: transform 0.2s ease;
            }
            .admin-avatar:hover {
                transform: scale(1.05);
            }
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
            .admin-menu:hover .dropdown {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }

            .dropdown .admin-info {
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
            .admin-name {
                font-weight: 600;
                font-size: 16px;
                margin: 2px 0;
            }
            .admin-role {
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

            /* ==== MAIN ==== */
            main {
                flex: 1;
                padding: 40px 60px;
            }
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

            /* ==== STATS ==== */
            .stats-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
                gap: 25px;
                margin-bottom: 40px;
            }
            .stat-card {
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
                display: flex;
                align-items: center;
                gap: 20px;
                transition: transform 0.2s ease, box-shadow 0.2s ease;
            }
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 18px rgba(99,102,241,0.15);
            }
            .stat-icon {
                width: 60px;
                height: 60px;
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 28px;
                color: #fff;
            }
            .stat-icon.blue {
                background: linear-gradient(135deg,#3b82f6,#2563eb);
            }
            .stat-icon.green {
                background: linear-gradient(135deg,#22c55e,#16a34a);
            }
            .stat-icon.orange {
                background: linear-gradient(135deg,#f59e0b,#d97706);
            }
            .stat-icon.purple {
                background: linear-gradient(135deg,#a855f7,#9333ea);
            }

            .stat-info h4 {
                font-size: 28px;
                color: #1f2937;
                margin-bottom: 5px;
            }
            .stat-info p {
                color: #6b7280;
                font-size: 14px;
            }

            /* ==== RECENT ACTIVITY ==== */
            .recent-activity {
                background: #fff;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 3px 10px rgba(0,0,0,0.08);
            }
            .activity-list {
                list-style: none;
            }
            .activity-item {
                padding: 15px 0;
                border-bottom: 1px solid #f3f4f6;
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .activity-item:last-child {
                border-bottom: none;
            }
            .activity-icon {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 16px;
                flex-shrink: 0;
            }
            .activity-icon.success {
                background: #ecfdf5;
                color: #22c55e;
            }
            .activity-icon.info {
                background: #dbeafe;
                color: #3b82f6;
            }
            .activity-icon.warning {
                background: #fef3c7;
                color: #f59e0b;
            }
            .activity-content {
                flex: 1;
            }
            .activity-content h6 {
                font-size: 14px;
                color: #1f2937;
                margin-bottom: 3px;
            }
            .activity-content p {
                font-size: 12px;
                color: #6b7280;
            }
            .activity-time {
                font-size: 12px;
                color: #9ca3af;
            }

            /* ==== FOOTER ==== */
            .footer {
                background: linear-gradient(135deg,#111827,#1f2937);
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

            @media (max-width:768px) {
                header {
                    padding: 12px 20px;
                }
                main {
                    padding: 20px;
                }
                .stats-grid {
                    grid-template-columns: 1fr;
                }
            }
            /* ==== ACTIVITY TEXT ENHANCEMENT ==== */

            /* Tên hành động (action) */
            .activity-content h6 {
                font-size: 15px;
                font-weight: 700;
                text-transform: capitalize;
                color: #111827;
                margin-bottom: 4px;
            }


            .activity-content p {
                font-size: 13px;
                color: #374151;
                margin: 0;
            }


            .activity-time {
                font-size: 12px;
                font-weight: 600;
                color: #6366f1;
                margin-left: auto;
            }

        </style>
    </head>

    <body>
        <!-- ==== HEADER ==== -->
        <header>
            <div class="logo-section">
                <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="Logo">
                <h3>Library Management System</h3>
            </div>
            <nav>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/admin/books">Manage Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/user-borrowing-record">User Borrowing Record</a></li>
                    <li><a href="${pageContext.request.contextPath}/admin/user-manager">User Manager</a></li>
                </ul>
            </nav>
            <div class="admin-menu">
                <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="Admin Avatar" class="admin-avatar">
                <div class="dropdown">
                    <div class="admin-info">
                        <img src="${pageContext.request.contextPath}/resources/images/avatar.jpg" alt="Admin Avatar" class="avatar-large">
                        <p class="admin-name">${sessionScope.admin.username}</p>
                        <p class="admin-role">Administrator</p>
                    </div>
                    <hr>
                    <a href="${pageContext.request.contextPath}/admin/profile" class="dropdown-item"><i class="fa-solid fa-user"></i> Profile</a>
                    <a href="${pageContext.request.contextPath}/admin/settings" class="dropdown-item"><i class="fa-solid fa-gear"></i> Settings</a>
                    <a href="${pageContext.request.contextPath}/admin/logout" class="dropdown-item logout"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                </div>
            </div>
        </header>

        <!-- ==== MAIN ==== -->
        <main>
            <div class="page-title"><h2>Admin Dashboard</h2></div>

            <!-- STATS -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon blue"><i class="fa-solid fa-book"></i></div>
                    <div class="stat-info"><h4>${dto.totalBook}</h4><p>Total Books</p></div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon green"><i class="fa-solid fa-users"></i></div>
                    <div class="stat-info"><h4>${dto.totalOnlineUser}</h4><p>Online Users</p></div>
                </div>

        
                <a href="${pageContext.request.contextPath}/admin/extend-request-manger" style="text-decoration: none;">
                    <div class="stat-card" style="cursor:pointer;">
                        <div class="stat-icon orange"><i class="fa-solid fa-book-open-reader"></i></div>
                        <div class="stat-info">
                            <h4></h4>
                            <p>Active Borrowings</p>
                        </div>
                    </div>
                </a>

                <div class="stat-card">
                    <div class="stat-icon purple"><i class="fa-solid fa-clock-rotate-left"></i></div>
                    <div class="stat-info"><h4></h4><p>Overdue Books</p></div>
                </div>
            </div>

            <!-- ===== DEMO CKEDITOR + CHART.JS ===== -->
            <section style="margin-top:60px; padding: 30px; background: #fff; border-radius: 12px; box-shadow: 0 3px 10px rgba(0,0,0,0.1);">                


                <canvas id="demoChart" width="500" height="150"></canvas>
            </section>



            <!-- Chart.js script -->
            <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
            <script>

                const labels = [
                <c:forEach var="entry" items="${map}" varStatus="loop">
                '${entry.key}'<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
                ];


                const data = [
                <c:forEach var="entry" items="${map}" varStatus="loop">
                    ${entry.value}<c:if test="${!loop.last}">,</c:if>
                </c:forEach>
                ];

                const ctx = document.getElementById('demoChart');
                const demoChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [{
                                label: 'Borrowed Books by Category',
                                data: data,
                                backgroundColor: [
                                    'rgba(99, 102, 241, 0.6)',
                                    'rgba(34, 197, 94, 0.6)',
                                    'rgba(59, 130, 246, 0.6)',
                                    'rgba(234, 179, 8, 0.6)',
                                    'rgba(239, 68, 68, 0.6)'
                                ],
                                borderColor: [
                                    'rgba(99, 102, 241, 1)',
                                    'rgba(34, 197, 94, 1)',
                                    'rgba(59, 130, 246, 1)',
                                    'rgba(234, 179, 8, 1)',
                                    'rgba(239, 68, 68, 1)'
                                ],
                                borderWidth: 1
                            }]
                    },
                    options: {
                        scales: {
                            y: {
                                beginAtZero: true,
                                ticks: {color: '#111827', font: {size: 14, weight: 'bold'}}
                            },
                            x: {
                                ticks: {
                                    color: '#4f46e5',
                                    font: {size: 14, weight: '600', family: 'Segoe UI'},
                                },
                                grid: {display: false}
                            }
                        },
                        plugins: {
                            legend: {display: false},
                            title: {
                                display: true,
                                text: 'Borrowed Books by Category',
                                padding: {bottom: 30},
                                font: {size: 18, weight: 'bold'},
                                color: '#1f2937'
                            }
                        }
                    }
                });

            </script>
            <!-- ===== END DEMO ===== -->
            <div style="height: 50px;"></div>    
            <!-- RECENT ACTIVITY -->
            <div class="recent-activity">
                <h3 class="section-header">Recent Activity</h3>
                <ul class="activity-list">
                    <c:forEach var="a" items="${dto.actionList}">
                        <li class="activity-item">
                            <div class="activity-icon info">
                                <i class="fa-solid fa-bell"></i>
                            </div>
                            <div class="activity-content">
                                <h6>${a.action.type.value}</h6>
                                <p>${a.detail}</p>
                            </div>
                            <span class="activity-time">${a.log_time}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>
        </main>

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
