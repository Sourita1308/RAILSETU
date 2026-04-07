package servlet; // <-- CORRECTED PACKAGE NAME

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            sendError(request, response, "Email and Password are required.");
            return;
        }

        try {
            // --- Call the correct loginUser method ---
            // This fixes: "cannot find symbol... method findUserByEmail"
            // and "cannot find symbol... method checkPassword"
            // The new loginUser method does both.
            User user = userDAO.loginUser(email, password);

            if (user != null) {
                // --- Login Successful ---
                System.out.println("Login successful for user: " + user.getEmail());

                HttpSession session = request.getSession();
                session.setAttribute("userId", user.getId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userEmail", user.getEmail()); // For the dashboard

                // Redirect to the new dashboard page
                response.sendRedirect("dashboard.jsp"); 

            } else {
                // --- Login Failed ---
                System.out.println("Login failed for user: " + email);
                sendError(request, response, "Invalid email or password.");
            }

        } catch (SQLException e) {
            e.printStackTrace();
            sendError(request, response, "A database error occurred. Please try again.");
        }
    }

    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        System.err.println("Login Error: " + message);
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}