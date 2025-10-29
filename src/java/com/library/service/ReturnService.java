/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BorrowingDao;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class ReturnService {

    private static final Logger logger = LoggerFactory.getLogger(ReturnService.class);
    private final BookDao bookDao;
    private final BorrowingDao borrowDao;

    public ReturnService(BookDao bookDao, BorrowingDao borrowDao) {
        this.bookDao = bookDao;
        this.borrowDao = borrowDao;
    }
    
    public int getBookIDBySlug(String slug){
        return this.bookDao.getIDBook(slug);
    }
    public boolean returnBook(String account, String slug) {
        try (
             Connection conn = DBConnection.getInstance().getConnection()) {
            conn.setAutoCommit(false);
            try{
                this.bookDao.increaseQuantity(conn, slug);
                this.borrowDao.updateBookStatus(conn, account, slug);
                conn.commit();
                return true ;
            }catch(SQLException s){
                conn.rollback();                
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return false;
    }
}
