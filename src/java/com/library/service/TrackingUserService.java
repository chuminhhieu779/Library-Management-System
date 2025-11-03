/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.UserDao;
import com.library.dao.UserSessionDao;
import java.util.ArrayList;
import java.util.List;



/**
 *
 * @author hieuchu
 */
public class TrackingUserService {
    
    private final UserSessionDao userSessionDao ;
   private final UserDao useDao ;
    
    public TrackingUserService(UserSessionDao userSessionDao, UserDao useDao){
         this.userSessionDao = userSessionDao;       
         this.useDao = useDao;
         
    }
    private static final List<String> list = new ArrayList<>();    
    
    public static void add(String account){
        list.add(account);
    }
    public static void remove(String account){
        list.remove(account);
    }
    public static int getSize(){
        return list.size();                
    }
    
    /**   
     * updateDate : insert data into user_session table after user login in   
     */        
    
    public void updateData(String sessionID, int userID){
        if(this.userSessionDao.canInsert(userID)){
            this.userSessionDao.insertData(sessionID, userID);
        }else{
            this.userSessionDao.updateData(sessionID, userID);
        }        
    }
    
    public String getSessionID(int userID){
        return this.userSessionDao.getSessionID(userID);
    }
    
    public boolean isUserOnline(int userID){
        if(this.useDao.checkUserStatus(userID)){
            return true ;
        }
        return false;
    }
}
