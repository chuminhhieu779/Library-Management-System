/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.model.dto.BorrowedBookDTO;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BorrowingService {

    private static final Logger logger = LoggerFactory.getLogger(BorrowingService.class);

    private final BorrowingDao borrowDao;
    private final UserDao userDao;
    private final BookDao bookDao;

    public BorrowingService(BorrowingDao borrowDao, UserDao userDao, BookDao bookDao) {
        this.borrowDao = borrowDao;
        this.userDao = userDao;
        this.bookDao = bookDao;
    }

    public int getUserIDByAccount(String account) {
        int userID = this.userDao.findUserID(account);
        if (userID > 0) {
            return userID;
        }
        return -1;
    }

    public boolean canBorrowBook(int bookID, int userID) {
        if (!this.borrowDao.hasUserBorrowedBook(bookID, userID) && this.borrowDao.numberOfBorrowBookOnPerUser() < 10) {
            return true;
        }
        return false;
    }

    public void borrowBook(String slug, int bookID, int userID) {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            conn.setAutoCommit(false);
            try {
                if (this.bookDao.getCurrentQuantity(conn, bookID) > 0) {
                    this.borrowDao.insertBook(conn, bookID, userID);
                    conn.commit();
                }
            } catch (SQLException s) {
                conn.rollback();
            }
        } catch (SQLException s1) {
            s1.printStackTrace();
        }
    }

    public void approveBorrowRequest(int borrowId, int adminId, int bookID) {
        try (Connection conn = DBConnection.getInstance().getConnection()) {
            conn.setAutoCommit(false);
            try {
                this.borrowDao.approveBorrowing(conn, borrowId, adminId);
                this.bookDao.decreaseQuantity(conn, bookID);
                conn.commit();
                logger.info("Borrow request {} approved by admin {}", borrowId, adminId);
            } catch (SQLException e) {
                conn.rollback();
                logger.error("Error approving borrow request: {}", e.getMessage(), e);
            }
        } catch (SQLException e) {
            logger.error("DB connection error while approving request", e);
        }
    }

    public LocalDate getBorrowDate(int bookID) {
        return this.borrowDao.getBorrowDate(bookID);
    }

    public int getExtendCount(int bookID, String account) {
        return this.borrowDao.getExtendCount(bookID, account);
    }

    public List<BorrowedBookDTO> borrowedBooksList(String account) {
        return this.borrowDao.borrowedBooksList(account);
    }

    public void incrementExtendCount(int bookId, String account) {
        this.borrowDao.incrementExtendCount(bookId, account);
    }

}
