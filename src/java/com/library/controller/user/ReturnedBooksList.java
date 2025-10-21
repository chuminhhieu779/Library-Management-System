/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.library.controller.user;

import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingImplement;
import com.library.model.Books;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author hieuchu
 */
@WebServlet(name="ReturnedBooks", urlPatterns={"/user/returned-books"})
public class ReturnedBooksList extends HttpServlet {
   
        BorrowingDao borrowDao = new BorrowingImplement();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if(session == null || session.getAttribute("account") == null){
            response.sendRedirect(request.getContextPath() + "/Login");
            return ;
        }
        String account = (String)session.getAttribute("account");
        List<Books> list = borrowDao.returnedBooksList(account);
        request.setAttribute("returnedBooks", list);
        request.getRequestDispatcher("/WEB-INF/views/user/returnedbook.jsp").forward(request, response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {

    }


}
