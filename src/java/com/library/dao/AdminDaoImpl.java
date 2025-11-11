/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.enums.UserStatus;
import com.library.model.dto.UserActivityDTO;
import com.library.model.dto.UserBorrowRecordDTO;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

/**
 *
 * @author hieuchu
 */
public class AdminDaoImpl implements AdminDao {

    @Override
    public List<UserBorrowRecordDTO> getAllUserInformation() {
        String sql = "SELECT b.book_id ,b.borrowing_id, u.user_id, u.fullname, u.account,\n"
                + "               bk.title, b.status\n"
                + "        FROM borrowings b\n"
                + "        JOIN books bk ON bk.book_id = b.book_id\n"
                + "        JOIN users u ON u.user_id = b.user_id\n"
                + "        ORDER BY b.borrowing_id DESC";

        List<UserBorrowRecordDTO> list = new ArrayList<>();

        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserBorrowRecordDTO dto = new UserBorrowRecordDTO();
                dto.setUserID(rs.getInt("user_id"));
                dto.setAccount(rs.getString("account"));
                dto.setFullName(rs.getString("fullname"));
                dto.setBorrowedBook(rs.getString("title"));
                dto.setBorrowingID(rs.getInt("borrowing_id"));
                dto.setBookID(rs.getInt("book_id"));
                Optional<UserStatus> opt = UserStatus.convertToEnum(rs.getString("status"));
                opt.ifPresent(status -> dto.setStatus(status));
                list.add(dto);
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return list;
    }

}
