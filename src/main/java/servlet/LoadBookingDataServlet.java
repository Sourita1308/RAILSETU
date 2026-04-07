package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

// Import DAOs and Models
import dao.PassengerDao;
import dao.TrainDAO;
import model.Passenger;
import model.Train;

public class LoadBookingDataServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private TrainDAO trainDAO;
    private PassengerDao passengerDao;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
        passengerDao = new PassengerDao();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get both lists from the DAOs
            List<Passenger> passengerList = passengerDao.getAllPassengers();
            List<Train> trainList = trainDAO.getAllTrains();

            // 2. Set them as request attributes
            request.setAttribute("passengerList", passengerList);
            request.setAttribute("trainList", trainList);

            // 3. Forward to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("bookTicket.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load booking data: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
