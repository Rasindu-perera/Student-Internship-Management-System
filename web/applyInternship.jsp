<%-- 
    Document   : applyInternship
    Created on : May 9, 2025, 9:30:09?AM
    Author     : RasinduPerera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Apply for Internship</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
        <script>
            function loadInternships() {
                fetch("ajax/internshipList.jsp")
                    .then(response => response.text())
                    .then(data => {
                        document.getElementById("internshipDropdown").innerHTML = data;
                    })
                    .catch(error => {
                        console.error('Error loading internships:', error);
                        document.getElementById("internshipDropdown").innerHTML = 
                            '<option value="">Error loading internships</option>';
                    });
            }
            window.onload = loadInternships;
        </script>
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="#">Apply for Internship</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="dashboardStudent.jsp">Dashboard</a>
                        </li>
                    </ul>
                    <div class="navbar-nav">
                        <a class="nav-link" href="LogoutServlet">Logout</a>
                    </div>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="mb-0">Apply for Internship</h4>
                        </div>
                        <div class="card-body">
                            <form action="ApplicationServlet" method="post" onsubmit="return validateApplication();">
                                <input type="hidden" name="action" value="Apply">
                                <div class="mb-3">
                                    <label for="internshipDropdown" class="form-label">Select Internship</label>
                                    <select class="form-select" name="internship_id" id="internshipDropdown" required>
                                        <option value="">Loading internships...</option>
                                    </select>
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Submit Application</button>
                                </div>
                            </form>
                            <% if(request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger mt-3">
                                    <%= request.getAttribute("error") %>
                                </div>
                            <% } %>
                            <div class="text-center mt-3">
                                <a href="dashboardStudent.jsp" class="btn btn-secondary">Back to Dashboard</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function validateApplication() {
                const internshipId = document.getElementById("internshipDropdown").value;
                if (!internshipId) {
                    alert("Please select an internship");
                    return false;
                }
                return true;
            }
        </script>
    </body>
</html>
