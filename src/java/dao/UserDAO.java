package dao;
import model.User;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class UserDAO {
    public User getUserByEmailAndPassword(String email, String password) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement("SELECT * FROM users WHERE email=? AND password=?");
            ps.setString(1, email);
            ps.setString(2, password);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setName(rs.getString("name"));
                u.setEmail(rs.getString("email"));
                u.setRole(rs.getString("role"));
                return u;
            }
            return null;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Database error: " + e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public boolean registerUser(User user) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement(
                "INSERT INTO users(name, email, password, role) VALUES (?, ?, ?, ?)");
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Database error: " + e.getMessage());
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public List<User> getAllUsers() throws Exception {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        List<User> list = new ArrayList<>();
        
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM users ORDER BY user_id");
            
            while(rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                list.add(user);
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Database error: " + e.getMessage());
        } finally {
            if(rs != null) rs.close();
            if(st != null) st.close();
            if(con != null) con.close();
        }
    }

    public boolean deleteUser(int userId) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement("DELETE FROM users WHERE user_id = ?");
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public boolean updateUser(User user) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            ps = con.prepareStatement(
                "UPDATE users SET name = ?, email = ?, role = ? WHERE user_id = ?");
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRole());
            ps.setInt(4, user.getUserId());
            return ps.executeUpdate() > 0;
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public User getUserByEmail(String email) throws Exception {
        String sql = "SELECT * FROM users WHERE email = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                return user;
            }
            
            return null;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error retrieving user: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}