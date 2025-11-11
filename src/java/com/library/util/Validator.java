/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import com.library.exception.ValidationException;
import java.util.regex.Pattern;

/**
 *
 * @author hieuchu
 */
public class Validator {

    // Check if string is null or empty
    public static void requireNotEmpty(String value) {
        if (value == null || value.trim().isEmpty()) {
            throw new ValidationException(" cannot be empty!");
        }
    }


    public static void validateUsername(String username) {
        requireNotEmpty(username);
        if (!username.matches("^[a-zA-Z0-9_]{3,20}$")) {
            throw new ValidationException("Username must contain 3–20 letters, digits");
        }
    }

    public static void validateSearchBook(String value) {
        if (!value.matches("^[\\p{L}\\s]+$")) {
            throw new ValidationException("Title must contain only letters!");
        }
    }
/*
    ^[a-z0-9] : start with normal or number character
    ([a-z0-9._%+-]{0,62}[a-z0-9])? : allow valid char 
    @gmail\\.com$ : end with @gamil.com 
    
    */
    public static void validateUserAccount(String account) {
        String gmailRegex = "^[A-Za-z0-9]([A-Za-z0-9._%+-]{0,62}[A-Za-z0-9])?@gmail\\.com$";
        if (!account.matches(gmailRegex)) {
            throw new ValidationException("Account must be email format!");
        }
    }
  
    public static void validateUserInput(String account, String password) {
        if (account == null || account.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            throw new ValidationException("Account or Password cannot be empty !!");
        }
    }

}
