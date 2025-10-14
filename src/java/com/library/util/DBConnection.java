package com.library.util;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author hieuchu
 */
public class DBConnection {
    
    private static final Logger logger = LoggerFactory.getLogger(DBConnection.class);
    private static DBConnection instance;
    private Connection connection;
    private static final String url = "jdbc:sqlserver://localhost:1433;databaseName=Library_Management;encrypt=true;trustServerCertificate=true";
    private static final String user = "sa";
    private static final String password = "123";
    
    
    
    
    private DBConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, password);
        } catch (ClassNotFoundException c) {
            logger.error("JBDC Driver not found {}", c.getMessage(), c);
        } catch (SQLException s) {
            logger.error("Database connection failed: {} ", s.getMessage(), s);
        }
    }
    
    public static DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }
    
    public Connection getConnection() {
        return connection;
    }
}
