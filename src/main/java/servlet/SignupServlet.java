package servlet; // <-- CORRECTED PACKAGE NAME

import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import model.User;

import java.io.IOException;
import java.sql.SQLException;

public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get all form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String location = request.getParameter("location");
        String locationType = request.getParameter("location-type");
        String password = request.getParameter("password");
        int age = 0;

        try {
            age = Integer.parseInt(request.getParameter("age"));
        } catch (NumberFormatException e) {
            age = 0; // Default to 0 if age is not a valid number
        }

        // --- Validation ---
        if (name == null || name.trim().isEmpty() || email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            sendError(request, response, "Name, Email, and Password are required.");
            return;
        }

        try {
            // --- Check if user already exists ---
            // This fixes: "cannot find symbol... method findUserByEmail"
            User existingUser = userDAO.findUserByEmail(email);
            
            if (existingUser != null) {
                // User with this email already exists
                sendError(request, response, "An account with this email already exists. Please login.");
                return;
            }

            // --- Create new user object ---
            User newUser = new User(name, email, phone, location, locationType, password, age);

            // --- Register new user ---
            // This fixes: "cannot find symbol... method addUser"
            // We are now calling the correct method: "registerUser"
            boolean success = userDAO.registerUser(newUser);

            if (success) {
                // On success, redirect to login page with a success message
                System.out.println("User registered successfully: " + email);
                response.sendRedirect("login.jsp?message=Signup+successful!+Please+login.");
            } else {
                sendError(request, response, "An unknown error occurred during registration.");
            }

        } catch (SQLException e) {
            // Handle database errors (like unique constraint violation, which we already checked)
            e.printStackTrace();
            sendError(request, response, "A database error occurred. Please try again.");
        }
    }
    
    private void sendError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        System.err.println("Signup Error: " + message);
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("signup.jsp").forward(request, response);
    }
}