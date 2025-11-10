# 📚 Library Management System

[![Tests](https://github.com/Suzune705/Library-Management-System/actions/workflows/Run-Tests.yml/badge.svg)](https://github.com/Suzune705/Library-Management-System/actions/workflows/Run-Tests.yml) ![License](https://img.shields.io/github/license/Suzune705/Library-Management-System?style=flat-square&color=1976D2) ![Java 17](https://img.shields.io/badge/Java-17-00897B?style=flat-square&logo=openjdk) ![Ant](https://img.shields.io/badge/Ant-43A047?style=flat-square&logo=apache) ![Tomcat 10.1](https://img.shields.io/badge/Tomcat-10.1-FB8C00?style=flat-square&logo=apachetomcat) ![MSSQL](https://img.shields.io/badge/MSSQL-E53935?style=flat-square&logo=microsoftsqlserver)


A full-stack **Library Management System (LMS)** built with **Java Servlets**, **JSP**, and **Microsoft SQL Server**, following the MVC pattern.  
This project is developed for academic and practical purposes, showcasing backend logic, database interaction, and CI automation via **GitHub Actions**.

---

## ✨ Features

### 👤 User Features
- 🔐 **Authentication** - Secure user registration and login
- 📖 **Book Browsing** - Search and explore the book catalog
- 📚 **Borrowing System** - Borrow and return books seamlessly
- ❤️ **Favorites** - Save your favorite books for quick access
- 📊 **Activity Logs** - Track your borrowing history

### 🛡️ Admin Features
- 📈 **Dashboard** - Comprehensive analytics and insights
- ✏️ **CRUD Operations** - Manage books, users, and categories
- 📋 **Reports** - Generate system reports and statistics
- 👥 **User Management** - Monitor and manage user accounts

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
Library-Management-System/
│
├── 📂 src/java/com/library/
│   ├── 📂 controller/
│   │   ├── 📂 admin/
│   │   │   ├── 📂 book/
│   │   │   └── 📂 user/
│   │   ├── 📂 book/
│   │   ├── 📂 borrowing/
│   │   ├── 📂 favorite/
│   │   └── 📂 user/
│   │
│   ├── 📂 dao/                # Data Access Objects
│   ├── 📂 enums/              # Enum types
│   ├── 📂 exception/          # Custom exceptions
│   ├── 📂 factory/            # Factory patterns
│   │
│   ├── 📂 model/
│   │   ├── 📂 dto/            # Data Transfer Objects
│   │   └── 📂 entity/         # Database entities
│   │
│   ├── 📂 service/            # Business logic
│   └── 📂 util/               # Utility classes
│
├── 📂 web/
│   ├── 📂 WEB-INF/
│   │   └── 📂 views/
│   │       ├── 📂 admin/
│   │       ├── 📂 book/
│   │       ├── 📂 borrowing/
│   │       ├── 📂 components/
│   │       ├── 📂 favorite/
│   │       └── 📂 user/
│   │
│   └── 📂 resources/
│       ├── 📂 css/
│       ├── 📂 images/
│       └── 📂 js/
│
├── 📂 database/               # SQL scripts
├── 📂 lib/                    # External libraries
├── 📂 test/                   # Unit tests
└── build.xml                  # Ant build file
```

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
