/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import java.sql.Connection;

/**
 *
 * @author hieuchu
 */
public interface UserSessionDao {
    boolean canInsert(int userID);
    void insertData(String sessionID , int userID);    
    void updateData(String sessionID , int userID);
    String getSessionID(int userID);
    public void deleteUserFromSessions(Connection conn, int userId);
}
