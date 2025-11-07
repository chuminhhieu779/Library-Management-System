/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import com.library.exception.ValidationException;
import static org.junit.Assert.assertTrue;
import org.junit.Test;

/**
 *
 * @author hieuchu
 */
public class ValidatorTest {

    @Test
    public void testRequireNotEmptyValid() {
        Validator.requireNotEmpty("Hello");       
        assertTrue(true);
    }

    @Test(expected = ValidationException.class)
    public void testRequireNotEmptyEmpty() {
        Validator.requireNotEmpty("");
    }

    @Test(expected = ValidationException.class)
    public void testRequireNotEmptyNull() {
        Validator.requireNotEmpty(null);
    }

    @Test
    public void testValidateUsernameValid() {
        Validator.validateUsername("Hieu_123");
        assertTrue(true);
    }

    @Test(expected = ValidationException.class)
    public void testValidateUsernameTooShort() {
        Validator.validateUsername("ab"); 
    }

    @Test(expected = ValidationException.class)
    public void testValidateUsernameInvalidChar() {
        Validator.validateUsername("Hieu@123"); 
    }


    @Test
    public void testValidateSearchBookValid() {
        Validator.validateSearchBook("Tôi thấy hoa vàng");
        assertTrue(true);
    }

    @Test(expected = ValidationException.class)
    public void testValidateSearchBookInvalid() {
        Validator.validateSearchBook("Harry123"); 
    }


    @Test
    public void testValidateUserAccountValid() {
        Validator.validateUserAccount("abc123");
        assertTrue(true);
    }

    @Test(expected = ValidationException.class)
    public void testValidateUserAccountTooShort() {
        Validator.validateUserAccount("a12");
    }

    @Test(expected = ValidationException.class)
    public void testValidateUserAccountInvalidChar() {
        Validator.validateUserAccount("UserName"); 
    }


    @Test
    public void testValidateUserInputValid() {
        Validator.validateUserInput("abc123", "password");
        assertTrue(true);
    }

    @Test(expected = ValidationException.class)
    public void testValidateUserInputEmptyAccount() {
        Validator.validateUserInput("", "password");
    }

    @Test(expected = ValidationException.class)
    public void testValidateUserInputEmptyPassword() {
        Validator.validateUserInput("abc123", "");
    }
}
