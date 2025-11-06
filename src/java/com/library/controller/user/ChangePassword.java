/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.factory.ServiceFactory;
import com.library.service.UserService;
import com.library.util.HashPassword;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author laptop gigabyte
 */
@WebServlet(name = "ChangePassword", urlPatterns = {"/user/change-password"})
public class ChangePassword extends HttpServlet {

    private UserService userService = ServiceFactory.getUserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        HttpSession session = request.getSession(false);
        String account = (String) session.getAttribute("account");
        String getHashedPassword = userService.getHashedPassword(account);
        String hashedPassword = HashPassword.hash(newPassword);
        if (newPassword.trim().isEmpty()) {
            session.setAttribute("changePasswordError", "Mật khẩu không được bao gồm khoảng trắng!");
            response.sendRedirect(request.getContextPath() + "/user/setting");
            return;
        } else if (newPassword.contains(" ")) {
            session.setAttribute("changePasswordError", "Mật khẩu không được bao gồm khoảng trắng!");
            response.sendRedirect(request.getContextPath() + "/user/setting");
            return;
        }else if(!newPassword.equals(confirmPassword)){
            session.setAttribute("changePasswordError", "Mật khẩu xác nhận không giống   mật khẩu mới!");
            response.sendRedirect(request.getContextPath() + "/user/setting");
            return;
        }
        if (HashPassword.checkPassword(currentPassword, getHashedPassword)) {
            if (userService.updatePassword(account, hashedPassword)) {
                session.setAttribute("changePasswordSuccess", "Cập nhật mật khẩu thành công!");
                response.sendRedirect(request.getContextPath() + "/user/setting");
                return;
            } else {
                session.setAttribute("changePasswordError", "Cập nhật mật khẩu không thành công!");
                response.sendRedirect(request.getContextPath() + "/user/setting");
                return;
            }
        } else {
            session.setAttribute("changePasswordError", "Mật khẩu hiện tại sai!");
            response.sendRedirect(request.getContextPath() + "/user/setting");
            return;
        }
    }

}
