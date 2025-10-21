/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Books;
import com.library.model.Categories;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BookImplementDao implements BookDao {

    private static final Logger logger = LoggerFactory.getLogger(BookImplementDao.class);
    private Connection conn = DBConnection.getInstance().getConnection();

    @Override
    public List<Books> getALLBook() {
        List<Books> list = new ArrayList<>();
        String sql = "select * from books ";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Books b = new Books();
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

    @Override
    public Books showBookDetail(String slug, int bookID) {
        String sql = "select * from books join categories on books.category_id = categories.category_id where books.slug = ? and books.book_id = ? ";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, slug);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Books b = new Books();
                b.setSlug(rs.getString("slug"));
                b.setBookID(rs.getInt("book_id"));
                b.setAuthor(rs.getString("author"));
                b.setTitle(rs.getString("title"));
                b.setQuantity(rs.getInt("quantity"));
                b.setDescription(rs.getString("description"));
                b.setCoverImage(rs.getString("cover_image"));
                Categories c = new Categories();
                c.setName(rs.getString("name"));
                b.setCategory(c);
                return b;
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return null;
    }

    @Override
    public int totalBook() {
        int sum = 0;
        String sql = "select count(*) as total from Books";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                sum = rs.getInt("total");
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return sum;
    }

    @Override
    public List<Books> searchBook(String query) {
        List<Books> list = new ArrayList<>();
        String sql = "select * from books\n"
                + "where title_unaccented like ? ";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Books b = new Books();
                b.setSlug(rs.getString("slug"));
                b.setAuthor(rs.getString("author"));
                b.setTitle(rs.getString("title"));
                b.setQuantity(rs.getInt("quantity"));
                b.setDescription(rs.getString("description"));
                b.setCoverImage(rs.getString("cover_image"));
                list.add(b);
            }
            return list;
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);

        }
        return null;
    }

    @Override
    public void favoriteBook(int bookID, int userID) {
        String sql = "insert into favorites(user_id, book_id) values (? , ? )";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ps.executeUpdate();
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
    }

    @Override
    public Books addBookToFavorite(int bookID) {
        String sql = "select * from books join favorites on favorites.book_id = books.book_id"
                + " join users on users.user_id = favorites.user_id where favorites.book_id = ? ";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Books b = new Books();
                b.setBookID(rs.getInt("book_id"));
                b.setSlug(rs.getString("slug"));
                b.setAuthor(rs.getString("author"));
                b.setTitle(rs.getString("title"));
                b.setQuantity(rs.getInt("quantity"));
                b.setDescription(rs.getString("description"));
                b.setCoverImage(rs.getString("cover_image"));
                return b;
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);

        }
        return null;
    }
}
