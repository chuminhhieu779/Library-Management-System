/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.books;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.library.dao.BookDao;
import com.library.dao.BookImplementDao;
import jakarta.servlet.http.HttpSession;
import com.library.dao.BorrowingDao;
import com.library.dao.BookImplementDao;
import com.library.dao.BorrowingImplement;

/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name = "deleteBooks", urlPatterns = {"/admin/books/delete"})
public class deleteBooks extends HttpServlet {

    BookDao bookDao = new BookImplementDao();
    BorrowingDao borrowDao = new BorrowingImplement();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("adminAccount") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        int bookID = Integer.parseInt(request.getParameter("id"));
        if(borrowDao.canDeleteBook(bookID)){
            borrowDao.deleteBorrowingsByBookId(bookID);
            
            bookDao.deleteBook(bookID);
            session.setAttribute("success", "Completely deleted!");
            response.sendRedirect(request.getContextPath() + "/admin/books");
        }
        else{
            session.setAttribute("error", "The book is currently borrowed!");
            response.sendRedirect(request.getContextPath() + "/admin/books");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
