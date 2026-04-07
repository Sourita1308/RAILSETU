package servlet;

import dao.PassengerDao;
import dao.TicketDAO; // <-- Import TicketDAO
import model.Passenger;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

// This servlet is still mapped to "/addPassenger" in your web.xml
public class PassengerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private PassengerDao passengerDao;
    private TicketDAO ticketDAO; // <-- Add TicketDAO

    @Override
    public void init() {
        passengerDao = new PassengerDao();
        ticketDAO = new TicketDAO(); // <-- Initialize TicketDAO
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get the LIST of passenger details from the new form
            String[] passengerNames = request.getParameterValues("passengerName");
            String[] passengerAges = request.getParameterValues("passengerAge");
            String[] passengerGenders = request.getParameterValues("passengerGender");

            // 2. Get the SINGLE IDs (they are the same for all tickets)
            int trainId = Integer.parseInt(request.getParameter("trainId"));
            int userId = Integer.parseInt(request.getParameter("userId"));

            // 3. Check if we actually got any passengers
            if (passengerNames == null || passengerNames.length == 0) {
                throw new ServletException("No passenger details were submitted.");
            }

            // 4. Loop through each passenger and book a ticket
            for (int i = 0; i < passengerNames.length; i++) {
                
                // 4a. Create Passenger object
                Passenger passenger = new Passenger();
                passenger.setName(passengerNames[i]);
                passenger.setAge(Integer.parseInt(passengerAges[i]));
                passenger.setGender(passengerGenders[i]);

                // 4b. Add passenger to DB and get their new ID
                int newPassengerId = passengerDao.addPassenger(passenger);

                if (newPassengerId == -1) {
                    throw new SQLException("Failed to create passenger record for: " + passengerNames[i]);
                }

                // 4c. Book the ticket using all three IDs
                boolean ticketBooked = ticketDAO.bookTicket(userId, trainId, newPassengerId);

                if (!ticketBooked) {
                    throw new SQLException("Passenger was created, but ticket booking failed for: " + passengerNames[i]);
                }
            }

            // 5. If the loop finishes without errors, all tickets are booked!
            response.sendRedirect("viewBookings");


        } catch (SQLException | ServletException | NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Booking failed: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}