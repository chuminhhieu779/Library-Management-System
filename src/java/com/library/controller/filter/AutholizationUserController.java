/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Filter.java to edit this template
 */
package com.library.controller.filter;

import com.library.model.dto.UserProfileDTO;
import com.library.model.entity.User;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import jakarta.servlet.DispatcherType;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author hieuchu
 */
@WebFilter(filterName = "AutholizeFilter", urlPatterns = {"/*"}, dispatcherTypes = {DispatcherType.REQUEST})
public class AutholizationUserController implements Filter {

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain chain) throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        HttpSession session = request.getSession(false);

        String path = request.getRequestURI();
        UserProfileDTO user = null;
        if (session != null) {
            user = (UserProfileDTO) session.getAttribute("user");
        }

        String[] publicPaths = {
            "/login", "/register", "/book/list",
            "/resource/", "/images/", ".css", ".js", ".png", ".jpg", "/user/forgot-password"
        };
        for (String p : publicPaths) {
            if (path.contains(p)) {
                chain.doFilter(servletRequest, servletResponse);
                return;
            }
        }
       
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return;
        }
         if (user.getRole().equals("user")) {            
            for (String url : AutholizationURLController.pageForUser()) {
              if(path.contains(url)){
                  chain.doFilter(servletRequest, servletResponse);
                  return ;
              }
            }
        }
         
        if (user.getRole().equals("admin")) {            
            for (String url : AutholizationURLController.pageForAdmin()) {
              if(path.contains(url)){
                  chain.doFilter(servletRequest, servletResponse);
                  return ;
              }
            }
        }              
       
    }

}
