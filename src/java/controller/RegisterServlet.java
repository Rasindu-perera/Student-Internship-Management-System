package controller;
import dao.UserDAO;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String role = "Student";

        // Input validation
        if (name == null || name.trim().isEmpty()) {
            req.setAttribute("error", "Name is required");
            req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
            return;
        }

        if (email == null || email.trim().isEmpty() || !email.contains("@")) {
            req.setAttribute("error", "Valid email address is required");
            req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
            return;
        }

        if (password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Password is required");
            req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
            return;
        }

        if (!password.equals(confirmPassword)) {
            req.setAttribute("error", "Passwords do not match");
            req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
            return;
        }

        try {
            UserDAO userDAO = new UserDAO();
            
            // Check if email already exists
            if (userDAO.getUserByEmail(email) != null) {
                req.setAttribute("error", "Email address is already registered");
                req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
                return;
            }

            User user = new User();
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setRole(role);

            if (userDAO.registerUser(user)) {
                req.setAttribute("success", "Registration successful! Please login.");
                req.getRequestDispatcher("login.jsp").forward(req, res);
            } else {
                req.setAttribute("error", "Registration failed. Please try again.");
                req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
            }
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Registration error: " + e.getMessage());
            req.getRequestDispatcher("registerStudent.jsp").forward(req, res);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        // Redirect GET requests to registration page
        res.sendRedirect("registerStudent.jsp");
    }
}