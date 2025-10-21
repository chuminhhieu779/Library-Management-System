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
import java.util.List;

/**
 *
 * @author hieuchu
 */
@WebServlet(name="SearchBook", urlPatterns={"/user/search-books"})
public class SearchBook extends HttpServlet {   
    BookDao bookDao = new BookImplementDao();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Books>  b = bookDao.searchBook(query);
        request.setAttribute("searchBook", b);
        request.getRequestDispatcher("/WEB-INF/views/user/searchbook.jsp").forward(request, response);
    } 

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }

}
