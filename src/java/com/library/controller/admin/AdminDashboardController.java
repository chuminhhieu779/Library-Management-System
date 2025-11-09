/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin;

import com.library.factory.ServiceFactory;
import com.library.model.dto.AdminDashBoardDTO;
import com.library.model.dto.UserProfileDTO;
import com.library.model.entity.User;
import com.library.service.ActivityService;
import com.library.service.BookService;
import jakarta.annotation.security.DeclareRoles;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.HttpConstraint;
import jakarta.servlet.annotation.ServletSecurity;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/dashboard"})

public class AdminDashboardController extends HttpServlet {

    private final ActivityService activityService = ServiceFactory.getActivityService();
    private final BookService bookService = ServiceFactory.getBookService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        Map<String, Integer> map = bookService.getNumberBorrowedBookByCategory();

        AdminDashBoardDTO dto = activityService.adminDashBoard();
        request.setAttribute("dto", dto);
        request.setAttribute("map", map);
        request.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(request, response);

    }

}
