<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Application"%>
<%@page import="dao.ApplicationDAO"%>
<%@page import="java.util.List"%>
<%
    try {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        ApplicationDAO applicationDAO = new ApplicationDAO();
        List<Application> applications = applicationDAO.getAllApplications();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Applications</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <div class="container">
                <a class="navbar-brand" href="dashboardAdmin.jsp">Admin Dashboard</a>
                <div class="navbar-nav">
                    <a class="nav-link" href="LogoutServlet">Logout</a>
                </div>
            </div>
        </nav>

        <div class="container mt-4">
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <%= request.getAttribute("error") %>
            </div>
            <% } %>
            
            <% if (request.getAttribute("success") != null) { %>
            <div class="alert alert-success">
                <%= request.getAttribute("success") %>
            </div>
            <% } %>

            <div class="row mb-4">
                <div class="col">
                    <h2><i class="fas fa-file-alt"></i> Manage Applications</h2>
                </div>
            </div>

            <% if (applications.isEmpty()) { %>
            <div class="alert alert-info">
                No applications found.
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Student</th>
                            <th>Internship</th>
                            <th>Status</th>
                            <th>Applied Date</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Application app : applications) { %>
                        <tr>
                            <td><%= app.getId() %></td>
                            <td><%= app.getStudentName() != null ? app.getStudentName() : "N/A" %></td>
                            <td><%= app.getInternshipTitle() != null ? app.getInternshipTitle() : "N/A" %></td>
                            <td>
                                <span class="badge bg-<%= app.getStatus().equals("Approved") ? "success" : 
                                    (app.getStatus().equals("Rejected") ? "danger" : "warning") %>">
                                    <%= app.getStatus() %>
                                </span>
                            </td>
                            <td><%= app.getAppliedDate() != null ? app.getAppliedDate() : "N/A" %></td>
                            <td>
                                <% if(app.getStatus().equals("Pending")) { %>
                                <form method="post" action="ApplicationServlet" style="display: inline;">
                                    <input type="hidden" name="action" value="Approve">
                                    <input type="hidden" name="appId" value="<%= app.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-success" onclick="return confirm('Are you sure you want to approve this application?')">
                                        <i class="fas fa-check"></i> Approve
                                    </button>
                                </form>
                                <form method="post" action="ApplicationServlet" style="display: inline;">
                                    <input type="hidden" name="action" value="Reject">
                                    <input type="hidden" name="appId" value="<%= app.getId() %>">
                                    <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure you want to reject this application?')">
                                        <i class="fas fa-times"></i> Reject
                                    </button>
                                </form>
                                <% } %>
                                <button class="btn btn-sm btn-info" onclick="viewDetails('<%= app.getId() %>')">
                                    <i class="fas fa-eye"></i> View Details
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function viewDetails(id) {
                window.location.href = 'ApplicationServlet?action=viewDetails&appId=' + id;
            }
        </script>
    </body>
</html>
<%
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp?message=" + e.getMessage());
    }
%> 