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
public class DaoFactory {

    private  DaoFactory() {
        
    }

    public static UserDao getUserDao() {
        return new UserDaoImpl();
    }

    public static BookDao getBookDao() {
        return new BookDaoImpl();
    }

    public static BorrowingDao getBorrowingDao() {
        return new BorrowingDaoImpl();
    }

    public static  CategoryDao getCategoryDao() {
        return new CategoryDaoImpl();
    }
    
    public static ActivityDao getActivityDao(){
        return new ActivityDaoImpl();
    }    
    
    public static ActionDao getActionDao(){
        return new ActionDaoImpl();
    }
    public static AdminDao getAdminDao(){
        return new AdminDaoImpl();
    }
    public static FavoriteDao getFavoriteDao(){
        return new FavoriteDaoImpl();
    }    
    
    public static UserSessionDao getUserSessionDao(){
        return new UserSessionDaoImpl();
    }
    
    
}
