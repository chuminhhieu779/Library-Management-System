/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.borrowing;

import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
import com.library.model.entity.Book;
import com.library.model.dto.BorrowedBookDTO;
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
@WebServlet(name = "BorrowedBooks", urlPatterns = {"/borrowing/borrowed"})
public class BorrowedBooksListController extends HttpServlet {

    BorrowingDao borrowDao = new BorrowingDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);        
        
        String account = (String) session.getAttribute("account");
        
        List<BorrowedBookDTO> borrowedBooks = borrowDao.borrowedBooksList(account);
        
        request.setAttribute("borrowedBooks", borrowedBooks);
        request.getRequestDispatcher("/WEB-INF/views/borrowing/borrowedbooks.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
