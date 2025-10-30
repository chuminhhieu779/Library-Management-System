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

    // Read configuration from environment variables with sensible defaults
    // DB_HOST (default: localhost)
    // DB_PORT (default: 1433)
    // DB_INSTANCE (optional; if set, instanceName is used instead of port)
    // DB_NAME (default: LibraryManagement)
    // DB_USER (default: sa)
    // DB_PASSWORD (default: 123)
    // DB_ENCRYPT (default: true)
    // DB_TRUST_SERVER_CERTIFICATE (default: true)
    private static final String HOST = getEnvOrDefault("DB_HOST", "localhost");
    private static final String PORT = getEnvOrDefault("DB_PORT", "1433");
    private static final String INSTANCE = getEnvOrDefault("DB_INSTANCE", "");
    private static final String DB_NAME = getEnvOrDefault("DB_NAME", "LibraryManagement");
    private static final String USER = getEnvOrDefault("DB_USER", "sa");
    private static final String PASSWORD = getEnvOrDefault("DB_PASSWORD", "123");
    private static final boolean ENCRYPT = Boolean.parseBoolean(getEnvOrDefault("DB_ENCRYPT", "true"));
    private static final boolean TRUST_CERT = Boolean.parseBoolean(getEnvOrDefault("DB_TRUST_SERVER_CERTIFICATE", "true"));

    private static final String URL = buildSqlServerUrl(HOST, PORT, INSTANCE, DB_NAME, ENCRYPT, TRUST_CERT);

    private DBConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException e) {
            logger.error("SQL Server JDBC Driver not found: {}", e.getMessage(), e);
        }
    }

    public static synchronized DBConnection getInstance() {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public Connection getConnection() {
        try {
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            return conn;
        } catch (SQLException e) {
            logger.error("Error getting connection: {}", e.getMessage(), e);
            throw new RuntimeException(e);
        }
    }

    private static String getEnvOrDefault(String key, String defaultValue) {
        String v = System.getenv(key);
        if (v == null || v.isEmpty()) {
            v = System.getProperty(key, defaultValue);
        }
        return v;
    }

    private static String buildSqlServerUrl(String host, String port, String instance, String dbName, boolean encrypt, boolean trustServerCertificate) {
        StringBuilder sb = new StringBuilder("jdbc:sqlserver://");
        sb.append(host != null && !host.isEmpty() ? host : "localhost");
        if (instance != null && !instance.isEmpty()) {
            sb.append("\\").append(instance);
        } else {
            sb.append(":").append(port != null && !port.isEmpty() ? port : "1433");
        }
        sb.append(";databaseName=").append(dbName != null && !dbName.isEmpty() ? dbName : "LibraryManagement");
        sb.append(";encrypt=").append(encrypt);
        sb.append(";trustServerCertificate=").append(trustServerCertificate);
        return sb.toString();
    }
}
