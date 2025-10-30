/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.exception.BookDataAccessException;
import com.library.model.Books;
import java.sql.Connection;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public interface BookDao {

    List<Books> getAllBook()throws BookDataAccessException;

    Books showBookDetail(String slug, int bookID);

    int totalBook();

    List<Books> searchBook(String query);

    void insertBookToFavorite(int bookID, int userID);

    List<Books> showBookFromFavorite(int userID);

    void decreaseQuantity(Connection conn, int bookID);

    void increaseQuantity(Connection conn, String slug);

    boolean existsFavorite(int userID, int bookID);
    
    int getCurrentQuantity(Connection conn , int bookID);
    
    boolean deleteBook(int bookID);

    String getBookTitleByID(int bookID);
    int getIDBook(String slug);

}
