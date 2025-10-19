/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model;

import java.time.LocalDate;

/**
 *
 * @author hieuchu
 */
public class BorrowedBookDTO {
    private int bookID ;
    private String coverImage ;
    private String slug ;
    private LocalDate borrowDate ;
    private LocalDate dueDate ;

    public BorrowedBookDTO() {
    }

    public BorrowedBookDTO(int bookID, String coverImage, String slug, LocalDate borrowDate, LocalDate dueDate) {
        this.bookID = bookID;
        this.coverImage = coverImage;
        this.slug = slug;
        this.borrowDate = borrowDate;
        this.dueDate = dueDate;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }
    
     
    
}
