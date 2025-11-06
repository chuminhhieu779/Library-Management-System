/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import java.security.SecureRandom;

/**
 *
 * @author hieuchu
 */
public class RandomPassword {

    public static String generatePassword() {
        SecureRandom secure = new SecureRandom();
        StringBuilder sb = new StringBuilder();
        for(int i = 0 ; i < 5 ; i++){
            int number = secure.nextInt(5);
            sb.append(number);
        }
        String tmp = sb.toString();       
        return tmp ;
    }
}
