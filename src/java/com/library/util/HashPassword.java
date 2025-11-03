/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author hieuchu
 */
public class HashPassword {

    public static String hash(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(10)); // salt with 10 cost 
    }

    public static boolean checkPassword(String password, String hashedPassword) {
        boolean confirm = BCrypt.checkpw(password, hashedPassword);
        if (confirm) {
            return true;
        }
        return false;
    }
}
