/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.dto.ExtendRequestDTO;
import com.library.model.entity.ExtendRequest;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author hieuchu
 */
public class ExtendRequestDaoImpl implements ExtendRequestDao {

    @Override
    public boolean insertExtendRequest(ExtendRequestDTO dto) {
        String sql = "INSERT INTO extend_requests (borrowing_id, user_id, status) VALUES (?, ?, ?)";
        try (
              Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dto.getBorrowing().getBorrowingID());
            ps.setInt(2, dto.getUser().getUserID());
            ps.setString(3, dto.getStatus().PENDING.getValue());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
