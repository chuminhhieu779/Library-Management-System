/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.user;

import com.library.factory.ServiceFactory;
import com.library.service.UserService;
import com.library.util.SessionTracker;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "LogAllUser", urlPatterns = {"/admin/users/logout-all"})
public class LogaoutAllUser extends HttpServlet {

    private final UserService userService = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                        
        userService.logoutAllUser();
        HttpSession session = request.getSession();
        session.setAttribute("logAll", "logout all users done!");
        response.sendRedirect(request.getContextPath() + "/admin/user-manager");

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
