/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model;

import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
public class AdminDashBoardDTO {
    private int totalOnlineUser ;
    private List<UserActivityDTO> actionList ;

    public AdminDashBoardDTO() {
    }

    public AdminDashBoardDTO(int totalOnlineUser, List<UserActivityDTO> actionList) {
        this.totalOnlineUser = totalOnlineUser;
        this.actionList = actionList;
    }

    public int getTotalOnlineUser() {
        return totalOnlineUser;
    }

    public void setTotalOnlineUser(int totalOnlineUser) {
        this.totalOnlineUser = totalOnlineUser;
    }

    public List<UserActivityDTO> getActionList() {
        return actionList;
    }

    public void setActionList(List<UserActivityDTO> actionList) {
        this.actionList = actionList;
    }

  

    
  
}
