package servlet;

import dao.TrainDAO;
import model.Train;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // We need this annotation
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// We map this servlet to the URL "/findTrains"
@WebServlet("/findTrains")
public class TrainRouteServlet extends HttpServlet {
    
    private TrainDAO trainDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
    }

    /**
     * Handles the initial page load (when a user clicks the "Railway Stations" link).
     * It fetches all stations for the dropdowns.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get all stations for the dropdowns
            List<String> stations = trainDAO.getAllStations();
            
            // 2. Set them as a request attribute
            request.setAttribute("stations", stations);
            
            // 3. Forward to the JSP
            request.getRequestDispatcher("railwayStations.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load station data: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    /**
     * Handles the form submission (when user clicks "Find Trains").
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Get the selected start and end locations from the form
        String start = request.getParameter("start-location");
        String end = request.getParameter("end-location");

        List<Train> trainList = null;
        try {
            if (start != null && end != null && !start.equals(end)) {
                // 2. Fetch the matching trains from the DAO
                trainList = trainDAO.getTrainsByRoute(start, end);
                request.setAttribute("selectedStart", start);
                request.setAttribute("selectedEnd", end);
            }

            // 3. Set the results as a request attribute
            request.setAttribute("trainList", trainList);

            // 4. ALSO, we must send the station list again, or the dropdowns will be empty!
            List<String> stations = trainDAO.getAllStations();
            request.setAttribute("stations", stations);

            // 5. Forward back to the same JSP to display the results
            request.getRequestDispatcher("railwayStations.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error searching for trains: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}