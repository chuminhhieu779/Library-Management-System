/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.factory;

import com.library.dao.ActionDao;
import com.library.dao.ActionDaoImpl;
import com.library.dao.ActivityDao;
import com.library.dao.ActivityDaoImpl;
import com.library.dao.AdminDao;
import com.library.dao.AdminDaoImpl;
import com.library.dao.BookDao;
import com.library.dao.BookDaoImpl;
import com.library.dao.BorrowingDao;
import com.library.dao.BorrowingDaoImpl;
import com.library.dao.CategoryDao;
import com.library.dao.CategoryDaoImpl;
import com.library.dao.FavoriteDao;
import com.library.dao.FavoriteDaoImpl;
import com.library.dao.UserDao;
import com.library.dao.UserDaoImpl;
import com.library.dao.UserSessionDao;
import com.library.dao.UserSessionDaoImpl;

/**
 *
 * @author hieuchu
 */
public final class DaoFactory {

    private DaoFactory() {
    }

    private static final UserDao userDao = new UserDaoImpl();
    private static final BookDao bookDao = new BookDaoImpl();
    private static final BorrowingDao borrowingDao = new BorrowingDaoImpl();
    private static final CategoryDao categoryDao = new CategoryDaoImpl();
    private static final ActivityDao activityDao = new ActivityDaoImpl();
    private static final ActionDao actionDao = new ActionDaoImpl();
    private static final AdminDao adminDao = new AdminDaoImpl();
    private static final FavoriteDao favoriteDao = new FavoriteDaoImpl();
    private static final UserSessionDao userSessionDao = new UserSessionDaoImpl();

    public static UserDao getUserDao() {
        return userDao;
    }

    public static BookDao getBookDao() {
        return bookDao;
    }

    public static BorrowingDao getBorrowingDao() {
        return borrowingDao;
    }

    public static CategoryDao getCategoryDao() {
        return categoryDao;
    }

    public static ActivityDao getActivityDao() {
        return activityDao;
    }

    public static ActionDao getActionDao() {
        return actionDao;
    }

    public static AdminDao getAdminDao() {
        return adminDao;
    }

    public static FavoriteDao getFavoriteDao() {
        return favoriteDao;
    }

    public static UserSessionDao getUserSessionDao() {
        return userSessionDao;
    }
}
