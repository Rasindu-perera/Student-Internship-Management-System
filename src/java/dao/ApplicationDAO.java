package dao;
import model.Application;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class ApplicationDAO {
    public boolean addApplication(Application application) throws Exception {
        String sql = "INSERT INTO applications (student_id, internship_id, status, applied_date) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, application.getStudentId());
            pstmt.setInt(2, application.getInternshipId());
            pstmt.setString(3, application.getStatus());
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error adding application: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public boolean updateApplicationStatus(int applicationId, String status) throws Exception {
        String sql = "UPDATE applications SET status = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, applicationId);
            
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error updating application status: " + e.getMessage());
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
    public List<Application> getApplicationsByStudent(int studentId) throws Exception {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.id as application_id, a.student_id, a.internship_id, a.status, a.applied_date, " +
                    "i.title as internship_title, u.name as student_name " +
                    "FROM applications a " +
                    "JOIN internships i ON a.internship_id = i.id " +
                    "JOIN users u ON a.student_id = u.user_id " +
                    "WHERE a.student_id = ? " +
                    "ORDER BY a.applied_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, studentId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("application_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setInternshipId(rs.getInt("internship_id"));
                app.setStatus(rs.getString("status"));
                app.setAppliedDate(rs.getTimestamp("applied_date"));
                app.setInternshipTitle(rs.getString("internship_title"));
                app.setStudentName(rs.getString("student_name"));
                applications.add(app);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error retrieving student applications: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return applications;
    }
    public List<Application> getApplicationsByCompany(int companyId) throws Exception {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.id as application_id, a.student_id, a.internship_id, a.status, a.applied_date, " +
                    "i.title as internship_title, u.name as student_name " +
                    "FROM applications a " +
                    "JOIN internships i ON a.internship_id = i.id " +
                    "JOIN users u ON a.student_id = u.user_id " +
                    "WHERE i.company_id = ? " +
                    "ORDER BY a.applied_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, companyId);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("application_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setInternshipId(rs.getInt("internship_id"));
                app.setStatus(rs.getString("status"));
                app.setAppliedDate(rs.getTimestamp("applied_date"));
                app.setInternshipTitle(rs.getString("internship_title"));
                app.setStudentName(rs.getString("student_name"));
                applications.add(app);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error retrieving company applications: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return applications;
    }
    public List<Application> getAllApplications() throws Exception {
        List<Application> applications = new ArrayList<>();
        String sql = "SELECT a.id as application_id, a.student_id, a.internship_id, a.status, a.applied_date, " +
                    "i.title as internship_title, u.name as student_name " +
                    "FROM applications a " +
                    "JOIN internships i ON a.internship_id = i.id " +
                    "JOIN users u ON a.student_id = u.user_id " +
                    "ORDER BY a.applied_date DESC";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("application_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setInternshipId(rs.getInt("internship_id"));
                app.setStatus(rs.getString("status"));
                app.setAppliedDate(rs.getTimestamp("applied_date"));
                app.setInternshipTitle(rs.getString("internship_title"));
                app.setStudentName(rs.getString("student_name"));
                applications.add(app);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error retrieving all applications: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return applications;
    }
    public Application getApplicationById(int applicationId) throws Exception {
        String sql = "SELECT a.id as application_id, a.student_id, a.internship_id, a.status, a.applied_date, " +
                    "i.title as internship_title, u.name as student_name " +
                    "FROM applications a " +
                    "JOIN internships i ON a.internship_id = i.id " +
                    "JOIN users u ON a.student_id = u.user_id " +
                    "WHERE a.id = ?";
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        try {
            conn = DBConnection.getConnection();
            if (conn == null) {
                throw new SQLException("Failed to establish database connection");
            }
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, applicationId);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("application_id"));
                app.setStudentId(rs.getInt("student_id"));
                app.setInternshipId(rs.getInt("internship_id"));
                app.setStatus(rs.getString("status"));
                app.setAppliedDate(rs.getTimestamp("applied_date"));
                app.setInternshipTitle(rs.getString("internship_title"));
                app.setStudentName(rs.getString("student_name"));
                return app;
            }
            
            return null;
            
        } catch (SQLException e) {
            e.printStackTrace();
            throw new Exception("Error retrieving application: " + e.getMessage());
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