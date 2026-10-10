package servlet;

import dao.UserDAO;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("new_password");

        if (email == null || email.trim().isEmpty() || newPassword == null || newPassword.trim().isEmpty()) {
            redirectWithError(response, "Email and new password are required.");
            return;
        }

        try {
            User user = userDAO.findUserByEmail(email);
            if (user == null) {
                redirectWithError(response, "No account found with that email address.");
                return;
            }

            boolean isUpdated = userDAO.updatePassword(email, newPassword);
            if (isUpdated) {
                response.sendRedirect("login.jsp?message=" + URLEncoder.encode("Password updated successfully. Please login.", "UTF-8"));
            } else {
                redirectWithError(response, "Failed to update password. Please try again later.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            redirectWithError(response, "An internal database error occurred.");
        }
    }

    private void redirectWithError(HttpServletResponse response, String errorMsg) throws IOException {
        response.sendRedirect("forgot-password.jsp?error=" + URLEncoder.encode(errorMsg, "UTF-8"));
    }
}
