/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.library.controller.admin;

import com.library.dao.DaoFactory;
import com.library.model.dto.UserManagerDTO;
import com.library.service.UserService;
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
@WebServlet(name="ManagerUserController", urlPatterns={"/admin/user-borrowing-record"})
public class UserBorrowingRecordController extends HttpServlet {
   
       private final UserService userService = new UserService(
            DaoFactory.getUserDao(),
            DaoFactory.getAdminDao()
    );
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        List<UserManagerDTO> list = userService.showUserInformation();
        request.setAttribute("userList", list);
       request.getRequestDispatcher("/WEB-INF/views/admin/userborrowingrecord.jsp").forward(request, response);
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }


}
