/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingImplement;
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
@WebServlet(name = "ReturnBooks", urlPatterns = {"/user/return-books"})
public class ReturnBooks extends HttpServlet {

    BorrowingDao borrowDao = new BorrowingImplement();

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
        boolean commitReturnBook = borrowDao.returnBook(account, slug);
        if (commitReturnBook) {
            session.setAttribute("returnSuccess", "The book was returned successfully!");
            response.sendRedirect(request.getContextPath() + "/user/borrowed-books?slug=" + slug);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
