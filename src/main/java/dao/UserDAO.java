package dao;

import model.User;
import db.DBConnection;
import org.mindrot.jbcrypt.BCrypt; // Make sure you have the jbcrypt dependency in pom.xml

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    /**
     * Registers a new user. This method is called by SignupServlet.
     * It hashes the password from the User object.
     * This fixes: "cannot find symbol... method getPassword()"
     */
    public boolean registerUser(User user) throws SQLException {
        boolean result = false;
        // Hash the user's password (from user.getPassword()) before storing
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

        String query = "INSERT INTO users (name, email, phone, location, location_type, password_hash, age) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhone());
            ps.setString(4, user.getLocation());
            ps.setString(5, user.getLocationType());
            ps.setString(6, hashedPassword); // Store the HASH
            ps.setInt(7, user.getAge());

            int rowsAffected = ps.executeUpdate();
            result = (rowsAffected > 0);
        } catch (SQLException e) {
            e.printStackTrace();
            throw e; // Let the servlet handle the error
        }
        return result;
    }

    /**
     * Attempts to log in a user. This is called by LoginServlet.
     * This replaces the old "loginUser" method.
     */
    public User loginUser(String email, String password) throws SQLException {
        User user = this.findUserByEmail(email); // Find the user first

        // Check if user was found AND check the password
        if (user != null && this.checkPassword(password, user.getPasswordHash())) {
            // Password is correct! Return the user object.
            return user;
        }
        
        // If user is not found, or password doesn't match, return null
        return null;
    }

    /**
     * Finds a user by their email. This method IS NOW ADDED.
     * This fixes: "cannot find symbol... method findUserByEmail"
     */
    public User findUserByEmail(String email) throws SQLException {
        User user = null;
        String query = "SELECT * FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setLocation(rs.getString("location"));
                user.setLocationType(rs.getString("location_type"));
                user.setAge(rs.getInt("age"));
                user.setPasswordHash(rs.getString("password_hash"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        }
        return user;
    }
    // Add this method to your UserDAO.java
public User getUserById(int userId) {
    User user = null;
    String sql = "SELECT * FROM users WHERE id = ?";
    
    try (Connection conn = DBConnection.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        
        ps.setInt(1, userId);
        
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setLocation(rs.getString("location"));
                user.setLocationType(rs.getString("location_type"));
                user.setAge(rs.getInt("age"));
                user.setPasswordHash(rs.getString("password_hash"));
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return user;
}
    /**
     * Checks a plain-text password against a stored BCrypt hash.
     * This method IS NOW ADDED.
     * This fixes: "cannot find symbol... method checkPassword"
     */
    public boolean checkPassword(String plainPassword, String hashedPassword) {
        if (hashedPassword == null) {
            return false;
        }
        try {
            return BCrypt.checkpw(plainPassword, hashedPassword);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}