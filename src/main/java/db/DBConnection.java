package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // ✅ This is the correct database name (no underscore)
    private static final String URL = "jdbc:mysql://localhost:3306/railwaydb";
    private static final String USER = "root";
    // ✅ This is your password
    private static final String PASSWORD = "1234"; 

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            // Throw a runtime exception so the server knows something is wrong
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    
        return conn;
    }
}



