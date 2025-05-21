package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/sims?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    public static Connection getConnection() throws Exception {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASSWORD);
            if (conn == null) {
                throw new Exception("Failed to establish database connection");
            }
            return conn;
        } catch (ClassNotFoundException e) {
            throw new Exception("MySQL JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            throw new Exception("Database connection error: " + e.getMessage());
        }
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}