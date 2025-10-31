/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.enums;

/**
 *
 * @author hieuchu
 */
public enum UserStatus {
    
     BORROWING("borrowing"),
     RETURNED("returned");
     
    private final String status ;

    private UserStatus(String status) {
        this.status = status ;
    }
    public String getName(){
        return this.status;
    }
}
