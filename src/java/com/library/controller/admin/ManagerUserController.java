/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.library.controller.admin;

import com.library.dao.DaoFactory;
import com.library.model.UserManagerDTO;
import com.library.service.UserManagerService;
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
@WebServlet(name="ManagerUserController", urlPatterns={"/admin/manager-user"})
public class ManagerUserController extends HttpServlet {
   
    private final UserManagerService  managerService = new UserManagerService(
          DaoFactory.getAdminDao()
    );
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
        List<UserManagerDTO> list = managerService.showUserInformation();
        request.setAttribute("userList", list);
       request.getRequestDispatcher("/WEB-INF/views/admin/managerUser.jsp").forward(request, response);
    } 

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        
    }


}
