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
public class UserManagerDTO {
    private int userID ;
    private String fullName ;
    private String account ;
    private String borrowedBook;
    private UserStatus status ;

    public UserManagerDTO() {
    }

    public UserManagerDTO(int userID, String fullName, String account, String borrowedBook, UserStatus status) {
        this.userID = userID;
        this.fullName = fullName;
        this.account = account;
        this.borrowedBook = borrowedBook;
        this.status = status;
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

    public String getBorrowedBook() {
        return borrowedBook;
    }

    public void setBorrowedBook(String borrowedBook) {
        this.borrowedBook = borrowedBook;
    }

    public UserStatus getStatus() {
        return status;
    }

    public void setStatus(UserStatus status) {
        this.status = status;
    }
    
    
}
