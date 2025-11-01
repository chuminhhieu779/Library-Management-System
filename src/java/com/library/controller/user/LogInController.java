/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.ActivityDao;
import com.library.dao.DaoFactory;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.service.ActivityService;

import com.library.service.TrackingUserService;
import com.library.service.UserService;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name = "Login", urlPatterns = {"/user/login"})


public class LoginController extends HttpServlet {

    UserDao userDao = new UserDaoImpl();
    private final ActivityService activityService = new ActivityService(
               DaoFactory.getActivityDao(),
               DaoFactory.getActionDao(),
               DaoFactory.getUserDao(),
               DaoFactory.getBookDao()                
    );
    UserService userService = new UserService(
            DaoFactory.getUserDao(),
            DaoFactory.getAdminDao()
    );
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        session = request.getSession(); // create new session if it is not exist
        String error = (String) session.getAttribute("error");
        String success = (String) session.getAttribute("success");
        request.setAttribute("error", error);
        request.setAttribute("success", success);

        session.removeAttribute("error");
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
            session.setAttribute("account", username);
            TrackingUserService.add(username);
            activityService.ActivityUser(1, username);
            userService.setOnlineUser(username);
            response.sendRedirect(request.getContextPath() + "/book/list");
        } else {
            session.setAttribute("error", "Tên đăng nhập không tồn tại!");
            if (username.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
                response.sendRedirect(request.getContextPath() + "/user/login");
                return;
            } else if (pass.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập mật khẩu!");
                response.sendRedirect(request.getContextPath() + "/user/login");
                return;
            }
            // check login after user enter correcly 
            if (userDao.checkLogin(username, pass)) {
                session.setAttribute("account", username);      
                response.sendRedirect(request.getContextPath() + "/book/list");
                return;
            } else {
                session.setAttribute("error", "Tên đăng nhập hoặc mật khẩu sai!");
                response.sendRedirect(request.getContextPath() + "/user/login");
                return;
            }
        }

    }
}
