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
import com.library.dao.UserDaoImpl;
import jakarta.servlet.http.HttpSession;
/**
 *
 * @author hieuchu  
 */
@WebServlet(name="RegisterController", urlPatterns={"/user/register"})
public class RegisterController extends HttpServlet {
    UserDao userDao = new UserDaoImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String error = (String) session.getAttribute("error");
        request.setAttribute("error", error);
        session.removeAttribute("error");
        request.getRequestDispatcher("/WEB-INF/views/user/register.jsp").forward(request, response);      
    } 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String userName = request.getParameter("username");
        String pass = request.getParameter("password");
        String account = request.getParameter("account");       
        if(userName.trim().isEmpty()){
            session.setAttribute("error", "Vui lòng nhập họ và tên!");
            response.sendRedirect(request.getContextPath() + "/user/register");
            return; 
        }
        else if(pass.trim().isEmpty()){
            session.setAttribute("error", "Vui lòng nhập mật khẩu!");
            response.sendRedirect(request.getContextPath() + "/user/register");
            return; 
        }
        else if(account.trim().isEmpty()){
            session.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
            response.sendRedirect(request.getContextPath() + "/user/register");
            return; 
        }
        
        if(userDao.checkUserExistence(account)){
            session.setAttribute("error", "Tên đăng nhập đã được sử dụng!");
            response.sendRedirect(request.getContextPath() + "/user/register");
            return;
        }
        else{
            userDao.addNewUser(userName, account, pass);
            session.setAttribute("success", "Bạn đã đăng kí thành công!");
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
    }


}
