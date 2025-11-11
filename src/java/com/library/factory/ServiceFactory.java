/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.factory;

import com.library.service.ActivityService;
import com.library.service.BookService;
import com.library.service.BorrowingService;
import com.library.service.ExtendBookService;
import com.library.service.FavoriteService;
import com.library.service.RemoveBookService;
import com.library.service.RemoveUserService;
import com.library.service.ReturnService;
import com.library.service.TrackingUserService;
import com.library.service.UserService;

/**
 *
 * @author hieuchu
 */
public final class ServiceFactory {
    
    private static ActivityService activityService;
    private static BookService bookService;
    private static BorrowingService borrowService;
    private static FavoriteService favoriteService;
    private static RemoveBookService removeBookService;
    private static ReturnService returnService;
    private static TrackingUserService trackService;
    private static UserService userService;
    private static RemoveUserService removeUserService;
    private static ExtendBookService extendBookSerivce ;

    private ServiceFactory() {

    }

    public static ActivityService getActivityService() {
        if (activityService == null) {
            activityService = new ActivityService(
                    DaoFactory.getActivityDao(),
                    DaoFactory.getActionDao(),
                    DaoFactory.getUserDao(),
                    DaoFactory.getBookDao()
            );
        }
        return activityService;
    }

    public static BookService getBookService() {
        if (bookService == null) {
            bookService = new BookService(
                    DaoFactory.getBookDao(),
                    DaoFactory.getCategoryDao()
            );
        }
        return bookService;
    }

    public static BorrowingService getBorrowService() {      
        if (borrowService == null) {
            borrowService = new BorrowingService(
                    DaoFactory.getBorrowingDao(),
                    DaoFactory.getUserDao(),
                    DaoFactory.getBookDao()
            );
        }
        return borrowService;
    }

    public static FavoriteService getFavoriteService() {
        if (favoriteService == null) {
            favoriteService = new FavoriteService(
                    DaoFactory.getUserDao(),
                    DaoFactory.getBookDao()
            );
        }
        return favoriteService;
    }

    public static RemoveBookService getRemoveBookService() {
        if (removeBookService == null) {
            removeBookService = new RemoveBookService(
                    DaoFactory.getBookDao(),
                    DaoFactory.getBorrowingDao(),
                    DaoFactory.getFavoriteDao()
            );
        }
        return removeBookService;
    }

    public static ReturnService getReturnService() {
        if (returnService == null) {
            returnService = new ReturnService(
                    DaoFactory.getBookDao(),
                    DaoFactory.getBorrowingDao()
            );
        }
        return returnService;
    }

   
    public static TrackingUserService getTrackingUserService() {
        if (trackService == null) {
            trackService = new TrackingUserService(
                    DaoFactory.getUserSessionDao(),
                    DaoFactory.getUserDao()
            );
        }
        return trackService;
    }

    public static UserService getUserService() {
        if (userService == null) {
            userService = new UserService(
                    DaoFactory.getUserDao(),
                    DaoFactory.getAdminDao(),
                    DaoFactory.getUserSessionDao()
            );
        }
        return userService;
    }

    public static RemoveUserService getRemoveUserService() {
        if (removeUserService == null) {
            removeUserService = new RemoveUserService(
                    DaoFactory.getUserDao(),
                    DaoFactory.getActivityDao(),
                    DaoFactory.getBorrowingDao(),
                    DaoFactory.getFavoriteDao(),
                    DaoFactory.getUserSessionDao()
            );
        }
        return removeUserService;
    }
    
    public static ExtendBookService getExtendBookService(){
        if(extendBookSerivce == null){
            extendBookSerivce = new ExtendBookService(
                    DaoFactory.getBookDao(),                    
                    DaoFactory.getBorrowingDao()
            );
        }
        return extendBookSerivce;
    }
}
