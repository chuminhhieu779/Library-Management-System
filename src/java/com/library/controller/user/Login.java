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
@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    UserDao userDao = new UserImplementDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String error = (String) session.getAttribute("error");
        request.setAttribute("error", error);
        session.removeAttribute("error");
        String success = (String) session.getAttribute("success");
        request.setAttribute("success", success);
        session.removeAttribute("success");
        request.getRequestDispatcher("/WEB-INF/views/homepage.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("account");
        String pass = request.getParameter("password");

        if (userDao.checkLogin(username, pass)) {
            session.setAttribute("username", username);
            response.sendRedirect(request.getContextPath() + "/user/booklist");
        } else {
            session.setAttribute("error", "Tên đăng nhập không tồn tại!");

            if (username.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
                response.sendRedirect(request.getContextPath() + "/Login");
                return;
            } else if (pass.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập mật khẩu!");
                response.sendRedirect(request.getContextPath() + "/Login");
                return;
            }
            if (userDao.checkLogin(username, pass)) {
                session.setAttribute("username", username);
                response.sendRedirect(request.getContextPath() + "/user/booklist");
                return;
            } else {
                session.setAttribute("error", "Tên đăng nhập hoặc mật khẩu sai!");
                response.sendRedirect(request.getContextPath() + "/Login");
                return;
            }
        }
    }
}
