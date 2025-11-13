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
public class ExtendRequestViewDTO {
    private String account;
    private String avatar;
    private String title;   
    private String coverImage;
    private LocalDateTime requestDate;
    private String status;

    public ExtendRequestViewDTO() {
    }

    public ExtendRequestViewDTO(String account, String avatar, String title, String coverImage, LocalDateTime requestDate, String status) {
        this.account = account;
        this.avatar = avatar;
        this.title = title;
        this.coverImage = coverImage;
        this.requestDate = requestDate;
        this.status = status;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public LocalDateTime getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(LocalDateTime requestDate) {
        this.requestDate = requestDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
