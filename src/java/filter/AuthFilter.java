package controller.filter;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import model.User;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);
        
        String path = request.getRequestURI();
        
        // Skip filter for login and static resources
        if (path.contains("login.jsp") || path.contains("LoginServlet") || 
            path.contains(".css") || path.contains(".js") || path.contains(".ico")) {
            chain.doFilter(req, res);
            return;
        }
        
        // Check admin access
        if (path.contains("dashboardAdmin") || path.contains("manage")) {
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            User user = (User) session.getAttribute("user");
            if (!"Admin".equals(user.getRole())) {
                response.sendRedirect("error.jsp?message=Access denied. Admin privileges required.");
                return;
            }
        }
        
        chain.doFilter(req, res);
    }
}