/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;


import com.library.model.dto.UserProfileDTO;
import com.library.model.entity.User;
import java.sql.Connection;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface UserDao {

      List<User> getALLUser();     

  
//      boolean checkLogin(String username,String pass);

      
      boolean checkUserExistence(String username);
      
      void addNewUser(String username,String account,String password);
      
      boolean checkAdminLogin(String username,String pass);
      
      int findUserID(String account);
      
      User getUser(String account);
      
      boolean updateUser(String account , String avatar, String fullName, int userID);
      
      boolean setOnline(String account);
      
      boolean setOfflife(String account);
      
      void setOfflineAll();
      
      boolean checkUserStatus(int userID);
      
      boolean deleteUser(Connection conn , int userID);
      
      String findHashedPassword(String account);
      
      List<Integer> getAllUserID();      

      boolean updatePassword(String account,String password);

      
}
