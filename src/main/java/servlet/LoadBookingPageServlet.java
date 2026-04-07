package servlet;

import dao.TrainDAO;
import dao.UserDAO;
import model.Train;
import model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

// This is the URL that your "Book Now" buttons link to
@WebServlet("/loadBookingPage")
public class LoadBookingPageServlet extends HttpServlet {
    
    private TrainDAO trainDAO;
    private UserDAO userDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
        userDAO = new UserDAO(); // We need this to get the user's details
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get the User ID from the session
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

            // 2. Get the Train ID from the URL (passed by the "Book Now" button)
            String trainIdStr = request.getParameter("trainId");

            // --- Error Handling ---
            if (userId == null) {
                // User is not logged in
                response.sendRedirect("account.html");
                return;
            }
            if (trainIdStr == null || trainIdStr.isEmpty()) {
                // User got to this page by accident, send them to pick a train
                response.sendRedirect("findTrains");
                return;
            }
            
            int trainId = Integer.parseInt(trainIdStr);

            // 3. Fetch the full objects from the database
            Train train = trainDAO.getTrainById(trainId);
            User user = userDAO.getUserById(userId); // Assumes you have this method in UserDAO

            // 4. Set them as attributes to be used by the JSP
            request.setAttribute("train", train);
            request.setAttribute("user", user);

            // 5. Forward to your new, stylish booking page
            // (We will create/modify this file in the next step)
            request.getRequestDispatcher("addReservation.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading booking page: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}