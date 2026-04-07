package servlet;

// Import your Model and DAO
import model.Train;
import dao.TrainDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException; // Import SQLException
import java.sql.Time;       // Import java.sql.Time

// The @WebServlet("/addTrain") annotation has been REMOVED
// Your web.xml file will now be the only source of truth.
public class TrainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // We can re-use the DAO
    private TrainDAO trainDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO(); // Create the DAO instance once
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get ALL parameters from the new form
        String trainName = request.getParameter("trainName");
        String trainType = request.getParameter("trainType");
        String sourceStation = request.getParameter("sourceStation");
        String destinationStation = request.getParameter("destinationStation");
        String frequency = request.getParameter("frequency");
        String classes = request.getParameter("classes");
        
        int trainNo = 0;
        Time departureTime = null;

        // 2. Parse Train Number
        try {
            // Note: The form input *must* be named "trainNo"
            trainNo = Integer.parseInt(request.getParameter("trainNo"));
        } catch (NumberFormatException | NullPointerException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid Train Number. Please enter a number.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // 3. Parse Departure Time
        try {
            // Note: The form input *must* be named "departureTime"
            String timeStr = request.getParameter("departureTime"); // Expects "HH:mm" from an <input type="time">
            
            if (timeStr != null && !timeStr.isEmpty()) {
                // java.sql.Time.valueOf() needs "HH:mm:ss". Append ":00"
                departureTime = Time.valueOf(timeStr + ":00");
            } else {
                // Handle case where time is not provided, if your DB allows null
                departureTime = null; 
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid Departure Time. Please use HH:mm format.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // 4. Create a Train object (your Model) using setters
        Train newTrain = new Train();
        newTrain.setTrainNo(trainNo);
        newTrain.setTrainName(trainName);
        newTrain.setTrainType(trainType);
        newTrain.setSourceStation(sourceStation);
        newTrain.setDestinationStation(destinationStation);
        newTrain.setDepartureTime(departureTime);
        newTrain.setFrequency(frequency);
        newTrain.setClasses(classes);

        // 5. Use the TrainDAO to add the train
        boolean success = false;
        try {
            // The DAO method now throws SQLException, so we catch it
            success = trainDAO.addTrain(newTrain);
        } catch (SQLException e) {
            e.printStackTrace();
            // Send a more specific SQL error to the error page
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return; // Stop execution
        } catch (Exception e) {
            e.printStackTrace();
            success = false;
        }

        // 6. Redirect based on the result
        if (success) {
            // Forward to a success page
            request.setAttribute("message", "Train '" + trainName + "' Added Successfully!");
            request.getRequestDispatcher("train_success.jsp").forward(request, response); 
        } else {
            // Forward to an error page
            request.setAttribute("error", "Failed to add train. Please try again.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}