/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.util.BookDataAccessException;
import com.library.model.entity.Book;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
public interface BookDao {

    List<Book> getAllBook()throws BookDataAccessException;

    Book showBookDetail(String slug, int bookID);

    int totalBook();

    List<Book> searchBook(String query);

    void insertBookToFavorite(int bookID, int userID);

    List<Book> showBookFromFavorite(int userID);

    void decreaseQuantity(Connection conn, int bookID);

    void increaseQuantity(Connection conn, String slug);

    boolean existsFavorite(int userID, int bookID);
    
    int getCurrentQuantity(Connection conn , int bookID);
    
    void deleteBook( Connection conn , int bookID);

    String getBookTitleByID(int bookID);
    
    int getIDBook(String slug);
    
    int insertBook(Book b); 
    Map<String, Integer> countingBorrowedBookByCategory();
    
}
