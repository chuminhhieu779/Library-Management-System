/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.book;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import jakarta.servlet.http.HttpSession;
import com.library.dao.BorrowingDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.BorrowingDaoImpl;
import com.library.factory.DaoFactory;
import com.library.service.BorrowingService;
import com.library.service.RemoveBookService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name = "deleteBooks", urlPatterns = {"/admin/books/delete"})
public class DeleteBookController extends HttpServlet {


    private static final Logger logger = LoggerFactory.getLogger(DeleteBookController.class);
    
    RemoveBookService rmBook = new RemoveBookService(
            DaoFactory.getBookDao(),
            DaoFactory.getBorrowingDao(),
            DaoFactory.getFavoriteDao()
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("adminAccount") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        int bookID = Integer.parseInt(request.getParameter("id"));
        logger.info(" Start delete book ID : {}", bookID);

        if (rmBook.isBookRemoved(bookID)) {
            logger.info("can remove delete book id : {}", bookID);
            session.setAttribute("success", "Completely deleted!");
            response.sendRedirect(request.getContextPath() + "/admin/books");
        } else {
            session.setAttribute("error", "The book is currently borrowed!");
            response.sendRedirect(request.getContextPath() + "/admin/books");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
