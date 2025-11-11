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
public class UserBorrowRecordDTO {
    private int userID ;
    private String fullName ;
    private String account ;
    private String borrowedBook;
    private UserStatus status ;
    private int borrowingID ;
    private int bookID;
    public UserBorrowRecordDTO() {
    }

    public UserBorrowRecordDTO(int userID, String fullName, String account, String borrowedBook, UserStatus status, int borrowingID, int bookID) {
        this.userID = userID;
        this.fullName = fullName;
        this.account = account;
        this.borrowedBook = borrowedBook;
        this.status = status;
        this.borrowingID = borrowingID;
        this.bookID = bookID;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

   

    public int getBorrowingID() {
        return borrowingID;
    }

    public void setBorrowingID(int borrowingID) {
        this.borrowingID = borrowingID;
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
