package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Application;
import model.User;
import dao.ApplicationDAO;
import java.util.List;

@WebServlet("/ApplicationServlet")
public class ApplicationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ApplicationDAO applicationDAO;

    @Override
    public void init() throws ServletException {
        applicationDAO = new ApplicationDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            request.setAttribute("error", "Invalid action");
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
            return;
        }

        try {
            switch (action) {
                case "view":
                    handleViewApplications(request, response, user);
                    break;
                case "viewDetails":
                    handleViewApplicationDetails(request, response, user);
                    break;
                default:
                    request.setAttribute("error", "Invalid action");
                    request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
        }
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
        if (action == null || action.trim().isEmpty()) {
            request.setAttribute("error", "Invalid action");
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
            return;
        }
        
        try {
            switch (action) {
                case "Apply":
                    handleApplication(request, response, user);
                    break;
                case "Approve":
                case "Reject":
                    handleStatusUpdate(request, response, user);
                    break;
                default:
                    request.setAttribute("error", "Invalid action");
                    request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
        }
    }

    private void handleViewApplications(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        try {
            List<Application> applications;
            switch (user.getRole()) {
                case "Admin":
                    applications = applicationDAO.getAllApplications();
                    break;
                case "Student":
                    applications = applicationDAO.getApplicationsByStudent(user.getUserId());
                    break;
                case "Company":
                    applications = applicationDAO.getApplicationsByCompany(user.getUserId());
                    break;
                default:
                    request.setAttribute("error", "Invalid user role");
                    request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
                    return;
            }
            request.setAttribute("applications", applications);
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving applications: " + e.getMessage(), e);
        }
    }

    private void handleViewApplicationDetails(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException {
        String applicationId = request.getParameter("appId");
        if (applicationId == null || applicationId.trim().isEmpty()) {
            request.setAttribute("error", "Application ID is required");
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
            return;
        }

        try {
            Application application = applicationDAO.getApplicationById(Integer.parseInt(applicationId));
            if (application != null) {
                request.setAttribute("application", application);
                request.getRequestDispatcher("viewApplicationDetails.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Application not found");
                request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid application ID");
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
        } catch (Exception e) {
            throw new ServletException("Error retrieving application details: " + e.getMessage(), e);
        }
    }

    private void handleApplication(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, Exception {
        if (!"Student".equals(user.getRole())) {
            request.setAttribute("error", "Only students can apply for internships");
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
            return;
        }

        String internshipId = request.getParameter("internship_id");
        if (internshipId == null || internshipId.trim().isEmpty()) {
            request.setAttribute("error", "Internship ID is required");
            request.getRequestDispatcher("applyInternship.jsp").forward(request, response);
            return;
        }

        try {
            Application application = new Application();
            application.setStudentId(user.getUserId());
            application.setInternshipId(Integer.parseInt(internshipId));
            application.setStatus("Pending");

            boolean success = applicationDAO.addApplication(application);
            if (success) {
                response.sendRedirect("viewApplications.jsp");
            } else {
                request.setAttribute("error", "Failed to submit application");
                request.getRequestDispatcher("applyInternship.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid internship ID");
            request.getRequestDispatcher("applyInternship.jsp").forward(request, response);
        }
    }

    private void handleStatusUpdate(HttpServletRequest request, HttpServletResponse response, User user) 
            throws ServletException, IOException, Exception {
        if (!"Admin".equals(user.getRole())) {
            request.setAttribute("error", "Only administrators can update application status");
            request.getRequestDispatcher("viewApplications.jsp").forward(request, response);
            return;
        }

        String applicationId = request.getParameter("appId");
        String action = request.getParameter("action");
        String newStatus = action.equals("Approve") ? "Approved" : "Rejected";

        if (applicationId == null || applicationId.trim().isEmpty()) {
            request.setAttribute("error", "Application ID is required");
            request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
            return;
        }

        try {
            // First check if the application exists and is in Pending status
            Application application = applicationDAO.getApplicationById(Integer.parseInt(applicationId));
            if (application == null) {
                request.setAttribute("error", "Application not found");
                request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
                return;
            }
            
            if (!"Pending".equals(application.getStatus())) {
                request.setAttribute("error", "Can only update applications in Pending status");
                request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
                return;
            }

            boolean success = applicationDAO.updateApplicationStatus(
                Integer.parseInt(applicationId), 
                newStatus
            );

            if (success) {
                request.setAttribute("success", "Application has been " + newStatus.toLowerCase());
                request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Failed to update application status");
                request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid application ID");
            request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error updating application: " + e.getMessage());
            request.getRequestDispatcher("manageApplications.jsp").forward(request, response);
        }
    }
}