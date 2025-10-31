/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

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
}
