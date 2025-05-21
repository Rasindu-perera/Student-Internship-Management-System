<%-- 
    Document   : dashboardStudent
    Created on : May 9, 2025, 9:29:16?AM
    Author     : RasinduPerera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"Student".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Student Dashboard - Welcome, <%= user.getName() %></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="applyInternship.jsp">Apply for Internship</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="viewApplications.jsp">View My Applications</a>
                        </li>
                    </ul>
                    <div class="navbar-nav">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container dashboard-container">
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="card dashboard-card">
                        <div class="card-body">
                            <h5 class="card-title">Find Internships</h5>
                            <p class="card-text">Browse and apply for available internship opportunities.</p>
                            <a href="applyInternship.jsp" class="btn btn-primary">Apply for Internship</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card dashboard-card">
                        <div class="card-body">
                            <h5 class="card-title">My Applications</h5>
                            <p class="card-text">Track the status of your internship applications.</p>
                            <a href="viewApplications.jsp" class="btn btn-primary">View Applications</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
