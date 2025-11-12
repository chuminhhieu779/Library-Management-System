# 📚 Library Management System

[![Tests](https://github.com/Suzune705/Library-Management-System/actions/workflows/Run-Tests.yml/badge.svg)](https://github.com/Suzune705/Library-Management-System/actions/workflows/Run-Tests.yml) ![License](https://img.shields.io/github/license/Suzune705/Library-Management-System?style=flat-square&color=1976D2) ![Java 17](https://img.shields.io/badge/Java-17-00897B?style=flat-square&logo=openjdk) ![Ant](https://img.shields.io/badge/Ant-43A047?style=flat-square&logo=apache) ![Tomcat 10.1](https://img.shields.io/badge/Tomcat-10.1-FB8C00?style=flat-square&logo=apachetomcat) ![MSSQL](https://img.shields.io/badge/MSSQL-E53935?style=flat-square&logo=microsoftsqlserver)


A **Library Management System** (LMS) built with **Java Servlets**, **JSP**, and **Microsoft SQL Server**, following the **MVC pattern**. This project demonstrates concepts like **dependency injection**, **MVC architecture**, **singleton , simple factory patterns** , **lazy and eager initialization**, **SOLID principles such as SRP DIP** , **RBAC** authentication with session and autholization with filter ,  including  **integration testing** as well as **CI automation testing** via GitHub Actions

---

✨ Features

👤 User Features

🔐 Authentication & Account Management

- Secure user registration and login with BCrypt password hashing
- Password change 
- Forgot password with email recovery

📖 Book Discovery & Management

- Search books by title
- Filter books by category (Action, English, Romance, Skill, Technology)
- View detailed book information

📚 Borrowing System
- Borrow available books 
- Extend borrowing period
- Return books
- View borrowing and return history

❤️ Favorites

- Add books to personal favorites list
- Quick access to favorite books

👤 Profile Management

- Update personal information (name, email, avatar)
- View personal dashboard with statistics
- Track total borrowed and returned books

🛡️ Admin Features

📈 Dashboard & Analytics

- Online user count
- Total books statistics
- Borrowed books by category 
- Latest activity logs (login, profile updates, borrowing, returns)

📚 Book Management (CRUD)

- Add new books
- Edit book details
- Delete books 
- Search books 
- View all books

👥 User Management

- View all registered users
- Monitor user status (active/inactive)
- View user borrowing records
- Delete user accounts
- Force logout individual users
- Logout all users

🔒 Access Control
- RBAC (admin/user)
- Enhance Security Page JSP
---

## 🧩 Technologies Used

| Layer                      | Technology / Library                                                                              | Version / Notes                            |
| :------------------------- | :------------------------------------------------------------------------------------------------ | :----------------------------------------- |
| **Frontend**               | HTML5, CSS3, JSP                                                                                  | JSP 3.0 (Jakarta EE 10)                    |
| **Backend**                | Java Servlet (Jakarta Servlet API)                                                                | 6.0 (EE 10)                                |
| **Database**               | Microsoft SQL Server : (mssql-jdbc-13.2.0.jre11.jar)                                              | JDBC driver                                |
| **Version Control**        | Git + GitHub                                                                                      | Quản lý mã nguồn                           |
| **CI/CD**                  | GitHub Actions (Continuous Integration)                                                           | Tự động hóa build và test Java project     |
| **Mail Service**           | Jakarta Mail (`jakarta.mail-2.0.1.jar`), Jakarta Activation (`jakarta.activation-api-2.1.3.jar`)  | Gửi email qua SMTP                         |
| **Security**               | BCrypt (`jbcrypt-0.4.jar`)                                                                        | Mã hóa mật khẩu người dùng                 |
| **Logging**                | SLF4J (`slf4j-api-2.0.17.jar`), Logback (`logback-core-1.5.19.jar`, `logback-classic-1.5.19.jar`) | Ghi log hệ thống                           |
| **Testing**                | JUnit (`junit-4.13.2.jar`), Hamcrest (`hamcrest-core-1.3.jar`)                                    | Integration testing                        |
| **In-Memory DB (Testing)** | H2 Database (`h2-1.3.176.jar`)                                                                    | Database cho testing                       |
| **JSP Tag Library**        | JSTL (`jakarta.servlet.jsp.jstl-3.0.1.jar`)                                                       | Thư viện thẻ JSP chuẩn                     |



---

## 🚀 Quick Start

### Prerequisites
- ☕ Java JDK 17 or higher
- 🗄️ Microsoft SQL Server
- 🐱 Apache Tomcat 10.1.44
- 🔧 Apache NetBeans 17 (recommended)


## 📁 Project Structure

```
LibraryManagement/
│
├── 📂 Web Pages/
│   ├── 📂 META-INF/
│   ├── 📂 WEB-INF/
│   │   ├── 📂 lib/
│   │   └── 📂 views/
│   │       ├── 📂 admin/
│   │       ├── 📂 book/
│   │       ├── 📂 borrowing/
│   │       ├── 📂 components/
│   │       ├── 📂 favorite/
│   │       ├── 📂 user/
│   │       └── 📄 homepage.jsp
│   │
│   └── 📂 resources/
│       ├── 📂 css/
│       └── 📂 images/
│
├── 📂 Source Packages/
│   └── 📂 com/
│       └── 📂 library/
│           ├── 📂 controller/
│           │   ├── 📂 admin/
│           │   ├── 📂 book/
│           │   ├── 📂 borrowing/
│           │   ├── 📂 favorite/
│           │   ├── 📂 filter/
│           │   └── 📂 user/
│           │
│           ├── 📂 dao/
│           ├── 📂 enums/
│           ├── 📂 exception/
│           ├── 📂 factory/
│           ├── 📂 model/
│           │   ├── 📂 dto/
│           │   └── 📂 entity/
│           ├── 📂 service/
│           └── 📂 util/
│
└── 📂 Test Packages/
    └── 📂 com/
        └── 📂 library/
            ├── 📂 dao/
            ├── 📂 util/
            └── 📄 Library_Management_v7.sql

---

## 🔄 CI/CD Pipeline

This project uses **GitHub Actions** for automated testing:

- ✅ Automated unit tests on every push
- 🔍 Code quality checks
- 📦 Build verification

---

## 🎨 Design Patterns

The project implements several design patterns to ensure clean, maintainable, and scalable code:

- 🏭 **Factory Pattern** - Centralized object creation (DaoFactory, ServiceFactory)
- 🎯 **MVC Pattern** - Separation of Model, View, and Controller
- 📦 **DTO Pattern** - Data transfer between layers
- 🔌 **DAO Pattern** - Abstract database operations
- 🛡️ **Singleton Pattern** - Single instance management (DBConnection, SessionTracker)
- 🎭 **Service Layer Pattern** - Business logic separation
- 🔒 **Exception Hierarchy Pattern** - Structured error handling

---


## 📝 License

This project is licensed under the terms specified in the LICENSE file.

---


<div align="center">
  <sub>Built with ❤️ using Java and Jakarta EE</sub>
</div>
