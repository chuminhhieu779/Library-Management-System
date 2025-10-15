/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package com.library.controller.user;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
import jakarta.servlet.http.HttpSession;
/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name="Login", urlPatterns={"/Login"})
public class Login extends HttpServlet {
   UserDao userDao = new UserImplementDao();
       @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
            request.getRequestDispatcher("/WEB-INF/views/homepage.jsp").forward(request, response);
        
        
    }
   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("account");
        String pass = request.getParameter("password");
        
        if(userDao.checkLogin(username, pass)){
            HttpSession session =  request.getSession();
            session.setAttribute("username", username);
            
            request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);
        }
        else{
            response.sendRedirect(request.getContextPath() + "/Login");
        }
        
    }


}
