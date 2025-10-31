/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.entity.Book;
import com.library.model.entity.Categorie;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.eclipse.jdt.internal.compiler.apt.model.Factory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class CategoryDaoImpl implements CategoryDao {

    private static final Logger logger = LoggerFactory.getLogger(CategoryDaoImpl.class);

    @Override
    public List<Book> categorizeBook(String category) {       
        List<Book> list = new ArrayList<>();         
        String sql = "select * from categories join books on categories.category_id = books.category_id where categories.name = ? ";
        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, category);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();               
                b.setBookID(rs.getInt("book_id"));
                b.setSlug(rs.getString("slug"));
                b.setCoverImage(rs.getString("cover_image"));
                list.add(b);              
            }
        } catch (SQLException s) {
            logger.error("Execute error {}", s.getMessage(), s);
        }
        return list;
    }

    @Override
    public List<Book> getAllBook() {
        List<Book> list = new ArrayList<>();
        String sql = "select * from books ";
        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setBookID(rs.getInt("book_id"));
                b.setSlug(rs.getString("slug"));
                b.setCoverImage(rs.getString("cover_image"));
                list.add(b);
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return list;
    }

}
