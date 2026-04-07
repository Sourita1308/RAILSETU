package servlet;

import dao.TrainDAO;
import model.Train;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// This servlet maps to the URL for your new "Train Schedule" page
@WebServlet("/trainSchedule")
public class TrainScheduleServlet extends HttpServlet {
    
    private TrainDAO trainDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
    }

    /**
     * This method handles loading the page AND finding the schedule.
     * It's called when the user first clicks the link (e.g., /trainSchedule)
     * and also when they click a station (e.g., /trainSchedule?origin=HWH&destination=DGR).
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Get the selected origin and destination from the URL parameters
            String origin = request.getParameter("origin");
            String destination = request.getParameter("destination");

            // 2. Fetch the complete list of stations for the sidebars
            List<String> stations = trainDAO.getAllStations();
            request.setAttribute("stations", stations);

            // 3. If an origin and destination are selected, fetch the schedule
            List<Train> trainList = null;
            if (origin != null && destination != null && !origin.equals(destination)) {
                // Call the DAO method we already built
                trainList = trainDAO.getTrainsByRoute(origin, destination);
            }

            // 4. Send all the data to the JSP file
            request.setAttribute("trainList", trainList);
            request.setAttribute("selectedOrigin", origin);
            request.setAttribute("selectedDestination", destination);

            // 5. Forward to the trainSchedule.jsp page
            request.getRequestDispatcher("trainSchedule.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error loading train schedule: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}