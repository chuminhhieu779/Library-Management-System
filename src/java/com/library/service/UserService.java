/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.AdminDao;
import com.library.dao.UserDao;
import com.library.dao.UserSessionDao;
import com.library.enums.UserStatus;
import com.library.exception.AccountHasExistedException;
import com.library.exception.AccountNotExistException;
import com.library.exception.UserNotFoundException;
import com.library.model.dto.UserBorrowRecordDTO;
import com.library.model.dto.UserProfileDTO;
import com.library.model.entity.User;
import com.library.util.SessionTracker;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);
    private final UserDao userDao;
    private final AdminDao adminDao;
    private final UserSessionDao sessionDao;

    public UserService(UserDao userDao, AdminDao adminDao, UserSessionDao sessionDao) {
        this.userDao = userDao;
        this.adminDao = adminDao;
        this.sessionDao = sessionDao;
    }

    public UserProfileDTO getProfileUserByAccount(String account) {
        Optional<User> opt = this.userDao.getUser(account);
        UserProfileDTO dto = new UserProfileDTO();
        opt.ifPresentOrElse(
                user -> { // User user = opt.get()
                    logger.info("{} account found", account);
                    dto.setUserID(user.getUserID());
                    dto.setAccount(user.getAccount());
                    dto.setFullName(user.getFullname());
                    dto.setAvatar(user.getAvatar());
                    dto.setStatus(user.getStatus());
                    dto.setRole(user.getRole());
                },
                () -> {
                    throw new UserNotFoundException("User: " + account + "not found");
                }
        );
        return dto;
    }

    public List<UserProfileDTO> showProfileUser() {
        List<User> entityList = this.userDao.getALLUser();
        List<UserProfileDTO> dtoList = new ArrayList<>();
        for (User u : entityList) {            
            UserProfileDTO dto = new UserProfileDTO();
            if(u.getRole().equals("user")){
                   dto.setAccount(u.getAccount());
            dto.setFullName(u.getFullname());
            dto.setUserID(u.getUserID());
            dto.setAvatar(u.getAvatar());
            dto.setStatus(u.getStatus());
            dtoList.add(dto);
            }
         
        }
        return dtoList;
    }

    public boolean updateProfileUser(String account, String avatar, String fullName, int userID) {
        if (this.userDao.updateUser(account, avatar, fullName, userID)) {
            return true;
        }
        return false;
    }

    public List<UserBorrowRecordDTO> showUserInformation() {
        return this.adminDao.getAllUserInformation();
    }

    public void setOnlineUser(String account) {
        if (this.userDao.setOnline(account)) {
            logger.info("update status of user : ", account);
        }
        logger.info("update failed!!!");
    }

    public void setOfflineUser(String account) {
        if (this.userDao.setOfflife(account)) {
            logger.info("update status of user : ", account);
        }
        logger.info("update failed!!!");
    }

    public int getUserIDByAccount(String account) {
        return this.userDao.findUserID(account);
    }

    public String getHashedPassword(String account) {
        return this.userDao.findHashedPassword(account);
    }

    public void logoutAllUser() {
        Collection<HttpSession> session = SessionTracker.getAllValue();
        for (HttpSession s : session) {
            s.invalidate();
        }
        this.userDao.setOfflineAll();

    }

    public boolean updatePassword(String account, String password) {
        if (userDao.updatePassword(account, password)) {
            logger.info("update completed ()", account);
            return true;
        }
        logger.info("update failed!");
        return false;
    }

    public void isAccountExist(String account) {
        if (this.userDao.checkUserExistence(account) == false ) {
            throw new AccountNotExistException("The account : " + account + " not exist!!");
        }
    }
    
    public void hasAccountExisted(String account) {
        if (this.userDao.checkUserExistence(account)) {
            throw new AccountHasExistedException("The account : " + account + " has existed!!");
        }
    }
    
    public boolean addUser(String username, String account , String password){
        return this.userDao.addNewUser(username, account, password);
    }
    
    public int getAminID(String account){
        return this.userDao.findAdminIDByAccount(account);
    }

}
