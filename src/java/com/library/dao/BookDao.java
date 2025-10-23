/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Books;
import java.sql.Connection;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface BookDao {
     List<Books> getALLBook();
     Books showBookDetail(String slug, int bookID);
     int totalBook();
     List<Books> searchBook(String query );    
     void favoriteBook(int bookID, int  userID);
     Books addBookToFavorite(int bookID); 
     void decreaseQuantity(Connection conn, int bookID);
}
