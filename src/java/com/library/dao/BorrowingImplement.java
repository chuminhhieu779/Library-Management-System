/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Books;
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
        String sql = "select borrowings.user_id , count(borrowing_details.book_id) as totalBorrowedBooks from borrowings join borrowing_details\n"
                + "on borrowings.borrowing_id = borrowing_details.borrowing_id\n"
                + "join users on users.user_id = borrowings.user_id \n"
                + "where borrowings.status = 'borrowing' and users.account = ? \n"
                + "group by borrowings.user_id ";
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
        String sql = "select borrowings.user_id , count(borrowing_details.book_id) as totalReturnedBooks from borrowings join borrowing_details\n"
                + "on borrowings.borrowing_id = borrowing_details.borrowing_id\n"
                + "join users on users.user_id = borrowings.user_id \n"
                + "where borrowings.status = 'returned' and users.account = ? \n"
                + "group by borrowings.user_id ";
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
    public List<Books> borrowedBooksList(String account) {
        List<Books> list = new ArrayList<>();
        String sql = "select borrowings.user_id ,books.cover_image from borrowings join borrowing_details\n"
                + "on borrowings.borrowing_id = borrowing_details.borrowing_id\n"
                + "join users on users.user_id = borrowings.user_id \n"
                + "join books on books.book_id = borrowing_details.book_id\n"
                + "where borrowings.status = 'borrowing' and users.account = ? \n"
                + "group by borrowings.user_id , books.cover_image";
        try {
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Books b = new Books();
                b.setCoverImage(rs.getString("cover_image"));
                list.add(b);
            }
        } catch (SQLException s) {
            logger.error("Error executing: {}", s.getMessage(), s);
        }
        return list;
    }
}
