/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.library.dao;

import com.library.exception.BookDataAccessException;
import com.library.factory.DaoFactory;
import com.library.util.DBConnection;
import java.io.FileReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import org.h2.tools.RunScript;
import static org.junit.Assert.*;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 *
 * @author hieuchu
 */
public class BookDaoTest {

    BookDao bookDao = DaoFactory.getBookDao();
    private static Connection conn;
    private static final Logger logger = LoggerFactory.getLogger(BookDaoTest.class);

    @BeforeClass
    public static void createDatabase() throws Exception {

        Class.forName("org.h2.Driver");
        conn = DriverManager.getConnection(
                "jdbc:h2:mem:TestLibraryDatabase;MODE=MSSQLServer;DB_CLOSE_DELAY=-1"
        );
    }

    @Before // run for every test
    public void reloadDatabase() throws Exception {
        // reset database 
        try (Statement st = conn.createStatement()) {
            st.execute("DROP ALL OBJECTS");
        }
        // reload new data
        RunScript.execute(conn, new FileReader("test/com/library/Library_Management_v7.sql"));
    }

    @Test
    public void testToTalBook() {
        int totalExpected = 391;
        int sum = 0;
        String sql = "select sum(quantity) as total from Books";
        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                sum = rs.getInt("total");
                assertEquals(totalExpected, sum);
            }
        } catch (SQLException s) {
            throw new BookDataAccessException("can access book");
        }

    }

    @Test
    public void testToTalBookFailed() {
        int totalExpected = 203;
        int sum = 0;
        String sql = "select sum(quantity) as total from Books";
        try (
                PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                sum = rs.getInt("total");
                assertNotEquals(totalExpected, sum);
            }
        } catch (SQLException s) {
            throw new BookDataAccessException("can access book");
        }
    }
    
    @Test
    public void deleteBook(){
        int bookID = 5 ;
         String sql = "DELETE FROM books WHERE book_id = ? ";
          logger.info("remove bookID {}", bookID);
        try (
              PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookID);
            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                logger.info("BookID {} removed", bookID);
            } else {
                logger.info("can not remove book ID {}", bookID);
            }
        } catch (SQLException s) {
            logger.error("Error excecuting{}", s.getMessage(), s);
        }
    }
}
