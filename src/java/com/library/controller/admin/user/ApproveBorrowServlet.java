/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.user;

import com.library.factory.ServiceFactory;
import com.library.service.BorrowingService;
import com.library.service.UserService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.logging.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "ApproveBorrowServlet", urlPatterns = {"/admin/approveBorrow"})
public class ApproveBorrowServlet extends HttpServlet {

    private static final org.slf4j.Logger logger = LoggerFactory.getLogger(ApproveBorrowServlet.class);

    private BorrowingService borrowService = ServiceFactory.getBorrowService();
    private UserService userService = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int borrowId = Integer.parseInt(request.getParameter("borrowId"));
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        String account = (String) request.getSession().getAttribute("account");
        HttpSession session = request.getSession();
        logger.info("Received approve borrow request. borrowId='{}', account='{}'", borrowId, account);

        int adminId = userService.getAminID(account);
        try {
            borrowService.approveBorrowRequest(borrowId, adminId , bookID);
            logger.info("Borrow request {} approved successfully by adminId={}", borrowId, adminId);
            session.setAttribute("success", "approved");
            response.sendRedirect(request.getContextPath() + "/admin/user-borrowing-record");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("success", "failed");
            response.sendRedirect(request.getContextPath() + "/admin/user-borrowing-record");

        }
    }

}
