package com.sms.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

/**
 * Password Utility Class
 * Handles password hashing and verification using SHA-256
 */
public class PasswordUtil {
    
    private static final String HASH_ALGORITHM = "SHA-256";
    
    /**
     * Hash password using SHA-256
     * @param password Plain text password
     * @return Hashed password in hexadecimal format
     */
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance(HASH_ALGORITHM);
            byte[] hashedBytes = md.digest(password.getBytes());
            
            // Convert byte array to hexadecimal string
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
            
        } catch (NoSuchAlgorithmException e) {
            System.err.println("ERROR: Hashing algorithm not found");
            e.printStackTrace();
            return null;
        }
    }
    
    /**
     * Verify password against stored hash
     * @param plainPassword Plain text password from user
     * @param hashedPassword Stored hashed password
     * @return true if passwords match
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (plainPassword == null || hashedPassword == null) {
            return false;
        }
        
        String hashOfInput = hashPassword(plainPassword);
        return hashedPassword.equals(hashOfInput);
    }
    
    /**
     * Generate random salt for enhanced security
     * @return Random salt string
     */
    public static String generateSalt() {
        SecureRandom random = new SecureRandom();
        byte[] salt = new byte[16];
        random.nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }
    
    /**
     * Hash password with salt
     * @param password Plain text password
     * @param salt Salt value
     * @return Hashed password with salt
     */
    public static String hashPasswordWithSalt(String password, String salt) {
        return hashPassword(password + salt);
    }
}
