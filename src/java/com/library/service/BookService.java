/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BorrowingDao;
import com.library.dao.CategoryDao;
import com.library.dao.FavoriteDao;
import com.library.dao.UserDao;
import com.library.model.entity.Book;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BookService {

    private static final Logger logger = LoggerFactory.getLogger(BookService.class);
    private final BookDao bookDao;
    private final CategoryDao categoryDao;

    public BookService(BookDao bookDao, CategoryDao categoryDao) {
        this.bookDao = bookDao;
        this.categoryDao = categoryDao;
    }

    public String removeAccent(String title) {
        if (title == null) {
            return null;
        }
        String normalized = Normalizer.normalize(title, Normalizer.Form.NFD);
        Pattern pattern = Pattern.compile("\\p{M}");
        return pattern.matcher(normalized)
                .replaceAll("")
                .replaceAll("đ", "d")
                .replaceAll("Đ", "D");
    }

    public List<Book> findBook(String title) {
        return bookDao.searchBook(title);
    }

    public boolean isBookFound(List<Book> list) {
        if (list.isEmpty() || list == null) {
            return false;
        }
        return true;
    }

    public String normalizeCategory(String value) {
        String tmp = value.substring(0, 1).toLowerCase() + value.substring(1);
        return tmp;
    }

    public int getCategoryID(String name) {
        int ID = this.categoryDao.findCategoryID(name);
        logger.info("category ID {}", ID);
        return ID;
    }

    public boolean addBook(Book b) {
        if (this.bookDao.insertBook(b) > 0) {
            return true;
        }
        logger.info("can not add book {} ", b.getTitle());
        return false;
    }
    
     public Map<String, Integer> getNumberBorrowedBookByCategory() {
         return this.bookDao.countingBorrowedBookByCategory();
    }
     
     public int getBookIDByCover(String cover){
         return this.bookDao.getBookID(cover);
     }
    
}
