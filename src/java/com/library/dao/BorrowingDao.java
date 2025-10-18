/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

/**
 *
 * @author hieuchu
 */
public interface BorrowingDao {
    int totalBorrowedBooks(String account);
    int totalReturnedBooks(String account);
}
