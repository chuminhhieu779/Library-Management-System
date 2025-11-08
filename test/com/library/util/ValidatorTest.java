/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.util;

import com.library.dao.UserDao;
import com.library.exception.ValidationException;
import com.library.factory.DaoFactory;
import com.library.model.entity.User;
import static org.junit.Assert.assertFalse;

import static org.junit.Assert.assertTrue;
import org.junit.Test;

/**
 *
 * @author hieuchu
 */
public class ValidatorTest {

    private final UserDao userDao = DaoFactory.getUserDao();

    @Test
    public void testRequireNotEmptyValid() {
        Validator.requireNotEmpty("Hello");
    }

    @Test(expected = ValidationException.class)
    public void testRequireNotEmptyEmpty() {
        Validator.requireNotEmpty("");
        Validator.requireNotEmpty(null);
    }

    @Test
    public void testUsernameValid() {
        Validator.validateUsername("Hieu_123");
    }

    @Test(expected = ValidationException.class)
    public void testUsernameInvalid() {
        Validator.validateUsername("ab");
        Validator.validateUsername("Hieu@123");
    }

    @Test
    public void testUserAccountValid() {
        Validator.validateUserAccount("hieuminh9873@gmail.com");
    }

    @Test(expected = ValidationException.class)
    public void testUserAccountInvalid() {
        Validator.validateUserAccount("@gmail.com");
        Validator.validateUserAccount("UserName@gmail.com123");
    }

    @Test
    public void testUserInputValid() {
        Validator.validateUserInput("abc123", "password");
    }

    @Test(expected = ValidationException.class)
    public void testUserInputInvalid() {
        Validator.validateUserInput("", "password");
        Validator.validateUserInput("abc123", "");
    }

    @Test
    public void testHashPassword() {
        String account = "suzune123";
        String password = "1234";
        String hashedPassword = userDao.findHashedPassword(account);
        assertTrue(HashPassword.checkPassword(password, hashedPassword));
    }

    @Test
    public void testHashPasswordFailed() {
        String account = "suzune123";
        String password = "124";
        String hashedPassword = userDao.findHashedPassword(account);
        assertFalse(HashPassword.checkPassword(password, hashedPassword));
    }

}
