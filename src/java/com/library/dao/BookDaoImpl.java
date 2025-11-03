/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.util.BookDataAccessException;
import com.library.model.entity.Book;
import com.library.model.entity.Categorie;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.Normalizer;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BookDaoImpl implements BookDao {

    private static final Logger logger = LoggerFactory.getLogger(BookDaoImpl.class);

    @Override
    public List<Book> getAllBook() throws BookDataAccessException {
        List<Book> list = new ArrayList<>();
        String sql = " SELECT b.book_id, b.title ,b.slug,  b.author, b.quantity, c.category_id AS category_ID , c.name as category_name , b.cover_image FROM books b LEFT JOIN categories c ON b.category_id = c.category_id ";
        logger.debug("Executing SQL : ", sql);
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Book b = new Book();
                b.setBookID(rs.getInt("book_id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setQuantity(rs.getInt("quantity"));
                b.setSlug(rs.getString("slug"));
                b.setCoverImage(rs.getString("cover_image"));

                Categorie category = new Categorie();
                category.setCategoryID(rs.getInt("category_ID"));
                category.setName(rs.getString("category_name"));
                b.setCategory(category);
                list.add(b);
            }
            logger.info("Retrieved {} books from database", list.size());
        } catch (SQLException e) {
            logger.error("Error retrieving books from database", e);
            throw new BookDataAccessException("Failed to retrieve books from database ");
        }

        return list;
    }

    @Override
    public Book showBookDetail(String slug, int bookID) {
        String sql = "select * from books join categories on books.category_id = categories.category_id where books.slug = ? and books.book_id = ? ";

        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slug);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Book b = new Book();
                b.setSlug(rs.getString("slug"));
                b.setBookID(rs.getInt("book_id"));
                b.setAuthor(rs.getString("author"));
                b.setTitle(rs.getString("title"));
                b.setQuantity(rs.getInt("quantity"));
                b.setDescription(rs.getString("description"));
                b.setCoverImage(rs.getString("cover_image"));
                Categorie c = new Categorie();
                c.setName(rs.getString("name"));
                b.setCategory(c);
                logger.info("Book found: {}", b.getTitle());
                return b;
            } else {
                logger.warn("No book found for slug={} and bookID={}", slug, bookID);
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return null;
    }

    @Override
    public int totalBook() {
        int sum = 0;
        String sql = "select sum(quantity) as total from Books";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                sum = rs.getInt("total");
                logger.info("Total Books: {}", sum);
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return sum;
    }

    @Override
    public List<Book> searchBook(String query) {
        List<Book> list = new ArrayList<>();
        String sql = "select * from books\n "
                + "join categories on books.category_id = categories.category_id\n"
                + "where title_unaccented like ? or title like ?";
        logger.info("Searching {} book", query);
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setBookID(rs.getInt("book_id"));
                b.setSlug(rs.getString("slug"));
                b.setAuthor(rs.getString("author"));
                b.setTitle(rs.getString("title"));
                b.setQuantity(rs.getInt("quantity"));
                b.setDescription(rs.getString("description"));
                b.setCoverImage(rs.getString("cover_image"));

                Categorie category = new Categorie();
                category.setCategoryID(rs.getInt("category_id"));
                category.setName(rs.getString("name"));
                b.setCategory(category);
                list.add(b);
            }
            return list;
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return null;
    }

    @Override
    public void insertBookToFavorite(int bookID, int userID) {
        String sql = "insert into favorites(user_id, book_id) values (? , ? )";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ps.executeUpdate();
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
    }

    @Override
    public List<Book> showBookFromFavorite(int userID) {
        List<Book> list = new ArrayList<>();
        String sql = "select * from books join favorites on favorites.book_id = books.book_id"
                + " join users on users.user_id = favorites.user_id where users.user_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book b = new Book();
                b.setBookID(rs.getInt("book_id"));
                b.setSlug(rs.getString("slug"));
                b.setAuthor(rs.getString("author"));
                b.setTitle(rs.getString("title"));
                b.setQuantity(rs.getInt("quantity"));
                b.setDescription(rs.getString("description"));
                b.setCoverImage(rs.getString("cover_image"));
                list.add(b);
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);

        }
        return list;
    }

    @Override
    public void decreaseQuantity(Connection conn, int bookID) {
        String sql = "update books set books.quantity = books.quantity - 1 where books.book_id = ? ";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            ps.executeUpdate();
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
    }

    @Override
    public void increaseQuantity(Connection conn, String slug) {
        String sql = "update books set quantity = quantity + 1 where slug =  ? ";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slug);
            ps.executeUpdate();
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
    }

    @Override
    public boolean existsFavorite(int userID, int bookID) {
        String sql = "select * from favorites where user_id = ? and book_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return false;
    }

    @Override
    public int getCurrentQuantity(Connection conn, int bookID) {
        String sql = "select * from books where book_id = ? ";
        logger.info("Counting quantity of {} book", bookID);
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("quantity");
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
        return -1;
    }

    @Override
    public void deleteBook(Connection conn , int bookID) {
        String sql = "DELETE FROM books WHERE book_id = ? ";
        logger.info("remove bookID {}", bookID);
        try (    
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                logger.info("BookID {} removed", bookID);                
            }else{
                logger.info("can not remove book ID {}", bookID);
            }                   
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }     
    }

    @Override
    public String getBookTitleByID(int bookID) {
        String sql = "select * from books where book_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("title");
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return null;
    }

    @Override
    public int getIDBook(String slug) {
        String sql = "select * from books where slug = ? ";
        try (
               Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slug);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("book_id");
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return -1;

    }

}
