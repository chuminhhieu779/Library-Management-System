/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

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
public class UserSessionDaoImpl implements UserSessionDao {

    @Override
    public void insertData(String sessionID, int userID) {
        String sql = "insert into user_sessions(session_id, user_id) values(? , ? )";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sessionID);
            ps.setInt(2, userID);
            ps.executeUpdate();
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    @Override
    public String getSessionID(int userID) {
        String sql = "SELECT session_id FROM user_sessions WHERE user_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("session_id");
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return null;
    }

    @Override
    public boolean canInsert(int userID) {
        String sql = "select * from user_sessions where user_id = ?  ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return false;
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return true;
    }

    @Override
    public void updateData(String sessionID, int userID) {
        String sql = "update user_sessions set session_id = ? where user_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, sessionID);
            ps.setInt(2, userID);
            ps.executeUpdate();
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    @Override
    public void deleteUserFromSessions(Connection conn, int userId) {
        String sql = "DELETE FROM user_sessions WHERE user_id = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int tmp = ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    @Override
    public List<String> getSessionIDUser() {
        List<String> listSession = new ArrayList<>();
        String sql = "  SELECT user_sessions.session_id\n"
                + "        FROM users\n"
                + "        JOIN user_sessions ON user_sessions.user_id = users.user_id\n"
                + "        WHERE users.role = 'user' ";

        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery();) {
            while (rs.next()) {
                listSession.add(rs.getString("session_id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return listSession;
    }

}
