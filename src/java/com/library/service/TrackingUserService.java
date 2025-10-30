/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import java.util.ArrayList;
import java.util.List;



/**
 *
 * @author hieuchu
 */
public class TrackingUserService {
    
    private static final List<String> list = new ArrayList<>();    
    
    public static void add(String account){
        list.add(account);
    }
    public static void remove(String account){
        list.remove(account);
    }
    public static int getSize(){
        return list.size();                
    }
    
    
}
