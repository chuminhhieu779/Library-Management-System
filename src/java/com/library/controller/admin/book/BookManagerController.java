/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.book;

import com.library.controller.book.BookListController;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import com.library.model.entity.Book;
import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.exception.BookDataAccessException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@WebServlet(name = "managerBooks", urlPatterns = {"/admin/books"})
public class BookManagerController extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(BookManagerController.class);
    BookDao bookDao = new BookDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String success = (String) session.getAttribute("success");
        request.setAttribute("successMessage", success);
        session.removeAttribute("success");
        String error = (String) session.getAttribute("error");
        request.setAttribute("errorMessage", error);
        session.removeAttribute("error");
        String addBook = (String) session.getAttribute("addBookNotice");
        String deleteBook = (String) session.getAttribute("deleteBookNotice");
        String cursorParam = request.getParameter("cursor");
        String limitParam = request.getParameter("limit");
        int cursor = (cursorParam == null) ? 0 : Integer.parseInt(cursorParam);
        int limit = (limitParam == null) ? 10 : Integer.parseInt(limitParam);
        String search = request.getParameter("search");
        List<Book> bookList;
        try {

            if (search != null && !search.trim().isEmpty()) {

                bookList = bookDao.searchBookByCursor(search.trim(), cursor, limit);

                int nextCursor = bookList.isEmpty() ? 0 : bookList.get(bookList.size() - 1).getBookID();
                request.setAttribute("bookList", bookList);
                request.setAttribute("nextCursor", nextCursor);
                request.setAttribute("limit", limit);
                request.setAttribute("search", search);

                request.getRequestDispatcher("/WEB-INF/views/admin/managerBook.jsp").forward(request, response);
                return;
            }

            bookList = bookDao.getBooksByCursor(cursor, limit);
            int nextCursor = bookList.isEmpty() ? 0 : bookList.get(bookList.size() - 1).getBookID();
            request.setAttribute("bookList", bookList);
            request.setAttribute("nextCursor", nextCursor);
            request.setAttribute("limit", limit);

            request.getRequestDispatcher("/WEB-INF/views/admin/managerBook.jsp").forward(request, response);
        } catch (BookDataAccessException e) {
            logger.error("Error loading books", e);
            request.setAttribute("errorMessage", "Failed to load books.");
            request.getRequestDispatcher("/WEB-INF/views/admin/managerBook.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
