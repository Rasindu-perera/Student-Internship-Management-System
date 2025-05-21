<%-- 
    Document   : registerStudent
    Created on : May 9, 2025, 9:29:04?AM
    Author     : RasinduPerera
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register Student</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/styles.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4 class="mb-0">Student Registration</h4>
                        </div>
                        <div class="card-body">
                            <% if(request.getAttribute("error") != null) { %>
                                <div class="alert alert-danger">
                                    <%= request.getAttribute("error") %>
                                </div>
                            <% } %>
                            
                            <% if(request.getAttribute("success") != null) { %>
                                <div class="alert alert-success">
                                    <%= request.getAttribute("success") %>
                                </div>
                            <% } %>

                            <form action="RegisterServlet" method="post" onsubmit="return validateRegistration()">
                                <div class="mb-3">
                                    <label for="name" class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="name" name="name" required 
                                           pattern="[A-Za-z\s]+" title="Please enter a valid name (letters and spaces only)"
                                           value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
                                </div>
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" required
                                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                                </div>
                                <div class="mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required
                                           minlength="6" title="Password must be at least 6 characters long">
                                </div>
                                <div class="mb-3">
                                    <label for="confirmPassword" class="form-label">Confirm Password</label>
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                </div>
                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-primary">Register</button>
                                </div>
                            </form>
                            <div class="text-center mt-3">
                                <p>Already have an account? <a href="login.jsp">Login here</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            function validateRegistration() {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const name = document.getElementById('name').value;
                const email = document.getElementById('email').value;

                if (name.trim() === '') {
                    alert('Please enter your name');
                    return false;
                }

                if (!email.includes('@')) {
                    alert('Please enter a valid email address');
                    return false;
                }

                if (password.length < 6) {
                    alert('Password must be at least 6 characters long');
                    return false;
                }

                if (password !== confirmPassword) {
                    alert('Passwords do not match');
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>
