/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.dto;

import com.library.enums.RequestStatus;
import com.library.model.entity.Borrowing;
import com.library.model.entity.User;
import java.time.LocalDateTime;

/**
 *
 * @author hieuchu
 */
public class ExtendRequestDTO {

    private Borrowing borrowing;
    private User user;
    private LocalDateTime requestDate;
    private RequestStatus status;

    public ExtendRequestDTO() {
    }

    public ExtendRequestDTO(Borrowing borrowing, User user, LocalDateTime requestDate, RequestStatus status) {
        this.borrowing = borrowing;
        this.user = user;
        this.requestDate = requestDate;
        this.status = status;
    }

    public Borrowing getBorrowing() {
        return borrowing;
    }

    public void setBorrowing(Borrowing borrowing) {
        this.borrowing = borrowing;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDateTime getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(LocalDateTime requestDate) {
        this.requestDate = requestDate;
    }

    public RequestStatus getStatus() {
        return status;
    }

    public void setStatus(RequestStatus status) {
        this.status = status;
    }

}
