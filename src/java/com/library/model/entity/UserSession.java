/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.entity;

/**
 *
 * @author hieuchu
 */
public class UserSession {
    private String sessionID ;
    private User user ;
    
    public UserSession() {
    }

    public UserSession(String sessionID, User user) {
        this.sessionID = sessionID;
        this.user = user;
    }

    public String getSessionID() {
        return sessionID;
    }

    public void setSessionID(String sessionID) {
        this.sessionID = sessionID;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
    
}
