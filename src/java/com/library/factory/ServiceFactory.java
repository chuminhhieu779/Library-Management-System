/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.factory;

import com.library.service.ActivityService;
import com.library.service.BookService;
import com.library.service.BorrowingService;
import com.library.service.FavoriteService;
import com.library.service.RemoveBookService;
import com.library.service.ReturnService;
import com.library.service.TrackingUserService;
import com.library.service.UserService;

/**
 *
 * @author hieuchu
 */
public class ServiceFactory {

    private static final ActivityService activityService = new ActivityService(
            DaoFactory.getActivityDao(),
            DaoFactory.getActionDao(),
            DaoFactory.getUserDao(),
            DaoFactory.getBookDao()
    );

    private static final BookService bookService = new BookService(
            DaoFactory.getBookDao()
    );

    private static final BorrowingService borrowService = new BorrowingService(
            DaoFactory.getBorrowingDao(),
            DaoFactory.getUserDao(),
            DaoFactory.getBookDao()
    );

    private static final FavoriteService favoriteService = new FavoriteService(
            DaoFactory.getUserDao(),
            DaoFactory.getBookDao()
    );

    private static final RemoveBookService removeBookSerivice = new RemoveBookService(
            DaoFactory.getBookDao(),
            DaoFactory.getBorrowingDao(),
            DaoFactory.getFavoriteDao()
    );

    private static final ReturnService returnService = new ReturnService(
            DaoFactory.getBookDao(),
            DaoFactory.getBorrowingDao()
    );

    private static final TrackingUserService trackService = new TrackingUserService(
            DaoFactory.getUserSessionDao()
    );
    private static final UserService userService = new UserService(
            DaoFactory.getUserDao(),
            DaoFactory.getAdminDao()
    );

    private ServiceFactory() {
        
    }

    public static ActivityService getActivitySerivce() {
        return activityService;
    }

    public static BookService getBookService() {
        return bookService;
    }

    public static BorrowingService getBorrowService() {
        return borrowService;
    }

    public static FavoriteService getFavoriteService() {
        return favoriteService;
    }

    public static RemoveBookService getRemoveBookService() {
        return removeBookSerivice;
    }

    public static ReturnService getReturnBookService() {
        return returnService;
    }

    public static TrackingUserService getTrackingUserService() {
        return trackService;
    }

    public static UserService getUserService() {
        return userService;
    }

}
