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
import com.library.exception.AccountHasExistedException;
import com.library.exception.AccountNotExistException;
import com.library.exception.ValidationException;

import com.library.factory.ServiceFactory;
import com.library.service.UserService;
import com.library.util.HashPassword;
import com.library.util.Validator;
import jakarta.servlet.http.HttpSession;
import sun.security.validator.ValidatorException;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/user/register"})
public class RegisterController extends HttpServlet {

    private final UserService userService = ServiceFactory.getUserService();

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
        try {
            Validator.validateUserInput(account, pass);
            userService.hasAccountExisted(account);
            String hashedPassword = HashPassword.hash(pass);            
            userService.addUser(userName, account, hashedPassword);         
            session.setAttribute("success", "Resgiter Done !!!");
            response.sendRedirect(request.getContextPath() + "/user/login");
        } catch (AccountHasExistedException s) {
            session.setAttribute("error", "account has existed !!!");
            response.sendRedirect(request.getContextPath() + "/user/register");
        } catch (ValidationException s1) {
            session.setAttribute("error", s1.getMessage());
            response.sendRedirect(request.getContextPath() + "/user/register");

        }
    }

}
