/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.entity.Book;
import com.library.model.dto.BorrowedBookDTO;
import java.sql.Connection;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
public interface BorrowingDao {

    int totalBorrowedBooks(String account);

    int totalReturnedBooks(String account);

    List<BorrowedBookDTO> borrowedBooksList(String account);

    Map<Integer, String> returnedBooksList(String account);
    
    boolean updateBookStatus(Connection conn , String account, String slug);
    
    boolean extendDueDay(int bookID, LocalDate dueDate, String account);
    
    LocalDate getBorrowDate(int bookID);
    
    boolean isBookAvailable(String slug , int bookID);
    
    void insertBook(Connection conn , int bookID, int userID);
    
    boolean hasUserBorrowedBook(int bookID, int userID);
    
    boolean canDeleteBook(int bookID);
    
    void deleteBorrowingsByBookId(Connection conn ,int bookId);

}
