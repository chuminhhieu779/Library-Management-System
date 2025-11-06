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
        String sql = "select users.user_id  ,users.fullname , users.account, books.title ,borrowings.status from borrowings\n"
                + "join books on books.book_id = borrowings.book_id\n"
                + "join users on users.user_id = borrowings.user_id\n"
                + "group by users.user_id  ,users.fullname , users.account, borrowings.status , books.title";

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
                Optional<UserStatus> opt = UserStatus.convertToEnum(rs.getString("status"));
                opt.ifPresent(status -> dto.setStatus(status));
               list.add(dto);
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
       return list ;
    }

}
