/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import com.library.exception.ValidationException;

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

    // Validate username (3-20 characters, only letters/numbers/_)
    public static void validateUsername(String username) {
        requireNotEmpty(username);
        if (!username.matches("^[a-zA-Z0-9_]{3,20}$")) {
            throw new ValidationException("Username must contain 3–20 letters, digits, or underscores only!");
        }
    }

    public static void validateSearchBook(String value) {
        if (!value.matches("^[\\p{L}\\s]+$")) {
            throw new ValidationException("Title must contain only letters!");
        }
    }

    public static void validateUserAccount(String account) {
        if (!account.matches("^[a-z0-9]{5,10}$")) {
            throw new ValidationException( "Account must be 5–10 characters long and contain only lowercase letters or digits!" );
        }
    }

}
