package com.sms.dao;

import com.sms.model.User;
import com.sms.util.DatabaseUtil;
import com.sms.util.PasswordUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * UserDAO - Data Access Object for User operations
 * Handles authentication and user management with SQL injection prevention
 */
public class UserDAO {
    
    private DatabaseUtil dbUtil;
    
    public UserDAO() {
        this.dbUtil = DatabaseUtil.getInstance();
    }
    
    /**
     * Create new user (Registration)
     * @param user User object with email, password, role
     * @return generated user ID or -1 if failed
     */
    public int createUser(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "INSERT INTO users (email, password_hash, role) VALUES (?, ?, ?)";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            
            // Use PreparedStatement to prevent SQL injection
            pstmt.setString(1, user.getEmail());
            pstmt.setString(2, user.getPasswordHash());
            pstmt.setString(3, user.getRole());
            
            int affectedRows = pstmt.executeUpdate();
            
            if (affectedRows > 0) {
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR creating user: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return -1;
    }
    
    /**
     * Authenticate user - Login
     * @param email User email
     * @param password Plain text password
     * @return User object if authenticated, null otherwise
     */
    public User authenticateUser(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT user_id, email, password_hash, role, created_at FROM users WHERE email = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            
            // Use PreparedStatement to prevent SQL injection
            pstmt.setString(1, email);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                String storedHash = rs.getString("password_hash");
                
                // Verify password using PasswordUtil
                if (PasswordUtil.verifyPassword(password, storedHash)) {
                    User user = new User();
                    user.setUserId(rs.getInt("user_id"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(storedHash);
                    user.setRole(rs.getString("role"));
                    user.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    System.out.println("User authenticated: " + email);
                    return user;
                } else {
                    System.out.println("Invalid password for user: " + email);
                }
            } else {
                System.out.println("User not found: " + email);
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR authenticating user: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Get user by email
     * @param email User email
     * @return User object or null
     */
    public User getUserByEmail(String email) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT user_id, email, password_hash, role, created_at FROM users WHERE email = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting user by email: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Get user by ID
     * @param userId User ID
     * @return User object or null
     */
    public User getUserById(int userId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT user_id, email, password_hash, role, created_at FROM users WHERE user_id = ?";
        
        try {
            conn = dbUtil.getConnection();
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userId);
            
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPasswordHash(rs.getString("password_hash"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                return user;
            }
            
        } catch (SQLException e) {
            System.err.println("ERROR getting user by ID: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DatabaseUtil.closeResources(conn, pstmt, rs);
        }
        
        return null;
    }
    
    /**
     * Check if email exists
     * @param email Email to check
     * @return true if exists
     */
    public boolean emailExists(String email) {
        return getUserByEmail(email) != null;
    }
}
