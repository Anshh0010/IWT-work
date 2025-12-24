-- ================================================
-- Initial Setup Script - Create Admin User
-- ================================================
-- This script creates the initial admin account
-- Run AFTER database_schema.sql

USE student_management_system;

-- Insert admin user
-- Email: admin@sms.com
-- Password: admin123 (hashed with BCrypt)
INSERT INTO users (email, password_hash, role) 
VALUES ('admin@sms.com', '$2a$10$YourHashedPasswordHere', 'ADMIN');

-- Note: You need to hash the password first using BCrypt
-- The above is a placeholder. 
-- 
-- To create an admin:
-- 1. Register as a student first through the web UI
-- 2. Approve that student via database
-- 3. OR manually insert with proper BCrypt hash

-- ================================================
-- How to create BCrypt hash for "admin123":
-- ================================================
-- Option 1: Use online BCrypt generator (bcrypt-generator.com)
-- Option 2: Run this in the application and copy the hash
-- Option 3: Use MySQL/Java to generate it

-- Example: If you generated hash for "admin123", it might look like:
-- $2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy

-- For now, users should:
-- 1. Use the registration page to create student accounts
-- 2. Admin needs to approve students via database or create admin manually
