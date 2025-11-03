/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.entity.Book;
import com.library.model.dto.BorrowedBookDTO;
import com.library.model.entity.Borrowing;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BorrowingDaoImpl implements BorrowingDao {

    private static final Logger logger = LoggerFactory.getLogger(BorrowingDaoImpl.class);

    @Override
    public int totalBorrowedBooks(String account) {
        int sum = 0;
        String sql = "SELECT COUNT(b.book_id) AS totalBorrowedBooks "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "WHERE b.status = 'borrowing' AND u.account = ?";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                sum = rs.getInt("totalBorrowedBooks");
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return sum;
    }

    @Override
    public int totalReturnedBooks(String account) {
        int sum = 0;
        String sql = "SELECT COUNT(b.book_id) AS totalReturnedBooks "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "WHERE b.status = 'returned' AND u.account = ?";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                sum = rs.getInt("totalReturnedBooks");
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return sum;
    }

    @Override
    public List<BorrowedBookDTO> borrowedBooksList(String account) {
        List<BorrowedBookDTO> list = new ArrayList<>();
        String sql = "SELECT bk.cover_image, b.borrow_date, b.due_date, bk.slug , bk.book_id "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "JOIN books bk ON bk.book_id = b.book_id "
                + "WHERE b.status = 'borrowing' AND u.account = ?";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BorrowedBookDTO dto = new BorrowedBookDTO();
                dto.setBookID(rs.getInt("book_id"));
                dto.setSlug(rs.getString("slug"));
                dto.setBorrowDate(rs.getDate("borrow_date").toLocalDate());
                dto.setDueDate(rs.getDate("due_date").toLocalDate());
                dto.setCoverImage(rs.getString("cover_image"));
                list.add(dto);
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return list;
    }

    @Override
    public Map<Integer, String> returnedBooksList(String account) {
        Map<Integer, String> map = new HashMap<>();
        String sql = "SELECT bk.cover_image , b.book_id "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "JOIN books bk ON bk.book_id = b.book_id "
                + "WHERE b.status = 'returned' AND u.account = ?";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                map.put(rs.getInt("book_id"), rs.getString("cover_image"));
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return map;
    }

    @Override
    public boolean updateBookStatus(Connection conn, String account, String slug) {
        String sql = "UPDATE b "
                + "SET b.status = 'returned', b.return_date = GETDATE() "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "JOIN books bk ON bk.book_id = b.book_id "
                + "WHERE bk.slug = ? AND u.account = ? AND b.status = 'borrowing'";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, slug);
            ps.setString(2, account);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return false;
    }

    @Override
    public boolean extendDueDay(int bookID, LocalDate dueDate, String account) {
        String sql = " UPDATE borrowings\n"
                + "SET borrowings.due_date = ? \n"
                + "FROM borrowings\n"
                + "JOIN users ON borrowings.user_id = users.user_id\n"
                + "WHERE borrowings.book_id = ? \n"
                + "  AND users.account = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setDate(1, java.sql.Date.valueOf(dueDate)); // convet LocalDate to Date in JDBC 
            ps.setInt(2, bookID);
            ps.setString(3, account);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return false;
    }

    @Override
    public LocalDate getBorrowDate(int bookID) {
        String sql = "select * from borrowings where borrowings.book_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LocalDate currentBorrowDate = rs.getDate("borrow_date").toLocalDate();
                return currentBorrowDate;
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return null;
    }

    @Override
    public boolean isBookAvailable(String slug, int bookID) {
        String sql = "select * from books where books.book_id = ? and slug = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            ps.setString(2, slug);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getInt("quantity") > 0) {
                    return true;
                }
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return false;
    }

    @Override
    public void insertBook(Connection conn, int bookID, int userID) {
        String sql = "INSERT INTO borrowings (user_id, book_id, borrow_date, due_date, return_date, late_days, fine_amount, fine_paid, status) "
                + "VALUES (?, ?, GETDATE(), DATEADD(MONTH, 2, GETDATE()), NULL, 0, 0.00, 'Unpaid', 'borrowing')";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, bookID);
            ps.executeUpdate();
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);

        }
    }

    @Override
    public boolean hasUserBorrowedBook(int bookID, int userID) {
        String sql = "select * from borrowings where book_id = ? and user_id = ? and status = ?  ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, bookID);
            ps.setInt(2, userID);
            ps.setString(3, "borrowing");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (Exception e) {
        }
        return true;
    }

    @Override
    public boolean canDeleteBook(int bookID) {
        String sql = "select * from borrowings where book_id = ? and status = ?  ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql);) {
            ps.setInt(1, bookID);
            ps.setString(2, "borrowing");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (Exception e) {
        }
        return true;
    }

    @Override
    public void deleteBorrowingsByBookId(Connection conn, int bookId) {
        String sql = "DELETE FROM borrowings WHERE book_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void deleteUserFromBorrowings(Connection conn, int userId) {
        String sql = "DELETE FROM borrowings WHERE user_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int tmp = ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}
