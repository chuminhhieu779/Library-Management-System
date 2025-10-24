
package com.library.controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;


@WebServlet(name="Admin", urlPatterns={"/admin/login"})
public class Login extends HttpServlet {
    UserDao userDao = new UserImplementDao();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);


        String error = (String) session.getAttribute("error");
        String success = (String) session.getAttribute("success");

        request.setAttribute("error", error);
        request.setAttribute("success", success);

        session.removeAttribute("error");
        session.removeAttribute("success");
        request.getRequestDispatcher("/WEB-INF/views/admin/admin.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("adminUsername");
        String pass = request.getParameter("adminPassword");

        if (userDao.checkAdminLogin(username, pass)) {
            session.setAttribute("adminAccount", username);
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        } else {
            session.setAttribute("error", "Tên đăng nhập không tồn tại!");
            
            if (username.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            } else if (pass.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập mật khẩu!");
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            }
            // check login after user enter correcly 
            if (userDao.checkAdminLogin(username, pass)) {
                session.setAttribute("adminAccount", username);
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            } else {
                session.setAttribute("error", "Tên đăng nhập hoặc mật khẩu sai!");
                response.sendRedirect(request.getContextPath() + "/admin/login");
                return;
            }
        }
    }

}
