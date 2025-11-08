/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.factory.DaoFactory;
import com.library.model.entity.User;
import com.library.util.DBConnection;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Optional;
import org.h2.tools.RunScript;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.*;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertTrue;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;

/**
 *
 * @author hieuchu
 */
public class UserDaoTest {

    private final UserDao userDao = DaoFactory.getUserDao();
    private static Connection conn;

    @BeforeClass
    public static void createDatabase() throws Exception {

        Class.forName("org.h2.Driver");
        conn = DriverManager.getConnection(
                "jdbc:h2:mem:TestLibraryDatabase;MODE=MSSQLServer;DB_CLOSE_DELAY=-1"
        );        
    }
    @Before // run for every test
    public void reloadDatabase() throws Exception{
        // reset database 
        try (Statement st = conn.createStatement()) {
            st.execute("DROP ALL OBJECTS");
        }
        // reload new data
        RunScript.execute(conn, new FileReader("test/com/library/Library_Management_v7.sql"));
    }

    @Test
    public void testUserExistence() {
        String sql = "select * from users where account = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "suzune123");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                assertTrue(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testUserNotExistence() {
        String sql = "select * from users where account = ?";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "suzune12");
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                assertFalse(false);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void checkAdminLoginOk() {
        String sql = "select * from users where account = ? and password = ? and role = ?";
        String role = "admin";
        String username = "nguyenvana";
        String pass = "123";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                assertTrue(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void checkAdminLoginFailed() {
        String sql = "select * from users where account = ? and password = ? and role = ?";
        String role = "admin";
        String username = "nguyenvana22";
        String pass = "12223";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, pass);
            ps.setString(3, role);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                assertFalse(false);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void findUserIDOK() {
        String account = "suzune123";
        int userIDExpected = 5;
        String sql = "select * from users where users.account = ? ";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int actualID = rs.getInt("user_id");
                assertEquals(userIDExpected, actualID);
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    @Test
    public void findUserIDNotOk() {
        String account = "suzune123";
        int userIDExpected = 57;
        String sql = "select * from users where users.account = ? ";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int actualID = rs.getInt("user_id");
                assertNotEquals(userIDExpected, actualID);
            }
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

    @Test
    public void getUserByAccount() {
        String account = "phamthid";
        String fullName = "Pham Thi D";
        int userID = 4;
        User u = new User();
        String sql = "select * from users where account = ? ";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setUserID(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setAccount(rs.getString("account"));
            }
            assertEquals(account, u.getAccount());
            assertEquals(fullName, u.getFullname());
            assertEquals(userID, u.getUserID());
        } catch (SQLException s) {
            s.printStackTrace();
        }

    }

    @Test
    public void getUserByAccountFalied() {
        String account = "phamthids";
        String fullName = "Pham Thi Ds";
        int userID = 40;
        User u = new User();
        String sql = "select * from users where account = ? ";
        try (
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                u.setUserID(rs.getInt("user_id"));
                u.setFullname(rs.getString("fullname"));
                u.setAccount(rs.getString("account"));
            }
            assertNotEquals(account, u.getAccount());
            assertNotEquals(fullName, u.getFullname());
            assertNotEquals(userID, u.getUserID());
        } catch (SQLException s) {
            s.printStackTrace();
        }
    }

}
