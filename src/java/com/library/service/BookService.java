/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.service;

import com.library.dao.BookDao;
import com.library.dao.BorrowingDao;
import com.library.dao.UserDao;
import com.library.model.entity.Book;
import java.text.Normalizer;
import java.util.List;
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

    public BookService(BookDao bookDao) {
        this.bookDao = bookDao;
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

}
