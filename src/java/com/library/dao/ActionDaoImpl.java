/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.enums.ActionType;
import com.library.model.entity.Action;
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
public class ActionDaoImpl implements ActionDao {

    @Override
    public String getNameByID(int actionID) {
        String sql = "select * from actions where action_id = ? ";
        try (
                Connection conn = DBConnection.getInstance().getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, actionID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("action_name");
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Action> getAllAction() {
        String sql = "select * from actions ";
        List<Action> list = new ArrayList<>();
        try (
            Connection conn = DBConnection.getInstance().getConnection(); 
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Action a = new Action();
                a.setActionID(rs.getInt("action_id"));
                a.setType(ActionType.convert(rs.getString("action_name")));
                list.add(a);
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return list; 
    }

}
