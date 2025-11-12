/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BorrowingDao;
import com.library.dao.ExtendRequestDao;
import com.library.factory.DaoFactory;
import com.library.model.dto.BorrowedBookDTO;
import com.library.model.dto.ExtendRequestDTO;
import java.time.LocalDate;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public class ExtendBookService {

    private final BookDao bookDao;
    private final BorrowingDao borrowDao;
    private final ExtendRequestDao extendDao ;

    public ExtendBookService(BookDao bookDao, BorrowingDao borrowDao ,ExtendRequestDao extendDao) {
        this.bookDao = bookDao;
        this.borrowDao = borrowDao;
        this.extendDao = extendDao;
    }

    public int limitExtend(int bookID, String account) {
        int extendCount = borrowDao.getExtendCount(bookID, account);
        return extendCount;
    }

    public boolean extendDueDay(int bookID, LocalDate newDueDate, String account) {
        return this.borrowDao.extendDueDay(bookID, newDueDate, account);
    }

    public BorrowedBookDTO getBorrowdBookFromList(List<BorrowedBookDTO> list) {
        BorrowedBookDTO dto = new BorrowedBookDTO();
        for (BorrowedBookDTO b : list) {
            dto.setBookID(b.getBookID());
            dto.setCoverImage(b.getCoverImage());
            dto.setDueDate(b.getDueDate());
            dto.setSlug(b.getSlug());
            dto.setName(b.getName());
        }
        return dto;
    }
    
    public void insertData(ExtendRequestDTO e){
        this.extendDao.insertExtendRequest(e);
    }
    

}
