/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.user;

import com.library.factory.ServiceFactory;
import com.library.service.RemoveUserService;
import com.library.service.UserService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "DeleteUserController", urlPatterns = {"/admin/user/delete"})
public class DeleteUserController extends HttpServlet {

    private final RemoveUserService removeService = ServiceFactory.getRemoveUserService();
    private final UserService userService = ServiceFactory.getUserService();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);        
        String userAccount = request.getParameter("account");
        int userID = userService.getUserIDByAccount(userAccount);
        String tmp = "";
        if (removeService.removeUser(userID)) {
            tmp = " the user has removed !!";
            session.setAttribute("tmp", tmp);
            response.sendRedirect(request.getContextPath() + "/admin/user-manager");
        }                  
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
