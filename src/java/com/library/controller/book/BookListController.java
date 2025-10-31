/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.book;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
import com.library.dao.DaoFactory;
import com.library.exception.BookDataAccessException;
import com.library.model.entity.Book;
import com.library.service.BorrowingService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "BookList", urlPatterns = {"/book/list"})
public class BookListController extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(BookListController.class);
    private final BookDao bookDao ;

    public BookListController() {
        this.bookDao = DaoFactory.getBookDao();
    }
       
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            List<Book> bookList = bookDao.getAllBook();
            request.setAttribute("bookList", bookList);
            request.getRequestDispatcher("/WEB-INF/views/book/booklist.jsp").forward(request, response);
        } catch (BookDataAccessException b) {
            logger.error("Error loading books", b);
        }

    }
}
