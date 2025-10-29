
package com.library.controller.user;


import com.library.dao.DaoFactory;
import com.library.service.ActivityService;
import com.library.service.TrackingUserService;
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
public class LogOut extends HttpServlet {
   
  private final ActivityService activityService = new ActivityService(
               DaoFactory.getActivityDao(),
               DaoFactory.getActionDao(),
               DaoFactory.getUserDao(),
               DaoFactory.getBookDao()                
    );
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String userName = (String)session.getAttribute("account");
        if(session!=null){
            session.removeAttribute("account");
            TrackingUserService.remove(userName);                 
        }
        response.sendRedirect(request.getContextPath() + "/book/list");
    } 


}
