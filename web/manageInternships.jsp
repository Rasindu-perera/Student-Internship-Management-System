<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="model.Internship"%>
<%@page import="dao.InternshipDAO"%>
<%@page import="java.util.List"%>
<%
    try {
        User user = (User) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        InternshipDAO internshipDAO = new InternshipDAO();
        List<Internship> internships = internshipDAO.getAllInternships();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Internships</title>
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
            <div class="row mb-4">
                <div class="col">
                    <h2><i class="fas fa-briefcase"></i> Manage Internships</h2>
                </div>
                <div class="col text-end">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addInternshipModal">
                        <i class="fas fa-plus"></i> Add New Internship
                    </button>
                </div>
            </div>

            <% if (internships.isEmpty()) { %>
            <div class="alert alert-info">
                No internships found.
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Company</th>
                            <th>Deadline</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(Internship internship : internships) { %>
                        <tr>
                            <td><%= internship.getTitle() != null ? internship.getTitle() : "N/A" %></td>
                            <td><%= internship.getDescription() != null ? internship.getDescription() : "N/A" %></td>
                            <td><%= internship.getCompanyId() %></td>
                            <td><%= internship.getDeadline() != null ? internship.getDeadline() : "N/A" %></td>
                            <td>
                                <button class="btn btn-sm btn-warning" onclick="editInternship('<%= internship.getId() %>')">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteInternship('<%= internship.getId() %>')">
                                    <i class="fas fa-trash"></i> Delete
                                </button>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
            <% } %>
        </div>

        <!-- Add Internship Modal -->
        <div class="modal fade" id="addInternshipModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New Internship</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="InternshipServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Title</label>
                                <input type="text" class="form-control" name="title" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Description</label>
                                <textarea class="form-control" name="description" required></textarea>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Company ID</label>
                                <input type="number" class="form-control" name="company_id" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Deadline</label>
                                <input type="date" class="form-control" name="deadline" required>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Add Internship</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function editInternship(id) {
                window.location.href = 'editInternship.jsp?id=' + id;
            }
            
            function deleteInternship(id) {
                if(confirm('Are you sure you want to delete this internship?')) {
                    window.location.href = 'InternshipServlet?action=delete&id=' + id;
                }
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