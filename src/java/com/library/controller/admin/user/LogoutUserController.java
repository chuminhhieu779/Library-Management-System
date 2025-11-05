/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.user;

import com.library.factory.DaoFactory;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.factory.ServiceFactory;
import com.library.service.TrackingUserService;
import com.library.service.UserService;
import com.library.util.SessionTracker;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.apache.catalina.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "LogoutUserController", urlPatterns = {"/admin/user/logout"})
public class LogoutUserController extends HttpServlet {

    UserDao userDao = new UserDaoImpl();
    private final TrackingUserService trackService = ServiceFactory.getTrackingUserService();
    private final UserService userService = ServiceFactory.getUserService();

    private static final Logger logger = LoggerFactory.getLogger(LogoutUserController.class);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userAccount = request.getParameter("account");
        int userID = userDao.findUserID(userAccount);
        
        String sessionIDFromDB = trackService.getSessionID(userID);

        HttpSession saveSessionID = SessionTracker.getSessionOnServer(sessionIDFromDB);
        if (saveSessionID != null && trackService.isUserOnline(userID) == true ) {
            saveSessionID.invalidate();
            TrackingUserService.remove(userAccount);
            userService.setOfflineUser(userAccount);
            response.sendRedirect(request.getContextPath() + "/admin/user-manager");
            return;
        } else {
            HttpSession session = request.getSession(false);
            session.setAttribute("notice", " the user has not logged in yet !!!");
            response.sendRedirect(request.getContextPath() + "/admin/user-manager");
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
