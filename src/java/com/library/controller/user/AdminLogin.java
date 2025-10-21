
package com.library.controller.user;

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


@WebServlet(name="Admin", urlPatterns={"/Admin"})
public class AdminLogin extends HttpServlet {
    UserDao userDao = new UserImplementDao();
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
        request.getRequestDispatcher("/WEB-INF/views/admin/homepage.jsp").forward(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = request.getParameter("account");
        String pass = request.getParameter("password");

        if (userDao.checkLogin(username, pass)) {
            session.setAttribute("account", username);
            response.sendRedirect(request.getContextPath() + "/admin/AdminDashboard.jsp");
        } else {
            session.setAttribute("error", "Tên đăng nhập không tồn tại!");

            if (username.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập tên đăng nhập!");
                response.sendRedirect(request.getContextPath() + "/Admin");
                return;
            } else if (pass.trim().isEmpty()) {
                session.setAttribute("error", "Vui lòng nhập mật khẩu!");
                response.sendRedirect(request.getContextPath() + "/Admin");
                return;
            }
            // check login after user enter correcly 
            if (userDao.checkLogin(username, pass)) {
                session.setAttribute("account", username);
                response.sendRedirect(request.getContextPath() + "/admin/AdminDashboard.jsp");
                return;
            } else {
                session.setAttribute("error", "Tên đăng nhập hoặc mật khẩu sai!");
                response.sendRedirect(request.getContextPath() + "/Admin");
                return;
            }
        }
    }

}
