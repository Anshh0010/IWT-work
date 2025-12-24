package com.sms.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Database Utility Class
 * Handles MySQL database connections using JDBC
 * Implements singleton pattern for connection management
 */
public class DatabaseUtil {
    
    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/student_management_system";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "ansh";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";
    
    // Singleton instance
    private static DatabaseUtil instance;
    
    // Private constructor to prevent instantiation
    private DatabaseUtil() {
        try {
            // Load MySQL JDBC Driver
            Class.forName(DB_DRIVER);
            System.out.println("MySQL JDBC Driver loaded successfully");
        } catch (ClassNotFoundException e) {
            System.err.println("ERROR: MySQL JDBC Driver not found");
            e.printStackTrace();
        }
    }
    
    /**
     * Get singleton instance of DatabaseUtil
     */
    public static synchronized DatabaseUtil getInstance() {
        if (instance == null) {
            instance = new DatabaseUtil();
        }
        return instance;
    }
    
    /**
     * Get database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public Connection getConnection() throws SQLException {
        try {
            Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            System.out.println("Database connection established");
            return conn;
        } catch (SQLException e) {
            System.err.println("ERROR: Failed to connect to database");
            System.err.println("URL: " + DB_URL);
            System.err.println("User: " + DB_USER);
            e.printStackTrace();
            throw e;
        }
    }
    
    /**
     * Close database resources safely
     * Prevents SQL injection by proper resource management
     */
    public static void closeResources(Connection conn, PreparedStatement pstmt, ResultSet rs) {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("ERROR closing ResultSet: " + e.getMessage());
        }
        
        try {
            if (pstmt != null) {
                pstmt.close();
            }
        } catch (SQLException e) {
            System.err.println("ERROR closing PreparedStatement: " + e.getMessage());
        }
        
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Database connection closed");
            }
        } catch (SQLException e) {
            System.err.println("ERROR closing Connection: " + e.getMessage());
        }
    }
    
    /**
     * Overloaded method for closing connection and statement only
     */
    public static void closeResources(Connection conn, PreparedStatement pstmt) {
        closeResources(conn, pstmt, null);
    }
    
    /**
     * Overloaded method for closing connection only
     */
    public static void closeResources(Connection conn) {
        closeResources(conn, null, null);
    }
    
    /**
     * Test database connection
     * @return true if connection is successful
     */
    public boolean testConnection() {
        Connection conn = null;
        try {
            conn = getConnection();
            return conn != null && !conn.isClosed();
        } catch (SQLException e) {
            System.err.println("Connection test failed: " + e.getMessage());
            return false;
        } finally {
            closeResources(conn);
        }
    }
}
