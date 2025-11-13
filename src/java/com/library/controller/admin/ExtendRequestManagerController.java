/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin;

import com.library.factory.ServiceFactory;
import com.library.model.dto.ExtendRequestViewDTO;
import com.library.service.ExtendBookService;
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
@WebServlet(name = "CExtendRequestManagerController", urlPatterns = {"/admin/extend-request-manger"})
public class ExtendRequestManagerController extends HttpServlet {

    private final ExtendBookService extendSerivce = ServiceFactory.getExtendBookService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        List<ExtendRequestViewDTO> list = extendSerivce.getAllExtendRequests();
        request.setAttribute("list", list);
        session.setAttribute("extendDTO", list);
        request.getRequestDispatcher("/WEB-INF/views/admin/extend_request_manager.jsp").forward(request, response);
    }    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
}
