<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body class="bg-light">
        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-body text-center">
                            <h3 class="card-title text-danger">Error</h3>
                            <p class="card-text">
                                <% 
                                    String errorMessage = request.getParameter("message");
                                    if (errorMessage != null && !errorMessage.isEmpty()) {
                                        out.println(errorMessage);
                                    } else {
                                        out.println("An unexpected error occurred. Please try again.");
                                    }
                                %>
                            </p>
                            <div class="mt-3">
                                <a href="javascript:history.back()" class="btn btn-primary">Go Back</a>
                                <a href="login.jsp" class="btn btn-secondary">Go to Login</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html> 