/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
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
@WebServlet(name = "DashBoard", urlPatterns = {"/user/dashboard"})
public class UserDashBoardController extends HttpServlet {

    BookDao bookDao = new BookDaoImpl();
    BorrowingDao borrowDao = new BorrowingDaoImpl();         
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {      
        int totalBook = bookDao.totalBook();
        HttpSession session = request.getSession(false);   
        
//        take current user account 
        String account = (String)session.getAttribute("account");
        
        int totalBorrowedBook = borrowDao.totalBorrowedBooks(account);
        int totalReturnedBook = borrowDao.totalReturnedBooks(account);
        request.setAttribute("totalBook", totalBook);
        request.setAttribute("totalReturnedBooks", totalReturnedBook);
        request.setAttribute("totalBorrowedBook", totalBorrowedBook);
        request.getRequestDispatcher("/WEB-INF/views/user/dashboard.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
