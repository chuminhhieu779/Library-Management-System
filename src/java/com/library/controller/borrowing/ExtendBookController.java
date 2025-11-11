/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.borrowing;

import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
import com.library.factory.ServiceFactory;
import com.library.model.dto.BorrowedBookDTO;
import com.library.service.BorrowingService;
import com.library.service.ExtendBookService;
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
@WebServlet(name = "ExtendBook", urlPatterns = {"/borrowing/extend"})
public class ExtendBookController extends HttpServlet {

    BorrowingService borrowService = ServiceFactory.getBorrowService();
    ExtendBookService extendBookService = ServiceFactory.getExtendBookService();

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

        LocalDate borrowDate = borrowService.getBorrowDate(bookID);
        String dueDate = request.getParameter("newDueDate");
        LocalDate newDueDate = LocalDate.parse(dueDate);
          List<BorrowedBookDTO> borrowedBooks = borrowService.borrowedBooksList(account);
          request.setAttribute("borrowedBooks", borrowedBooks);
        long day = ChronoUnit.DAYS.between(borrowDate, newDueDate); //take day 
        if (borrowService.getExtendCount(bookID, account) > 4) {
            session.setAttribute("error", "You’re out of renewals");        
            session.setAttribute("targetBookID", bookID); // show popup when update book is failed             
            request.getRequestDispatcher("/WEB-INF/views/borrowing/borrowedbooks.jsp").forward(request, response);
            return;
        }
        if (day > 60) {
            session.setAttribute("error", "you must not extend the due date by more than 2 months ");
            // load list             
            session.setAttribute("targetBookID", bookID); // show popup when update book is failed       
            request.getRequestDispatcher("/WEB-INF/views/borrowing/borrowedbooks.jsp").forward(request, response);
            return;
        }
        boolean commitExtraDate = extendBookService.extendDueDay(bookID, newDueDate, account);
        if (commitExtraDate) {
            borrowService.incrementExtendCount(bookID, account);
            session.setAttribute("extendSuccess", " Due date updated successfully!");
            response.sendRedirect(request.getContextPath() + "/borrowing/borrowed?bookID=" + bookID);
        }
    }

}
