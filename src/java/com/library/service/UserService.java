/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.UserDao;
import com.library.model.UserProfileDTO;
import com.library.model.Users;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class UserService {

    private static final Logger logger = LoggerFactory.getLogger(UserService.class);
    private final UserDao userDao;

    public UserService(UserDao userDao) {
        this.userDao = userDao;
    }

    public UserProfileDTO getProfileUserByAccount(String account) {
        Users u = this.userDao.getUser(account);
        UserProfileDTO dto = new UserProfileDTO();
        if(u != null){
           logger.info("{} account founed", account);
           dto.setAccount(u.getAccount());
           dto.setFullName(u.getFullname());
           dto.setUserID(u.getUserID());
           dto.setAvatar(u.getAvatar());
           return dto ;
        }
        return null ;
    }
 
    public boolean updateProfileUser(String account , String avatar , String fullName, int userID){
        if(this.userDao.updateUser(account, avatar, fullName, userID)){
            
            return true ;
        }
      return false;          
    }
}
