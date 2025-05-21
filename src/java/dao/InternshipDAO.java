package dao;
import model.Internship;
import util.DBConnection;
import java.sql.*;
import java.util.*;

public class InternshipDAO {
    public void addInternship(Internship i) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement(
                "INSERT INTO internships(title, description, company_id, deadline) VALUES (?, ?, ?, ?)");
            ps.setString(1, i.getTitle());
            ps.setString(2, i.getDescription());
            ps.setInt(3, i.getCompanyId());
            ps.setString(4, i.getDeadline());
            ps.executeUpdate();
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public List<Internship> getAllInternships() throws Exception {
        Connection con = null;
        Statement st = null;
        ResultSet rs = null;
        List<Internship> list = new ArrayList<>();
        
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            st = con.createStatement();
            rs = st.executeQuery("SELECT * FROM internships ORDER BY id DESC");
            
            while(rs.next()) {
                Internship i = new Internship();
                i.setId(rs.getInt("id"));
                i.setTitle(rs.getString("title"));
                i.setDescription(rs.getString("description"));
                i.setCompanyId(rs.getInt("company_id"));
                i.setDeadline(rs.getString("deadline"));
                list.add(i);
            }
            return list;
        } finally {
            if(rs != null) rs.close();
            if(st != null) st.close();
            if(con != null) con.close();
        }
    }

    public List<Internship> getInternshipsByCompany(int companyId) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        List<Internship> list = new ArrayList<>();
        
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement("SELECT * FROM internships WHERE company_id = ? ORDER BY id DESC");
            ps.setInt(1, companyId);
            rs = ps.executeQuery();
            
            while(rs.next()) {
                Internship i = new Internship();
                i.setId(rs.getInt("id"));
                i.setTitle(rs.getString("title"));
                i.setDescription(rs.getString("description"));
                i.setCompanyId(rs.getInt("company_id"));
                i.setDeadline(rs.getString("deadline"));
                list.add(i);
            }
            return list;
        } finally {
            if(rs != null) rs.close();
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public Internship getInternshipById(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement("SELECT * FROM internships WHERE id = ?");
            ps.setInt(1, id);
            rs = ps.executeQuery();
            
            if(rs.next()) {
                Internship i = new Internship();
                i.setId(rs.getInt("id"));
                i.setTitle(rs.getString("title"));
                i.setDescription(rs.getString("description"));
                i.setCompanyId(rs.getInt("company_id"));
                i.setDeadline(rs.getString("deadline"));
                return i;
            }
            return null;
        } finally {
            if(rs != null) rs.close();
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public void updateInternship(Internship i) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement(
                "UPDATE internships SET title = ?, description = ?, deadline = ? WHERE id = ? AND company_id = ?");
            ps.setString(1, i.getTitle());
            ps.setString(2, i.getDescription());
            ps.setString(3, i.getDeadline());
            ps.setInt(4, i.getId());
            ps.setInt(5, i.getCompanyId());
            ps.executeUpdate();
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }

    public void deleteInternship(int id) throws Exception {
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = DBConnection.getConnection();
            if (con == null) {
                throw new Exception("Database connection failed");
            }
            
            ps = con.prepareStatement("DELETE FROM internships WHERE id = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
        } finally {
            if(ps != null) ps.close();
            if(con != null) con.close();
        }
    }
}