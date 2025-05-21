<%-- 
    Document   : dashboardAdmin
    Created on : May 9, 2025, 9:29:41?AM
    Author     : RasinduPerera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>
<%@page import="dao.InternshipDAO"%>
<%@page import="dao.ApplicationDAO"%>
<%@page import="java.util.List"%>
<%
    try {
        User user = (User) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        // Get counts for dashboard
        UserDAO userDAO = new UserDAO();
        InternshipDAO internshipDAO = new InternshipDAO();
        ApplicationDAO applicationDAO = new ApplicationDAO();
        
        int totalUsers = 0;
        int totalInternships = 0;
        int totalApplications = 0;
        
        try {
            totalUsers = userDAO.getAllUsers().size();
            totalInternships = internshipDAO.getAllInternships().size();
            totalApplications = applicationDAO.getAllApplications().size();
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading dashboard data: " + e.getMessage());
        }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Admin Dashboard - Welcome, <%= user.getName() %></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="manageInternships.jsp">Manage Internships</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="manageApplications.jsp">Manage Applications</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="manageUsers.jsp">Manage Users</a>
                        </li>
                    </ul>
                    <div class="navbar-nav">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card bg-primary text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-users"></i> Total Users</h5>
                            <h2 class="display-4"><%= totalUsers %></h2>
                            <p class="card-text">Manage student and company accounts</p>
                            <a href="manageUsers.jsp" class="btn btn-light">Manage Users</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-success text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-briefcase"></i> Total Internships</h5>
                            <h2 class="display-4"><%= totalInternships %></h2>
                            <p class="card-text">Manage internship opportunities</p>
                            <a href="manageInternships.jsp" class="btn btn-light">Manage Internships</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-4">
                    <div class="card bg-info text-white">
                        <div class="card-body">
                            <h5 class="card-title"><i class="fas fa-file-alt"></i> Total Applications</h5>
                            <h2 class="display-4"><%= totalApplications %></h2>
                            <p class="card-text">Review and process applications</p>
                            <a href="manageApplications.jsp" class="btn btn-light">Manage Applications</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?message=" + e.getMessage());
    }
%>
