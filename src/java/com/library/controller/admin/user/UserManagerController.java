/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.admin.user;

import com.library.factory.DaoFactory;
import com.library.factory.ServiceFactory;
import com.library.model.dto.UserProfileDTO;
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
@WebServlet(name = "UserManagerController", urlPatterns = {"/admin/user-manager"})
public class UserManagerController extends HttpServlet {

    private final UserService userSerivce = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String notice = (String) session.getAttribute("notice");
        String removeUser = (String) session.getAttribute("notice");
        String LogAllUser = (String) session.getAttribute("logAll");

        List<UserProfileDTO> list = userSerivce.showProfileUser();
        request.setAttribute("list", list);
        request.setAttribute("notice", notice);
        request.setAttribute("tmp", removeUser);
        request.setAttribute("logAllUser", LogAllUser);

        session.removeAttribute("notice");
        session.removeAttribute("tmp");
        session.removeAttribute("logAll");

        request.getRequestDispatcher("/WEB-INF/views/admin/usermanager.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
