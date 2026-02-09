/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.borrowing;

import com.library.factory.ServiceFactory;
import com.library.service.ActivityService;
import com.library.service.BorrowingService;
import java.io.IOException;
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

    private final BorrowingService borrowService;
    private final ActivityService activityService;

    public BorrowBookController(BorrowingService borrowService, ActivityService activityService) {
        this.borrowService = borrowService;
        this.activityService = activityService;
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      
        HttpSession session = request.getSession(false);
        if (session == null) {
//book.list           
            response.sendRedirect(request.getContextPath() + "/book/detail");
            return;
        }
// book/list
        if (session.getAttribute("account") == null) {
            session.setAttribute("success", "you have to login before using our service!");
            response.sendRedirect(request.getContextPath() + "/book/detail"); 
            return;
        }
// slug       
        String slug = request.getParameter("slug");
        int bookID = Integer.parseInt(request.getParameter("bookID"));
// account        
        String account = (String) session.getAttribute("accout");

        
        int userID = borrowService.getUserIDByAccount(account);

        if (borrowService.canBorrowBook(bookID, userID)) {
            borrowService.borrowBook(slug, bookID, userID);
            activityService.BookActivityOfUser(account, 3, bookID);
            session.setAttribute("success", "borrow book request has sent!!");
        } else {
            // fix :    session.setAttribute("failed", "you already borrowed this book !!!");
            session.setAttribute("failed", "you already borrowed this book !!!");
        }
        response.sendRedirect(request.getContextPath() + "/book/detail?slug=" + slug + "&bookID=" + bookID);
    }

}
