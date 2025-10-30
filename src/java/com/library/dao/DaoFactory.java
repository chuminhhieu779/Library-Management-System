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
        return new UserImplementDao();
    }

    public static BookDao getBookDao() {
        return new BookImplementDao();
    }

    public static BorrowingDao getBorrowingDao() {
        return new BorrowingImplement();
    }

    public static  CategoryDao getCategoryDao() {
        return new CategoryImplement();
    }
    
    public static ActivityDao getActivityDao(){
        return new ActivityImpl();
    }    
    
    public static ActionDao getActionDao(){
        return new ActionDaoImpl();
    }
}
