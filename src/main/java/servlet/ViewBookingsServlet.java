package servlet;

import dao.TicketDAO;
import model.BookingDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet; // <-- Make sure this is imported
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // <-- Make sure this is imported
import java.io.IOException;
import java.util.List;

// Use @WebServlet annotation instead of web.xml
@WebServlet("/viewBookings")
public class ViewBookingsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TicketDAO ticketDAO;

    @Override
    public void init() {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get the User ID from the session
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

            if (userId == null) {
                // User is not logged in, send to account page
                response.sendRedirect("account.html");
                return;
            }

            // 2. Fetch all bookings for THIS user from the DAO
            //    This is the correct method that filters by user
            List<BookingDetails> bookingList = ticketDAO.getAllBookingsByUserId(userId);

            // 3. Set the list as an attribute for the JSP
            request.setAttribute("bookingList", bookingList);
            
            // 4. Forward to the JSP page
            request.getRequestDispatcher("viewBookings.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load bookings: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}