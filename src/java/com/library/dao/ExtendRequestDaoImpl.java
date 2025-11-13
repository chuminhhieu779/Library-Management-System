/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.dto.ExtendRequestDTO;
import com.library.model.dto.ExtendRequestViewDTO;
import com.library.model.entity.ExtendRequest;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author hieuchu
 */
public class ExtendRequestDaoImpl implements ExtendRequestDao {

    @Override
    public boolean insertExtendRequest(ExtendRequestDTO dto) {
        String sql = "INSERT INTO extend_requests (borrowing_id, user_id, status) VALUES (?, ?, ?)";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dto.getBorrowing().getBorrowingID());
            ps.setInt(2, dto.getUser().getUserID());
            ps.setString(3, dto.getStatus().PENDING.getValue());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<ExtendRequestViewDTO> getAllExtendRequests() {
        List<ExtendRequestViewDTO> list = new ArrayList<>();
        String sql = " SELECT users.account, users.avatar, books.title, books.cover_image,\n"
                + "                   extend_requests.request_date, extend_requests.status\n"
                + "            FROM extend_requests\n"
                + "            JOIN users ON users.user_id = extend_requests.user_id\n"
                + "            JOIN borrowings ON borrowings.borrowing_id = extend_requests.borrowing_id\n"
                + "            JOIN books ON books.book_id = borrowings.book_id\n"
                + "            ORDER BY extend_requests.request_date DESC";

        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                ExtendRequestViewDTO dto = new ExtendRequestViewDTO();
                dto.setAccount(rs.getString("account"));
                dto.setAvatar(rs.getString("avatar"));
                dto.setTitle(rs.getString("title"));
                dto.setCoverImage(rs.getString("cover_image"));
                dto.setRequestDate(rs.getTimestamp("request_date").toLocalDateTime());
                dto.setStatus(rs.getString("status"));
                list.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean hasUserSentRequest(int borrowingID, int userID) {
        String sql = "select * from extend_requests\n"
                + "where borrowing_id  = ? and user_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, borrowingID);
            ps.setInt(2, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public void updateStatus(int userID, String status) {
        String sql = "update extend_requests set status = ? \n"
                + "where user_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setString(2, status);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public int countingRequest() {
        String sql = "select count(*) as totalRequest from extend_requests\n"
                + "where status = 'pending'";
           try (
            Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
             ResultSet rs = ps.executeQuery();
             if(rs.next()) return rs.getInt("totalRequest");
        } catch (SQLException e) {
            e.printStackTrace();
        }
         return -1 ;
    }

}
