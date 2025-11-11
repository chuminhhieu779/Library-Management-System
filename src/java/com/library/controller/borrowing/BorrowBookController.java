/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.borrowing;

import com.library.dao.BookDao;
import com.library.dao.BorrowingDao;
import com.library.factory.DaoFactory;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.factory.ServiceFactory;
import com.library.service.ActivityService;
import com.library.service.BorrowingService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "BorrowBook", urlPatterns = {"/borrowing/borrow"})
public class BorrowBookController extends HttpServlet {

    private final BorrowingService borrowService = ServiceFactory.getBorrowService();
    private final ActivityService activityService = ServiceFactory.getActivityService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            session.setAttribute("error", "you have to login before using our service!");
            response.sendRedirect(request.getContextPath() + "/book/detail");
            return;
        }
        String slug = request.getParameter("slug");
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        String account = (String) session.getAttribute("account");

        int userID = borrowService.getUserIDByAccount(account);

        if (borrowService.canBorrowBook(bookID, userID)) {
            borrowService.borrowBook(slug, bookID, userID);
            activityService.BookActivityOfUser(account, 3, bookID);
            session.setAttribute("success", "borrow book request has sent  !!");
        } else {
            session.setAttribute("failed", "you already borrowed this book !!!");
        }
        response.sendRedirect(request.getContextPath() + "/book/detail?slug=" + slug + "&bookID=" + bookID);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
