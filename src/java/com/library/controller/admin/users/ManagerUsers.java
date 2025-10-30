package com.library.controller.admin.users;

import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
import com.library.model.Users;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ManagerUsers", urlPatterns = {"/admin/users"})
public class ManagerUsers extends HttpServlet {

    private final UserDao userDao = new UserImplementDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminAccount") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String success = (String) session.getAttribute("success");
        String error = (String) session.getAttribute("error");
        if (success != null) {
            request.setAttribute("successMessage", success);
            session.removeAttribute("success");
        }
        if (error != null) {
            request.setAttribute("errorMessage", error);
            session.removeAttribute("error");
        }

        List<Users> users = userDao.getALLUser();
        request.setAttribute("userList", users);

        request.getRequestDispatcher("/WEB-INF/views/admin/managerUser.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

