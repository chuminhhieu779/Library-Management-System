/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.CategoryDao;
import com.library.dao.CategoryImplement;
import com.library.model.Books;
import com.library.model.Categories;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "BookCategory", urlPatterns = {"/user/book-category"})
public class BookCategory extends HttpServlet {

    CategoryDao categoryDao = new CategoryImplement();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Books> list = categoryDao.getAllBook();
        request.setAttribute("categorizeBook", list);
        request.getRequestDispatcher("/WEB-INF/views/user/bookcategory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category-select");
        List<Books> list ;
        if(category == null || category.isEmpty()){
            list = categoryDao.getAllBook();
        }else{
            list = categoryDao.categorizeBook(category);
        }
        
        request.setAttribute("categorizeBook", list);
        request.setAttribute("selected", category);
        request.getRequestDispatcher("/WEB-INF/views/user/bookcategory.jsp").forward(request, response);

    }

}
