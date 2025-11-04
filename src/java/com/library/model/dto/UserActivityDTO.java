/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.dto;

import com.library.model.entity.Action;
import java.time.LocalDateTime;

/**
 *
 * @author hieuchu
 */
public class UserActivityDTO {
   private String account ;
   private Action action ;
   private String detail ;
   private String log_time ;
  
    public UserActivityDTO() {
    }

    public UserActivityDTO(String account, Action action, String detail, String log_time) {
        this.account = account;
        this.action = action;
        this.detail = detail;
        this.log_time = log_time;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
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

    public String getLog_time() {
        return log_time;
    }

    public void setLog_time(String log_time) {
        this.log_time = log_time;
    }

  

  
     
   
}
