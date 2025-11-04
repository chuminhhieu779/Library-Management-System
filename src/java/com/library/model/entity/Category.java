/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.model.entity;

import com.library.enums.BookType;
import com.library.model.entity.Book;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class Category {
    private int categoryID;
    private BookType type ;           

    public Category() {
    }
    
    public Category(int categoryID, BookType type) {
        this.categoryID = categoryID;
        this.type = type;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public BookType getType() {
        return type;
    }

    public void setType(BookType type) {
        this.type = type;
    }
    
   
}
