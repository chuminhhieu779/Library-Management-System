/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.books;

import com.library.controller.book.BookList;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import com.library.model.Books;
import com.library.dao.BookDao;
import com.library.dao.BookImplementDao;
import com.library.exception.BookDataAccessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet(name = "managerBooks", urlPatterns = {"/admin/books"})
public class managerBooks extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(BookList.class);
    BookDao bookDao = new BookImplementDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("adminAccount") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        String success = (String) session.getAttribute("success");
        request.setAttribute("successMessage", success);
        session.removeAttribute("success");
        String error = (String) session.getAttribute("error");
        request.setAttribute("errorMessage", error);
        session.removeAttribute("error");

        String search = request.getParameter("search");
        if (search == null || search.trim().isEmpty()) {
            try {
                List<Books> bookList = bookDao.getAllBook();
                request.setAttribute("bookList", bookList);
                request.getRequestDispatcher("/WEB-INF/views/admin/managerBook.jsp").forward(request, response);
            } catch (BookDataAccessException e) {
                logger.error("Error loading books", e);
            }
        } else {
               List<Books> bookList = bookDao.searchBook(search);
               request.setAttribute("bookList", bookList);
               request.getRequestDispatcher("/WEB-INF/views/admin/managerBook.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
