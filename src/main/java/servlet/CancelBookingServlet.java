package servlet;

import dao.TicketDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

// This is mapped in your web.xml, so no @WebServlet is needed
public class CancelBookingServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private TicketDAO ticketDAO;

    @Override
    public void init() {
        ticketDAO = new TicketDAO();
    }

    /**
     * FIXED: Changed from doGet to doPost to match the form in viewBookings.jsp
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. FIXED: Get the "bookingId" from the hidden form input
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // 2. Call the DAO to delete the booking
            // We can assume your DAO method handles SQLException
            ticketDAO.cancelBooking(bookingId);

        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            // Handle the error (e.g., set an error message in session)
            // For now, we'll just redirect back.
        }
        
        // 3. Always redirect back to the bookings list servlet
        response.sendRedirect("viewBookings");
    }
}