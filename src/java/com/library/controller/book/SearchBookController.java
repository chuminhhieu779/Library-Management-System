/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.book;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.DaoFactory;
import com.library.exception.ValidationException;
import com.library.model.entity.Book;
import com.library.service.BookService;
import com.library.util.Validator;
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
@WebServlet(name = "SearchBook", urlPatterns = {"/book/search"})
public class SearchBookController extends HttpServlet {

    BookService bookService = new BookService(
           DaoFactory.getBookDao()
    );
 
        
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String query = request.getParameter("query");        
        if (query == null) {
            request.getRequestDispatcher("/WEB-INF/views/book/searchbook.jsp").forward(request, response);
            return;
        }            
        try {
            Validator.requireNotEmpty(query);
            Validator.validateSearchBook(query);                       
            String title =  bookService.removeAccent(query.toLowerCase());                 
            List<Book> b = bookService.findBook(title);  // find book 
            boolean foundBook =  bookService.isBookFound(b);  
            if(!foundBook){
                request.setAttribute("found", "not found book");                
            }
            request.setAttribute("searchBook", b);
        } catch (ValidationException e) {
            request.setAttribute("error", e.getMessage());
        }
        request.getRequestDispatcher("/WEB-INF/views/book/searchbook.jsp").forward(request, response);
    }
    
}
