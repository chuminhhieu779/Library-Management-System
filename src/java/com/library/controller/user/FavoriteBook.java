/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.BookDao;
import com.library.dao.BookImplementDao;
import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
import com.library.model.Books;
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
@WebServlet(name = "Favorite", urlPatterns = {"/user/favorite-book"})
public class FavoriteBook extends HttpServlet {

    UserDao userDao = new UserImplementDao();
    BookDao bookDao = new BookImplementDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("account") == null) {
            response.sendRedirect(request.getContextPath() + "/Login");
            return;
        }
        String account = (String) session.getAttribute("account");
        int userID = userDao.findUserID(account);
        int bookID = Integer.valueOf(request.getParameter("bookID"));

        bookDao.favoriteBook(bookID, userID); /// insert into favorite table 
        List<Books> favoriteBooks = new ArrayList<>();
        favoriteBooks.add(bookDao.addBookToFavorite(bookID));
        if (favoriteBooks != null && !favoriteBooks.isEmpty()) {
            session.setAttribute("success", "Book added to favorite list");
        } else {
            session.setAttribute("failed", "Failed to add the book to favorite list");
        }
        String slug = request.getParameter("slug");
        request.setAttribute("favoriteBooks", favoriteBooks);
        response.sendRedirect(request.getContextPath() + "/user/bookdetail?slug=" + slug + "&bookID=" + bookID);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
