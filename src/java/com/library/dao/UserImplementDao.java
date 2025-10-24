/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.model.Users;
import com.library.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.catalina.User;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class UserImplementDao implements UserDao {

    private static final Logger logger = LoggerFactory.getLogger(UserImplementDao.class);

    @Override
    public List<Users> getALLUser() {
        List<Users> list = new ArrayList<>();
        String sql = "select * from users ";
        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Users u = new Users();
                u.setUserID(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setAccount(rs.getString("account"));
                u.setPassword(rs.getString("password"));
                u.setRole(rs.getString("role"));
                u.setAvatar(rs.getString("avatar"));
                list.add(u);
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean checkLogin(String username, String pass) {
        String sql = "select * from users where account = ? and password = ? and role = ?";
        String role = "user";
        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, role);
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
    public boolean checkUserExistence(String username) {
        String sql = "select * from users where account = ?";

        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, username);
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
    public void addNewUser(String username, String account, String password) {
        String sql = "insert into users(fullname, account, password, role, avatar) values (?, ?, ?, ?, ?)";
        String role = "user";
        String avatar = "ava.jpg";

        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, username);
            ps.setString(2, account);
            ps.setString(3, password);
            ps.setString(4, role);
            ps.setString(5, avatar);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();;
        }
    }

    @Override
    public boolean checkAdminLogin(String username, String pass) {
        String sql = "select * from users where account = ? and password = ? and role = ?";
        String role = "admin";
        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, role);
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
    public int findUserID(String account) {
        String sql = "select * from users where users.account = ? ";
        try (
            Connection conn = DBConnection.getInstance().getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)){
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("user_id");
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);

        }
        return -1;
    }

}
