/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.library.controller.user;

import com.library.factory.DaoFactory;
import com.library.factory.ServiceFactory;
import com.library.model.dto.UserProfileDTO;
import com.library.service.ActivityService;
import com.library.service.UserService;
import com.library.util.Validator;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

/**
 *
 * @author hieuchu
 */
@WebServlet(name = "UpdateProfile", urlPatterns = {"/user/update-profile"})
@MultipartConfig
public class UpdateProfileController extends HttpServlet {

    private static final String saveFile = "D:\\BTL-PRJ301\\LibraryManagement\\web\\resources\\images\\avatar";
    
      private final ActivityService activityService = ServiceFactory.getActivityService();
 
     private final  UserService userService = ServiceFactory.getUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);

        UserProfileDTO u = (UserProfileDTO) session.getAttribute("user");
        String fullName = request.getParameter("fullName");
        String account = request.getParameter("account");
        int userID = u.getUserID();
        if (fullName == null || fullName.isBlank() || fullName.isEmpty()) {
            fullName = u.getFullName();
        } else {
            Validator.validateUsername(fullName);
        }
        if (account == null || account.isBlank() || account.isEmpty()) {
            account = u.getAccount();
        } else {
            Validator.validateUserAccount(account);
        }
        Part filePath = request.getPart("avatar");

        String avatar;
        if (filePath == null || filePath.getSize() == 0) {
            avatar = u.getAvatar();                       
        } else {
            String fileName = Paths.get(filePath.getSubmittedFileName()).getFileName().toString();
            File savedFile = new File(saveFile, fileName);
            try (InputStream input = filePath.getInputStream()) {
                Files.copy(input, savedFile.toPath(), StandardCopyOption.REPLACE_EXISTING); // copy file to specific folder
            }
            String relativePath = "/avatar/" + fileName;
            avatar = relativePath; // save new file path to write it down database 
        }

        boolean checkUpdate = userService.updateProfileUser(account, avatar, fullName, userID);        
        if (checkUpdate) {
            request.setAttribute("isUpdated", "You have updated your profile successfully!");
            session.removeAttribute("user");
            u.setNewProfile(fullName, account, avatar);            
            session.setAttribute("user", u);
            activityService.ActivityUser(2, account);
        } else {
            request.setAttribute("isUpdated", " Failed to update your profile");
        }
         request.getRequestDispatcher("/WEB-INF/views/user/setting.jsp").forward(request, response);
    }

}
