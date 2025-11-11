/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.enums;

import java.util.Optional;

/**
 *
 * @author hieuchu
 */
public enum UserStatus {
     ACTIVE("active"),
     INACTIVE("inactive"),
     BORROWING("borrowing"),
     PENDING("pending"),    
     RETURNED("returned");
     
    private final String value;

    private UserStatus(String value) {
        this.value = value ;
    }
    public String getValue(){
        return value;
    }
    
    public static Optional<UserStatus> convertToEnum(String value){
        for(UserStatus status : values()){
           if(status.getValue().equalsIgnoreCase(value)){
               return Optional.of(status);
           }     
        }
        return Optional.empty();
    }    
   
}
