/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.ActivityDao;
import com.library.dao.BorrowingDao;
import com.library.dao.FavoriteDao;
import com.library.dao.UserDao;
import com.library.dao.UserSessionDao;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;

/**
 *
 * @author hieuchu
 */
public class RemoveUserService {

    private final UserDao userDao;
    private final ActivityDao activityDao;
    private final BorrowingDao borrowDao;
    private final FavoriteDao favoriteDao;
    private final UserSessionDao userSessionDao;

    public RemoveUserService(UserDao userDao, ActivityDao activityDao, BorrowingDao borrowDao, FavoriteDao favoriteDao, UserSessionDao userSessionDao) {
        this.userDao = userDao;
        this.activityDao = activityDao;
        this.borrowDao = borrowDao;
        this.favoriteDao = favoriteDao;
        this.userSessionDao = userSessionDao;
    }

    public boolean removeUser(int userID) {
        try {
            Connection conn = DBConnection.getInstance().getConnection();
            conn.setAutoCommit(false);
            try {
                this.userSessionDao.deleteUserFromSessions(conn, userID);
                this.activityDao.deleteUserFromActivityLog(conn, userID);
                this.borrowDao.deleteUserFromBorrowings(conn, userID);
                this.favoriteDao.deleteUserFromFavorites(conn, userID);
                if (this.userDao.deleteUser(conn, userID)) {
                    conn.commit();
                    return true;
                }
            } catch (SQLException s1) {
                conn.rollback();
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return false;
    }
}
