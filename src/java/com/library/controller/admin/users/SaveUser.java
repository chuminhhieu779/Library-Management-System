package com.library.controller.admin.users;

import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "SaveUser", urlPatterns = {"/admin/users/save"})
public class SaveUser extends HttpServlet {

    private final UserDao userDao = new UserImplementDao();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminAccount") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String fullName = request.getParameter("fullName");
        String account = request.getParameter("account");
        String password = request.getParameter("password");

        if (fullName == null || fullName.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập họ và tên!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        if (account == null || account.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }
        if (password == null || password.trim().isEmpty()) {
            session.setAttribute("error", "Vui lòng nhập mật khẩu!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        if (userDao.checkUserExistence(account)) {
            session.setAttribute("error", "Tên đăng nhập đã được sử dụng!");
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        userDao.addNewUser(fullName, account, password);
        session.setAttribute("success", "Tạo người dùng thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}

