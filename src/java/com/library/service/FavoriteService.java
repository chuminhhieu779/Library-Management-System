/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class FavoriteService {

    private static final Logger logger = LoggerFactory.getLogger(FavoriteService.class);

    private  final UserDao userDao ;
    private  final BookDao bookDao ;

    public FavoriteService(UserDao userDao, BookDao bookDao) {
        this.userDao = userDao;
        this.bookDao = bookDao;
    }
     

    public int getUserIdByAccount(String account) {
        int userID = this.userDao.findUserID(account);
        if (userID <= 0) {
            logger.warn("User not found for account: {}", account);
            return -1;
        }
        return userID;
    }

    public boolean addBookToFavorite(int bookID, int userID) {        
        if(!this.bookDao.existsFavorite(userID, bookID)){
            this.bookDao.insertBookToFavorite(bookID, userID);
            return true ;
        }
        return false;     
    }
}
