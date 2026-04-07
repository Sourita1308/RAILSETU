package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;

// Handles user logout requests
public class LogoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Logout request received.");

        // Get the current session, but don't create a new one if it doesn't exist
        HttpSession session = request.getSession(false);

        if (session != null) {
            System.out.println("Invalidating session for user ID: " + session.getAttribute("userId"));
            session.invalidate(); // Invalidate the session
        } else {
             System.out.println("No active session found to invalidate.");
        }

        // Redirect back to the homepage (index.jsp)
        response.sendRedirect("index.jsp");
    }

    // Handle POST requests the same way as GET for logout
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
