/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.entity;

import com.library.model.entity.Action;
import java.time.LocalDateTime;





/**
 *
 * @author hieuchu
 */


public class Activity {
    private int activityID ;
    private Users user ;
    private Action action ; // object reference
    private String detail;
    private LocalDateTime logTime ;

    public Activity() {
    }

    public Activity(int activityID, Users user, Action action, String detail, LocalDateTime logTime) {
        this.activityID = activityID;
        this.user = user;
        this.action = action;
        this.detail = detail;
        this.logTime = logTime;
    }

    public int getActivityID() {
        return activityID;
    }

    public void setActivityID(int activityID) {
        this.activityID = activityID;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public Action getAction() {
        return action;
    }

    public void setAction(Action action) {
        this.action = action;
    }

    public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail;
    }

    public LocalDateTime getLogTime() {
        return logTime;
    }

    public void setLogTime(LocalDateTime logTime) {
        this.logTime = logTime;
    }
    
    
}


