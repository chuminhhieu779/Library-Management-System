/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.AdminDao;
import com.library.model.UserManagerDTO;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public class UserManagerService {
    
    private final AdminDao adminDao ;

    public UserManagerService(AdminDao adminDao) {
        this.adminDao = adminDao;
    }
   
    public List<UserManagerDTO> showUserInformation(){
        return this.adminDao.getAllUserInformation();
    }
   
}
