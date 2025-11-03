/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.AdminDao;
import com.library.dao.UserDao;
import com.library.enums.UserStatus;
import com.library.model.dto.UserBorrowRecordDTO;
import com.library.model.dto.UserProfileDTO;
import com.library.model.entity.User;
import java.util.ArrayList;
import java.util.List;
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

    public UserService(UserDao userDao, AdminDao adminDao) {
        this.userDao = userDao;
        this.adminDao = adminDao;
    }

    public UserProfileDTO getProfileUserByAccount(String account) {
        User u = this.userDao.getUser(account);
        UserProfileDTO dto = new UserProfileDTO();
        if (u != null) {
            logger.info("{} account founed", account);
            dto.setAccount(u.getAccount());
            dto.setFullName(u.getFullname());
            dto.setUserID(u.getUserID());
            dto.setAvatar(u.getAvatar());
            dto.setStatus(u.getStatus());
            return dto;
        }
        return null;
    }

    public List<UserProfileDTO> showProfileUser() {
        List<User> entityList = this.userDao.getALLUser();
        List<UserProfileDTO> dtoList = new ArrayList<>();
        for (User u : entityList) {
            UserProfileDTO dto = new UserProfileDTO();
            dto.setAccount(u.getAccount());
            dto.setFullName(u.getFullname());
            dto.setUserID(u.getUserID());
            dto.setAvatar(u.getAvatar());
            dto.setStatus(u.getStatus());
            dtoList.add(dto);
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
    
    public int getUserIDByAccount(String account){
        return this.userDao.findUserID(account);
    }
   
}
