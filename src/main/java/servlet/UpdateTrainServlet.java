package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.TrainDAO;
import model.Train;
import java.sql.Time;       // <-- Import java.sql.Time
import java.sql.SQLException; // <-- Import SQLException

// No @WebServlet annotation needed since we map in web.xml

public class UpdateTrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainDAO trainDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get all NEW parameters from the form
            
            // We still need the ID to know which train to update
            int trainId = Integer.parseInt(request.getParameter("trainId"));
            
            String trainName = request.getParameter("trainName");
            String trainType = request.getParameter("trainType");
            String sourceStation = request.getParameter("sourceStation");
            String destinationStation = request.getParameter("destinationStation");
            String frequency = request.getParameter("frequency");
            String classes = request.getParameter("classes");

            // Parse Train Number
            int trainNo = Integer.parseInt(request.getParameter("trainNo"));
            
            // Parse Departure Time
            String timeStr = request.getParameter("departureTime"); // Expects "HH:mm"
            Time departureTime = null;
            if (timeStr != null && !timeStr.isEmpty()) {
                departureTime = Time.valueOf(timeStr + ":00"); // Add seconds
            }

            // 2. Create a Train object with the updated details
            Train train = new Train();
            train.setTrainId(trainId); // Set the ID for the WHERE clause
            train.setTrainNo(trainNo);
            train.setTrainName(trainName);
            train.setTrainType(trainType);
            train.setSourceStation(sourceStation);
            train.setDestinationStation(destinationStation);
            train.setDepartureTime(departureTime);
            train.setFrequency(frequency);
            train.setClasses(classes);
            
            // 3. Call the DAO to update the train in the database
            boolean success = trainDAO.updateTrain(train);
            
            if (success) {
                // 4. Redirect back to the train list page
                response.sendRedirect("viewTrains");
            } else {
                request.setAttribute("error", "Failed to update train.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        // Handle new, more specific exceptions
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid data entered (e.g., train number must be a number).");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (SQLException e) {
             e.printStackTrace();
            request.setAttribute("error", "Database error during update: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}