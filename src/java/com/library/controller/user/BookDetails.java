/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.library.controller.user;

import com.library.dao.BookDao;
import com.library.dao.BookImplementDao;
import com.library.model.Books;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author hieuchu
 */
@WebServlet(name="BookDetails", urlPatterns={"/user/bookdetail"})
public class BookDetails extends HttpServlet {
   
    BookDao bookDao = new BookImplementDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
           String slug = request.getParameter("name");
           request.setAttribute("slug", slug);
           
           Books b = bookDao.showBookDetail(slug);
           request.setAttribute("book", b);
           request.getRequestDispatcher("/WEB-INF/views/user/bookdetail.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     
    }

}
