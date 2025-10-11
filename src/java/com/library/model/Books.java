/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model;

/**
 *
 * @author ADMIN
 */
public class Books {
    private int bookID;
    private String title;
    private String author;
    private int categoryID;
    private int quantity;
    private String description;
    private String coverImage;

    public Books() {
    }

    public Books(int bookID, String title, String author, int categoryID, int quantity, String description, String coverImage) {
        this.bookID = bookID;
        this.title = title;
        this.author = author;
        this.categoryID = categoryID;
        this.quantity = quantity;
        this.description = description;
        this.coverImage = coverImage;
    }

    public int getBookID() {
        return bookID;
    }

    public void setBookID(int bookID) {
        this.bookID = bookID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCoverImage() {
        return coverImage;
    }

    public void setCoverImage(String coverImage) {
        this.coverImage = coverImage;
    }

    
    
}
