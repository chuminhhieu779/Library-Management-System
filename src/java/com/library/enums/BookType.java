/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.enums;

/**
 *
 * @author hieuchu
 */
public enum BookType {
    ACTION("Action"),
    ENGHLISH("English"),
    ROMANCE("Romance"),
    SOFT_SKILL("Soft Skill"),
    TECHNOLOGY("Technology");
    
    private final String type ;

    private BookType(String type) {
        this.type = type;
    }
    
    public String getValue(){
        return type;
    }
    
       public static BookType convert(String type){
        for(BookType t : BookType.values()) {
           if(t.getValue().equalsIgnoreCase(type)){
               return t ;
           }                   
        }
        return null ;
    }    
}
