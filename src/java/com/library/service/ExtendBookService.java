/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BorrowingDao;
import com.library.factory.DaoFactory;
import java.time.LocalDate;

/**
 *
 * @author hieuchu
 */
public class ExtendBookService {

    private final BookDao bookDao;
    private final BorrowingDao borrowDao ;

    public ExtendBookService(BookDao bookDao, BorrowingDao borrowDao) {
        this.bookDao = bookDao;
        this.borrowDao = borrowDao;
    }

    public int limitExtend(int bookID, String account) {
        int extendCount = borrowDao.getExtendCount(bookID, account);
        return extendCount;
    }

      public boolean extendDueDay(int bookID, LocalDate newDueDate, String account){
       return this.borrowDao.extendDueDay(bookID, newDueDate, account) ;
   }
      
      
}
