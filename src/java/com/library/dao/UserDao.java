/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Users;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface UserDao {
      List<Users> getALLUser();
      
      boolean checkLogin(String username,String pass);
      
      boolean checkUserExistence(String username);
      
      void addNewUser(String username,String account,String password);
}
