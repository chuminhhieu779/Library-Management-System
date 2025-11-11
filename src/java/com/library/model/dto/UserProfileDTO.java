/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.dto;

import com.library.enums.UserStatus;

/**
 *
 * @author hieuchu
 */
public class UserProfileDTO {
    private int userID ;
    private String fullName;
    private String account;
    private String role ;
    private String avatar;
    private UserStatus status ;

    public UserProfileDTO() {
    }

    public UserProfileDTO(int userID, String fullName, String account, String role, String avatar, UserStatus status) {
        this.userID = userID;
        this.fullName = fullName;
        this.account = account;
        this.role = role;
        this.avatar = avatar;
        this.status = status;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }


    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
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
  
    public void setNewProfile(String fullName, String account , String avatar){
        this.account = account;
        this.fullName = fullName;
        this.avatar = avatar ;
    }
  
    
}
