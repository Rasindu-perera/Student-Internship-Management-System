package controller;
import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.*;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        
        // Input validation
        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Please enter both email and password");
            req.getRequestDispatcher("login.jsp").forward(req, res);
            return;
        }
        
        try {
            UserDAO userDAO = new UserDAO();
            User user = userDAO.getUserByEmailAndPassword(email, password);
            
            if (user != null) {
                // Create new session and invalidate old one if exists
                HttpSession oldSession = req.getSession(false);
                if (oldSession != null) {
                    oldSession.invalidate();
                }
                
                HttpSession newSession = req.getSession(true);
                newSession.setAttribute("user", user);
                newSession.setMaxInactiveInterval(30 * 60); // 30 minutes
                
                // Redirect based on role
                switch (user.getRole()) {
                    case "Admin":
                        res.sendRedirect("dashboardAdmin.jsp");
                        break;
                    case "Student":
                        res.sendRedirect("dashboardStudent.jsp");
                        break;
                    case "Company":
                        res.sendRedirect("dashboardCompany.jsp");
                        break;
                    default:
                        req.setAttribute("error", "Invalid user role");
                        req.getRequestDispatcher("login.jsp").forward(req, res);
                        break;
                }
            } else {
                req.setAttribute("error", "Invalid email or password");
                req.getRequestDispatcher("login.jsp").forward(req, res);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An error occurred during login. Please try again.");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        // Redirect GET requests to login page
        res.sendRedirect("login.jsp");
    }
}