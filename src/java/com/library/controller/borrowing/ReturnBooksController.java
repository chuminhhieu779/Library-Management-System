/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.borrowing;

import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
import com.library.dao.DaoFactory;
import com.library.service.ActivityService;
import com.library.service.BorrowingService;
import com.library.service.ReturnService;
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
@WebServlet(name = "ReturnBooks", urlPatterns = {"/borrowing/return"})
public class ReturnBooksController extends HttpServlet {

    private final ReturnService returnService = new ReturnService(
            DaoFactory.getBookDao(),
            DaoFactory.getBorrowingDao()
    );
    private final ActivityService activityService = new ActivityService(
            DaoFactory.getActivityDao(),
            DaoFactory.getActionDao(),
            DaoFactory.getUserDao(),
            DaoFactory.getBookDao()
    );

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }
        String account = (String) session.getAttribute("account");
        String slug = request.getParameter("slug");
        int bookID = returnService.getBookIDBySlug(slug);
        boolean commitReturnBook = returnService.returnBook(account, slug);
        if (commitReturnBook) {
            activityService.BookActivityOfUser(account, 4, bookID);
            session.setAttribute("returnSuccess", "The book was returned successfully!");
            response.sendRedirect(request.getContextPath() + "/borrowing/borrowed?slug=" + slug);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
