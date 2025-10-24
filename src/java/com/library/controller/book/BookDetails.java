/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.library.controller.book;

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
@WebServlet(name="BookDetails", urlPatterns={"/book/detail"})
public class BookDetails extends HttpServlet {
   
    BookDao bookDao = new BookImplementDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
           String slug = request.getParameter("slug");
           int getBookId = Integer.valueOf(request.getParameter("bookID"));
           request.setAttribute("slug", slug);   
//            
           Books b = bookDao.showBookDetail(slug, getBookId);
                                       
           request.setAttribute("book", b);
           request.getRequestDispatcher("/WEB-INF/views/book/bookdetail.jsp").forward(request, response);
    } 

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
     
    }

}
