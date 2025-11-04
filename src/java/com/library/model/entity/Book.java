/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.entity;

/**
 *
 * @author ADMIN
 */
public class Book {

    private int bookID;
    private String title;
    private String slug ;
    private String author;
    private Category category;
    private int quantity;
    private String description;
    private String coverImage;

    public Book() {
    }

    public Book(int bookID, String title, String slug, String author, Category category, int quantity, String description, String coverImage) {
        this.bookID = bookID;
        this.title = title;
        this.slug = slug;
        this.author = author;
        this.category = category;
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

    public String getSlug() {
        return slug;
    }

    public void setSlug(String slug) {
        this.slug = slug;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
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
