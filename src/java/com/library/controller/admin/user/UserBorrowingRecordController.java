/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.user;

import com.library.factory.DaoFactory;
import com.library.factory.ServiceFactory;
import com.library.model.dto.UserBorrowRecordDTO;
import com.library.service.UserService;
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
@WebServlet(name = "ManagerUserController", urlPatterns = {"/admin/user-borrowing-record"})
public class UserBorrowingRecordController extends HttpServlet {
    
    private final UserService userService = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<UserBorrowRecordDTO> list = userService.showUserInformation();
        HttpSession session = request.getSession(true);
        String success = (String) session.getAttribute("success");
        request.setAttribute("userList", list);
        request.setAttribute("sucess", success);
        request.getRequestDispatcher("/WEB-INF/views/admin/userborrowingrecord.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
