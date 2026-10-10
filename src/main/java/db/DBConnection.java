package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static String URL;
    private static String USER;
    private static String PASSWORD;

    static {
        // Prefer environment variables (set by App Service). Fall back to local
        // defaults.
        String host = System.getenv("DATABASE_HOST");
        String port = System.getenv("DATABASE_PORT");
        String dbName = System.getenv("DATABASE_NAME");
        String envUser = System.getenv("DATABASE_USER");
        String envPass = System.getenv("DATABASE_PASSWORD");

        if (host != null && !host.isEmpty()) {
            if (port == null || port.isEmpty())
                port = "3306";
            if (dbName == null || dbName.isEmpty())
                dbName = "railwaydb";
            URL = String.format("jdbc:mysql://%s:%s/%s?useSSL=true&requireSSL=true", host, port, dbName);
            USER = envUser;
            PASSWORD = envPass;
        } else {
            // Cloud or local database configuration via Environment Variables
            String defaultHost = System.getenv().getOrDefault("DB_HOST", "mysql-6450161-souritabanerjee506-55f0.h.aivencloud.com");
            String defaultPort = System.getenv().getOrDefault("DB_PORT", "26931");
            String defaultDb   = System.getenv().getOrDefault("DB_NAME", "defaultdb");
            URL = String.format("jdbc:mysql://%s:%s/%s?useSSL=true&requireSSL=true", defaultHost, defaultPort, defaultDb);
            USER = System.getenv().getOrDefault("DB_USER", "avnadmin");
            PASSWORD = System.getenv().getOrDefault("DB_PASSWORD", "");
        }
    }

    public static Connection getConnection() throws SQLException {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new SQLException("MySQL JDBC Driver not found", e);
        }

        return conn;
    }
}
