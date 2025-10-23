/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BookImplementDao;
import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingImplement;
import com.library.dao.UserDao;
import com.library.dao.UserImplementDao;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BorrowingService {

    private static final Logger logger = LoggerFactory.getLogger(BorrowingService.class);
    private final BorrowingDao borrowDao = new BorrowingImplement();
    private final UserDao userDao = new UserImplementDao();
    private final BookDao bookDao = new BookImplementDao();

    public boolean canBorrowBook(int bookID, int userID) {
        if (borrowDao.hasUserBorrowedBook(bookID, userID)) {
            return true;
        }
        return false;
    }

    public void borrowBook(String slug, int bookID, int userID) {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            conn.setAutoCommit(false);
            try {
                borrowDao.insertBook(conn, bookID, userID);
                bookDao.decreaseQuantity(conn, bookID);
                conn.commit();
            } catch (SQLException s) {
                conn.rollback();
            }
        } catch (SQLException s1) {
            s1.printStackTrace();
        }

    }
}
