/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.ActionDao;
import com.library.dao.ActivityDao;
import com.library.dao.BookDao;
import com.library.dao.UserDao;
import com.library.enums.ActionType;
import com.library.model.entity.Action;
import com.library.model.entity.Activity;
import com.library.model.dto.AdminDashBoardDTO;
import com.library.model.dto.UserActivityDTO;
import com.library.util.TimeFormatter;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class ActivityService {

    private static final Logger logger = LoggerFactory.getLogger(BorrowingService.class);
    private final ActivityDao activityDao;
    private final ActionDao actionDao;
    private final UserDao userDao;
    private final BookDao bookDao;

    public ActivityService(ActivityDao activityDao, ActionDao actionDao, UserDao userDao, BookDao bookDao) {
        this.activityDao = activityDao;
        this.actionDao = actionDao;
        this.userDao = userDao;
        this.bookDao = bookDao;

    }
  

    public String getBookTitle(int bookID) {
        return this.bookDao.getBookTitleByID(bookID);
    }

    public void ActivityUser(int actionID, String account) {
        int userId = this.userDao.findUserID(account);
        String actionName = this.actionDao.getNameByID(actionID);
        String detail = "";
        if (actionName.equalsIgnoreCase("login")) {
            detail = account + " has just logged in ";
        }
        if (actionName.equalsIgnoreCase("update profile")) {
            detail = account + " has just updated their profile ";
        }     
        logger.info("userid {} is logging ", userId);
        this.activityDao.insertData(userId, actionID, detail, LocalDateTime.now());
    }

    public void BookActivityOfUser(String account, int actionID, int bookID) {
        int userID = this.userDao.findUserID(account);
        String actionName = this.actionDao.getNameByID(actionID);
        String detail = "";
        if (actionName.equalsIgnoreCase("borrow book")) {
            detail = account + "has just borrowed " + getBookTitle(bookID);
        }
        if (actionName.equalsIgnoreCase("return book")) {
            detail = account + "has just returned " + getBookTitle(bookID);
        }
       this.activityDao.insertData(userID, actionID, detail, LocalDateTime.now());

    }

        public UserActivityDTO getLatestActivityByAction(int actionID) {
            Activity activity = activityDao.getLatestByAction(actionID);
            if (activity != null) {
                UserActivityDTO dto = new UserActivityDTO();
                dto.setAccount(activity.getUser().getAccount());
                Action a = new Action();
                a.setType(activity.getAction().getType());                    
                dto.setAction(a);
                dto.setDetail(activity.getDetail());
                dto.setLog_time(TimeFormatter.timeAgo(activity.getLogTime()));
                return dto;
            }
            return null;
        }

    public AdminDashBoardDTO  adminDashBoard(){        
        AdminDashBoardDTO dto = new AdminDashBoardDTO();
        dto.setTotalOnlineUser(TrackingUserService.getSize());      
        dto.setTotalBook(this.bookDao.totalBook());
        List<Action> list = this.actionDao.getAllAction();
        List<UserActivityDTO> listActivities = new ArrayList<>();
        for(Action a : list){
            UserActivityDTO act = getLatestActivityByAction(a.getActionID()); // take new log of a user 
            listActivities.add(act); /// add log user into list
        }               
        dto.setActionList(listActivities); // set list 
        return dto ;
    }

}
