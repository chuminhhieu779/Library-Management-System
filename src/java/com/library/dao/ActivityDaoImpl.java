/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.entity.Action;
import com.library.model.entity.Activity;
import com.library.model.dto.UserActivityDTO;
import com.library.model.entity.Users;
import com.library.util.DBConnection;
import jakarta.servlet.jsp.jstl.sql.Result;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import org.apache.catalina.User;

/**
 *
 * @author hieuchu
 */
public class ActivityDaoImpl implements ActivityDao {



    @Override
    public void insertData(int userID, int actionID, String detail, LocalDateTime log_time) {
        String sql = "insert into activity_log(user_id , action_id , detail , log_time) values(? , ? , ? , ? ) ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userID);
            ps.setInt(2, actionID);
            ps.setString(3, detail);
            ps.setTimestamp(4, Timestamp.valueOf(log_time));
            ps.executeUpdate();
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    @Override
    public Activity getLatestByAction(int actionID) {
        String sql = "SELECT TOP 1 a.activity_id, a.detail, a.log_time,\n"
                + "                     u.user_id, u.account, u.fullname,\n"
                + "                     ac.action_id, ac.action_name\n"
                + "        FROM activity_log a\n"
                + "        JOIN users u ON a.user_id = u.user_id\n"
                + "        JOIN actions ac ON a.action_id = ac.action_id\n"
                + "        WHERE a.action_id = ?\n"
                + "        ORDER BY a.log_time DESC";
        try (Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, actionID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                 // Activity
                Activity act = new Activity();
                act.setActivityID(rs.getInt("activity_id"));
                act.setDetail(rs.getString("detail"));
                act.setLogTime(rs.getTimestamp("log_time").toLocalDateTime());
                
                // User
                Users user = new Users();
                user.setUserID(rs.getInt("user_id"));
                user.setAccount(rs.getString("account"));
                user.setFullname(rs.getString("fullname"));
                act.setUser(user);
                
                //Action
                Action action = new Action();
                action.setActionID(rs.getInt("action_id"));
                action.setName(rs.getString("action_name"));
                act.setAction(action);

                return act;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
