/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.book;

import com.library.dao.CategoryDao;
import com.library.dao.CategoryDaoImpl;
import com.library.model.entity.Book;
import com.library.model.entity.Category;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "BookCategory", urlPatterns = {"/book/category"})
public class BookCategoryController extends HttpServlet {

    CategoryDao categoryDao = new CategoryDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {   
        List<Book> list = Collections.unmodifiableList(categoryDao.getAllBook());
        request.setAttribute("categorizeBook", list);
        request.getRequestDispatcher("/WEB-INF/views/book/bookcategory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category-select");
        List<Book> list ;
        if(category == null || category.isEmpty()){
            list = categoryDao.getAllBook();
        }else{
            list = categoryDao.categorizeBook(category);
        }
        
        request.setAttribute("categorizeBook", list);
        request.setAttribute("selected", category);
        request.getRequestDispatcher("/WEB-INF/views/book/bookcategory.jsp").forward(request, response);

    }

}
