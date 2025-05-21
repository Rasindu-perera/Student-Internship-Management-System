/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Internship;
import model.User;
import dao.InternshipDAO;

/**
 *
 * @author RasinduPerera
 */
@WebServlet("/InternshipServlet")
public class InternshipServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private InternshipDAO internshipDAO;

    @Override
    public void init() throws ServletException {
        internshipDAO = new InternshipDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        
        try {
            if ("Add".equals(action)) {
                handleAddInternship(request, response, user);
            } else if ("Update".equals(action)) {
                handleUpdateInternship(request, response, user);
            } else if ("Delete".equals(action)) {
                handleDeleteInternship(request, response, user);
            } else {
                response.sendRedirect("error.jsp?message=Invalid action");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void handleAddInternship(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        if (!"Company".equals(user.getRole())) {
            response.sendRedirect("error.jsp?message=Only companies can post internships");
            return;
        }

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadline = request.getParameter("deadline");

        if (title == null || title.trim().isEmpty() || 
            description == null || description.trim().isEmpty() || 
            deadline == null || deadline.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=All fields are required");
            return;
        }

        try {
            Internship internship = new Internship();
            internship.setTitle(title);
            internship.setDescription(description);
            internship.setCompanyId(user.getUserId());
            internship.setDeadline(deadline);

            internshipDAO.addInternship(internship);
            response.sendRedirect("dashboardCompany.jsp");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void handleUpdateInternship(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        if (!"Company".equals(user.getRole())) {
            response.sendRedirect("error.jsp?message=Only companies can update internships");
            return;
        }

        String internshipId = request.getParameter("internship_id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadline = request.getParameter("deadline");

        if (internshipId == null || internshipId.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=Internship ID is required");
            return;
        }

        try {
            Internship internship = new Internship();
            internship.setId(Integer.parseInt(internshipId));
            internship.setTitle(title);
            internship.setDescription(description);
            internship.setCompanyId(user.getUserId());
            internship.setDeadline(deadline);

            internshipDAO.updateInternship(internship);
            response.sendRedirect("dashboardCompany.jsp");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    private void handleDeleteInternship(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        if (!"Company".equals(user.getRole())) {
            response.sendRedirect("error.jsp?message=Only companies can delete internships");
            return;
        }

        String internshipId = request.getParameter("internship_id");
        if (internshipId == null || internshipId.trim().isEmpty()) {
            response.sendRedirect("error.jsp?message=Internship ID is required");
            return;
        }

        try {
            internshipDAO.deleteInternship(Integer.parseInt(internshipId));
            response.sendRedirect("dashboardCompany.jsp");
        } catch (Exception e) {
            response.sendRedirect("error.jsp?message=" + e.getMessage());
        }
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet InternshipServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet InternshipServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
