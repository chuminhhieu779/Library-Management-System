/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Books;
import com.library.model.BorrowedBookDTO;
import com.library.model.Borrowings;
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
public class BorrowingImplement implements BorrowingDao {

    private static final Logger logger = LoggerFactory.getLogger(BorrowingImplement.class);
    private Connection conn = DBConnection.getInstance().getConnection();

    @Override
    public int totalBorrowedBooks(String account) {
        int sum = 0;
        String sql = "SELECT COUNT(b.book_id) AS totalBorrowedBooks "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "WHERE b.status = 'borrowing' AND u.account = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
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
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
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
        String sql = "SELECT bk.cover_image, b.borrow_date, b.due_date, bk.slug "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "JOIN books bk ON bk.book_id = b.book_id "
                + "WHERE b.status = 'borrowing' AND u.account = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BorrowedBookDTO dto = new BorrowedBookDTO();
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
    public List<Books> returnedBooksList(String account) {
        List<Books> list = new ArrayList<>();
        String sql = "SELECT bk.cover_image "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "JOIN books bk ON bk.book_id = b.book_id "
                + "WHERE b.status = 'returned' AND u.account = ?";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Books b = new Books();
                b.setCoverImage(rs.getString("cover_image"));
                list.add(b);
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return list;
    }

    @Override
    public boolean returnBook(String account, String slug) {
        String sql = "UPDATE b "
                + "SET b.status = 'returned', b.return_date = GETDATE() "
                + "FROM borrowings b "
                + "JOIN users u ON u.user_id = b.user_id "
                + "JOIN books bk ON bk.book_id = b.book_id "
                + "WHERE bk.slug = ? AND u.account = ? AND b.status = 'borrowing'";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, slug);
            ps.setString(2, account);
            int row = ps.executeUpdate();
            return row > 0;
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return false;
    }

}
