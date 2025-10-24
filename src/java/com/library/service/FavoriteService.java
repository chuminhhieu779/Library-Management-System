/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BookImplementDao;
import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class FavoriteService {

    private static final Logger logger = LoggerFactory.getLogger(FavoriteService.class);

    private final UserDao userDao = new UserImplementDao();
    private final BookDao bookDao = new BookImplementDao();

    public int getUserIdByAccount(String account) {
        int userID = userDao.findUserID(account);
        if (userID <= 0) {
            logger.warn("User not found for account: {}", account);
            return -1;
        }
        return userID;
    }

    public boolean addBookToFavorite(int bookID, int userID) {        
        if(!bookDao.existsFavorite(userID, bookID)){
            bookDao.insertBookToFavorite(bookID, userID);
            return true ;
        }
        return false;     
    }
}
