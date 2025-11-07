# 📚 Library Management System

[![Run Tests](https://github.com/Suzune705/Library-Management-System/actions/workflows/Run-Tests.yml/badge.svg)](https://github.com/Suzune705/Library-Management-System/actions/workflows/Run-Tests.yml)
![License](https://img.shields.io/github/license/Suzune705/Library-Management-System?color=00C853&logo=opensourceinitiative&logoColor=white)
![Java](https://img.shields.io/badge/Java-17-007396?style=flat&logo=openjdk&logoColor=white)
![Build Tool](https://img.shields.io/badge/Build_Tool-Apache_Ant-A80030?style=flat&logo=apache&logoColor=white)
![Server](https://img.shields.io/badge/Server-Tomcat_10.1.44-F8DC75?style=flat&logo=apachetomcat&logoColor=black)
![Database](https://img.shields.io/badge/Database-MS_SQL_Server-CC2927?style=flat&logo=microsoftsqlserver&logoColor=white)

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

| Layer | Technology | Version / Notes |
|:------|:------------|:----------------|
| **Frontend** | HTML5, CSS3, JSP | JSP 3.0 (Jakarta EE 10) |
| **Backend** | Java Servlet (Jakarta Servlet API) | 6.0 (EE 10) |
| **Database** | Microsoft SQL Server | JDBC driver: `mssql-jdbc-13.2.0.jre11.jar` |
| **Server** | Apache Tomcat / TomEE | 10.1.44 |
| **JDK** | Java SE Development Kit | 17 |
| **IDE** | Apache NetBeans | 17 |
| **Build Tool** | Apache Ant | — |
| **Version Control** | Git + GitHub | — |

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
