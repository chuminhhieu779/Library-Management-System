
package com.library.controller.user;


import com.library.factory.DaoFactory;
import com.library.factory.ServiceFactory;
import com.library.service.ActivityService;
import com.library.service.TrackingUserService;
import com.library.service.UserService;
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
@WebServlet(name="LogOut", urlPatterns={"/LogOut"})
public class LogoutController extends HttpServlet {
   
     private final ActivityService activityService = ServiceFactory.getActivityService();
 
     private final  UserService userService = ServiceFactory.getUserService();
     
     
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userName = (String)session.getAttribute("account");
        if(session!=null){
            session.removeAttribute("account");
            TrackingUserService.remove(userName);  
            userService.setOfflineUser(userName);
        }
        response.sendRedirect(request.getContextPath() + "/book/list");
    } 


}
