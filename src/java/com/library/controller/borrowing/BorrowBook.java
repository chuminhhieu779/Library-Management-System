/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.borrowing;

import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
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
public class BorrowBook extends HttpServlet {
    
    BorrowingService borrowService = new BorrowingService();
    UserDao userDao = new UserImplementDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect("/Login");
            return;
        }
        String slug = request.getParameter("slug");
        int bookID = Integer.parseInt(request.getParameter("bookID"));
        String account = (String) session.getAttribute("account");
        int userID = userDao.findUserID(account);     
           
        if (borrowService.canBorrowBook(bookID, userID)) {
            borrowService.borrowBook(slug, bookID, userID);
            session.setAttribute("success", "you borrowed book !!");            
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
