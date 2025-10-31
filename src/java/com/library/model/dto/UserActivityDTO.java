/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.dto;

import java.time.LocalDateTime;

/**
 *
 * @author hieuchu
 */
public class UserActivityDTO {
   private String account ;
   private String action;
   private String detail ;
   private String log_time ;
  
    public UserActivityDTO() {
    }

    public UserActivityDTO(String account, String action, String detail, String log_time) {
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

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
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
