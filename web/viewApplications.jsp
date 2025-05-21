<%-- 
    Document   : viewApplications
    Created on : May 9, 2025, 9:30:18?AM
    Author     : RasinduPerera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List,model.Application,model.Internship,dao.ApplicationDAO,dao.InternshipDAO,model.User"%>
<%
    User user = (User) session.getAttribute("user");
    if(user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    List<Application> applications = null;
    String errorMessage = null;
    
    try {
        ApplicationDAO applicationDAO = new ApplicationDAO();
        if("Student".equals(user.getRole())) {
            applications = applicationDAO.getApplicationsByStudent(user.getUserId());
        } else if("Company".equals(user.getRole())) {
            applications = applicationDAO.getApplicationsByCompany(user.getUserId());
        } else if("Admin".equals(user.getRole())) {
            applications = applicationDAO.getAllApplications();
        } else {
            errorMessage = "Invalid user role";
        }
    } catch (Exception e) {
        errorMessage = "Error loading applications: " + e.getMessage();
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Applications</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Applications</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboard<%= user.getRole() %>.jsp">Dashboard</a>
                        </li>
                    </ul>
                    <div class="navbar-nav">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4 class="mb-0">Application List</h4>
                    <% if("Student".equals(user.getRole())) { %>
                        <a href="applyInternship.jsp" class="btn btn-primary">Apply for New Internship</a>
                    <% } %>
                </div>
                <div class="card-body">
                    <% if(errorMessage != null) { %>
                        <div class="alert alert-danger">
                            <%= errorMessage %>
                        </div>
                    <% } else if(applications == null || applications.isEmpty()) { %>
                        <div class="alert alert-info">
                            No applications found.
                        </div>
                    <% } else { %>
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Application ID</th>
                                        <th>Internship</th>
                                        <% if(!"Student".equals(user.getRole())) { %>
                                            <th>Student</th>
                                        <% } %>
                                        <th>Status</th>
                                        <th>Applied Date</th>
                                        <% if("Admin".equals(user.getRole())) { %>
                                            <th>Action</th>
                                        <% } %>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for(Application app : applications) { %>
                                        <tr>
                                            <td><%= app.getId() %></td>
                                            <td><%= app.getInternshipTitle() != null ? app.getInternshipTitle() : "N/A" %></td>
                                            <% if(!"Student".equals(user.getRole())) { %>
                                                <td><%= app.getStudentName() != null ? app.getStudentName() : "N/A" %></td>
                                            <% } %>
                                            <td>
                                                <span class="badge <%= "Pending".equals(app.getStatus()) ? "bg-warning" : 
                                                                      "Approved".equals(app.getStatus()) ? "bg-success" : 
                                                                      "Rejected".equals(app.getStatus()) ? "bg-danger" : "bg-secondary" %>">
                                                    <%= app.getStatus() != null ? app.getStatus() : "Unknown" %>
                                                </span>
                                            </td>
                                            <td><%= app.getAppliedDate() != null ? app.getAppliedDate() : "N/A" %></td>
                                            <% if("Admin".equals(user.getRole())) { %>
                                                <td>
                                                    <% if("Pending".equals(app.getStatus())) { %>
                                                        <form action="ApplicationServlet" method="post" class="d-inline">
                                                            <input type="hidden" name="appId" value="<%= app.getId() %>"/>
                                                            <button type="submit" name="action" value="Approve" class="btn btn-success btn-sm">Approve</button>
                                                            <button type="submit" name="action" value="Reject" class="btn btn-danger btn-sm">Reject</button>
                                                        </form>
                                                    <% } %>
                                                </td>
                                            <% } %>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
