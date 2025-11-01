/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.entity;

import com.library.enums.UserStatus;

/**
 *
 * @author ADMIN
 */
public class User {
    private int userID;
    private String fullname;
    private String account;
    private String password;
    private String role;
    private String avatar;
    private UserStatus status ;
    public User() {
    }

    public User(int userID, String fullname, String account, String password, String role, String avatar, UserStatus status) {
        this.userID = userID;
        this.fullname = fullname;
        this.account = account;
        this.password = password;
        this.role = role;
        this.avatar = avatar;
        this.status = status;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }

 
}
