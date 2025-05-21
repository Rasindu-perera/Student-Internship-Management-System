<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.User"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.util.List"%>
<%
    try {
        User admin = (User) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        UserDAO userDAO = new UserDAO();
        List<User> users = userDAO.getAllUsers();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Manage Users</title>
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
                    <h2><i class="fas fa-users"></i> Manage Users</h2>
                </div>
                <div class="col text-end">
                    <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="fas fa-user-plus"></i> Add New User
                    </button>
                </div>
            </div>

            <% if (users.isEmpty()) { %>
            <div class="alert alert-info">
                No users found.
            </div>
            <% } else { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for(User user : users) { %>
                        <tr>
                            <td><%= user.getUserId() %></td>
                            <td><%= user.getName() != null ? user.getName() : "N/A" %></td>
                            <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                            <td>
                                <span class="badge bg-<%= user.getRole().equals("Admin") ? "danger" : 
                                    (user.getRole().equals("Company") ? "success" : "primary") %>">
                                    <%= user.getRole() %>
                                </span>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-warning" onclick="editUser('<%= user.getUserId() %>')">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <button class="btn btn-sm btn-danger" onclick="deleteUser('<%= user.getUserId() %>')">
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

        <!-- Add User Modal -->
        <div class="modal fade" id="addUserModal" tabindex="-1">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <form action="UserServlet" method="post">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label class="form-label">Name</label>
                                <input type="text" class="form-control" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Role</label>
                                <select class="form-select" name="role" required>
                                    <option value="Student">Student</option>
                                    <option value="Company">Company</option>
                                    <option value="Admin">Admin</option>
                                </select>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                            <button type="submit" class="btn btn-primary">Add User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function editUser(id) {
                window.location.href = 'editUser.jsp?id=' + id;
            }
            
            function deleteUser(id) {
                if(confirm('Are you sure you want to delete this user?')) {
                    window.location.href = 'UserServlet?action=delete&id=' + id;
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