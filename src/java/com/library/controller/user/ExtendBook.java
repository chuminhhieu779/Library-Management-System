/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingImplement;
import com.library.model.BorrowedBookDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "ExtendBook", urlPatterns = {"/user/extend-books"})
public class ExtendBook extends HttpServlet {

    BorrowingDao borrowDao = new BorrowingImplement();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }
        String account = (String) session.getAttribute("account");
        int bookID = Integer.valueOf(request.getParameter("bookID"));

        LocalDate borrowDate = borrowDao.getBorrowDate(bookID);
        String dueDate = request.getParameter("newDueDate");
        LocalDate newDueDate = LocalDate.parse(dueDate);
        long day = ChronoUnit.DAYS.between(borrowDate, newDueDate); //take day 
        if (day > 60) {
            request.setAttribute("error", "you must not extend the due date by more than 2 months ");
            // load list 
            List<BorrowedBookDTO> borrowedBooks = borrowDao.borrowedBooksList(account);
            request.setAttribute("borrowedBooks", borrowedBooks);
            request.setAttribute("targetBookID", bookID); // show popup when update book is failed 
            request.getRequestDispatcher("/WEB-INF/views/user/borrowedbooks.jsp").forward(request, response);
            return;
        }
        boolean commitExtraDate = borrowDao.extendDueDay(bookID, newDueDate, account);
        if (commitExtraDate) {
            session.setAttribute("extendSuccess", " Due date updated successfully!");
            response.sendRedirect(request.getContextPath() + "/user/borrowed-books?bookID=" + bookID);
        }
    }

}
