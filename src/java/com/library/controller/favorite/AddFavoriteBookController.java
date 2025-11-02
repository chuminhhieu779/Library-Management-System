/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.favorite;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.factory.DaoFactory;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.factory.ServiceFactory;
import com.library.model.entity.Book;
import com.library.service.FavoriteService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "Favorite", urlPatterns = {"/favorite/add-book"})
public class AddFavoriteBookController extends HttpServlet {
    
    FavoriteService favService = ServiceFactory.getFavoriteService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            session.setAttribute("error", "Vui lòng đăng nhập để sử dụng chức năng!");
            
            response.sendRedirect(request.getContextPath() + "/book/detail");
            return;
        }
        String account = (String) session.getAttribute("account");
        int userID = favService.getUserIdByAccount(account);
        int bookID = Integer.valueOf(request.getParameter("bookID"));
        
        /// insert into favorite table 
        if (favService.addBookToFavorite(bookID, userID)) {
            session.setAttribute("success", "Book added to favorite list");
        }
        else {
            session.setAttribute("failed", "you already favorited this book ");
        }           
        String slug = request.getParameter("slug");
        response.sendRedirect(request.getContextPath() + "/book/detail?slug=" + slug + "&bookID=" + bookID);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
