/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Books;
import java.util.List;
import java.util.Map;

/**
 *
 * @author hieuchu
 */
public interface CategoryDao {
    List<Books> categorizeBook(String category );
    List<Books> getAllBook();
}
