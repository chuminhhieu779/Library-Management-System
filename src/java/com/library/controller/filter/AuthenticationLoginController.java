/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.filter;

import com.library.dao.ActivityDao;
import com.library.factory.DaoFactory;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.exception.AccountNotExistException;
import com.library.exception.ValidationException;
import com.library.factory.ServiceFactory;
import com.library.model.dto.UserProfileDTO;
import com.library.service.ActivityService;

import com.library.service.TrackingUserService;
import com.library.service.UserService;
import com.library.util.HashPassword;
import com.library.util.SessionTracker;
import com.library.util.Validator;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name = "Login", urlPatterns = {"/user/login"})

public class AuthenticationLoginController extends HttpServlet {

    UserDao userDao = new UserDaoImpl();

    private final ActivityService activityService = ServiceFactory.getActivityService();

    private final UserService userService = ServiceFactory.getUserService();

    private final TrackingUserService trackService = ServiceFactory.getTrackingUserService();

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
        String account = request.getParameter("account");
        String pass = request.getParameter("password");
        UserProfileDTO user = userService.getProfileUserByAccount(account);

        try {
            Validator.validateUserInput(account, pass);
            userService.isAccountExist(account);
            String hashedPassword = userService.getHashedPassword(account);
            if (HashPassword.checkPassword(pass, hashedPassword)) {
                session.setAttribute("account", account);
                session.setAttribute("user", user);             
                SessionTracker.addSessionToServer(session.getId(), session);                
                if (user.getRole().equals("user")) {
                    TrackingUserService.add(account);
                    activityService.ActivityUser(1, account);
                    userService.setOnlineUser(account);
                    int userID = userDao.findUserID(account);
                    trackService.updateData(session.getId(), userID);
                    response.sendRedirect(request.getContextPath() + "/book/list");
                    return;
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    return;
                }
            } else {
                session.setAttribute("error", " Incorrect username or password!");
                response.sendRedirect(request.getContextPath() + "/user/login");
                return;
            }
        } catch (ValidationException e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/login");
        } catch (AccountNotExistException a) {
            session.setAttribute("error", a.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/login");
        }

    }
}
