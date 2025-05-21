<%-- 
    Document   : dashboardCompany
    Created on : May 9, 2025, 9:29:29?AM
    Author     : RasinduPerera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%
    User user = (User) session.getAttribute("user");
    if(user == null || !"Company".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Company Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Company Dashboard - Welcome, <%= user.getName() %></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="postInternship.jsp">Post Internship</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="viewApplications.jsp">View Applications</a>
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
                            <h5 class="card-title">Post New Internship</h5>
                            <p class="card-text">Create and publish new internship opportunities for students.</p>
                            <a href="postInternship.jsp" class="btn btn-primary">Post Internship</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <div class="card dashboard-card">
                        <div class="card-body">
                            <h5 class="card-title">Manage Applications</h5>
                            <p class="card-text">Review and manage student applications for your internships.</p>
                            <a href="viewApplications.jsp" class="btn btn-primary">View Applications</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
