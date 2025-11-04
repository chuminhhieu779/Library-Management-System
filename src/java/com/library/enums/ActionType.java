/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.enums;

/**
 *
 * @author hieuchu
 */
public enum ActionType {
    LOGIN("login"),
    UPDATE_PROFILE("update profile"),
    BORROW_BOOK("borrow book"),
    RETURN_BOOK("return book");

    private final String type ;

    private ActionType(String type) {
        this.type = type;
    }
        
    public String getValue(){
        return type ;
    }
    
    public static ActionType convert(String type){
        for(ActionType t : ActionType.values()) {
           if(t.getValue().equalsIgnoreCase(type)){
               return t ;
           }                   
        }
        return null ;
    }    
}
