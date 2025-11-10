/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.dao.UserDao;
import com.library.exception.AccountNotExistException;
import com.library.exception.ValidationException;
import com.library.factory.ServiceFactory;
import com.library.service.MailService;
import com.library.service.TrackingUserService;
import com.library.service.UserService;
import com.library.util.HashPassword;
import com.library.util.RandomPassword;
import com.library.util.SessionTracker;
import com.library.util.Validator;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.security.SecureRandom;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "ForgotPassword", urlPatterns = {"/user/forgot-password"})
public class ForgotPassword extends HttpServlet {

    private final UserService userService = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        request.getRequestDispatcher("/WEB-INF/views/user/forgotpassword.jsp").forward(request, response);
        return;
    }
     
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String account = request.getParameter("email");
        try {
            Validator.requireNotEmpty(account);
            userService.isAccountExist(account);
            String tmp = RandomPassword.generatePassword();
            String subject = "Password Recovery - Library System";
            String message = "<p>Your New Pass : <b>" + tmp + "</b> </p>";
            userService.updatePassword(account, HashPassword.hash(tmp));
            MailService.send(account, subject, message);
            session.setAttribute("message", "we have sent your password via email");
            response.sendRedirect(request.getContextPath() + "/user/forgot-password");
        } catch (ValidationException e) {
            session.setAttribute("error", e.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/forgot-password");
        } catch (AccountNotExistException a) {
            session.setAttribute("error", a.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/forgot-password");
        }

    }

}
