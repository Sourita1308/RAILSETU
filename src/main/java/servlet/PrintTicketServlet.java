package servlet;

import dao.TicketDAO;
import model.BookingDetails;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/printTicket")
public class PrintTicketServlet extends HttpServlet {
    
    private TicketDAO ticketDAO;

    @Override
    public void init() {
        ticketDAO = new TicketDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // 1. Check if user is logged in
            HttpSession session = request.getSession(false);
            Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;

            if (userId == null) {
                response.sendRedirect("account.html");
                return;
            }

            // 2. Get the bookingId from the URL
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // 3. Fetch the booking details
            BookingDetails booking = ticketDAO.getBookingById(bookingId);

            // 4. IMPORTANT: Security Check
            // A future upgrade would be to add `userId` to the `getBookingById` query
            // to ensure a user can only print their own ticket.
            
            if (booking == null) {
                throw new ServletException("No booking found with that ID.");
            }
            
            // 5. Send the booking object to the JSP
            request.setAttribute("booking", booking);
            request.getRequestDispatcher("printTicket.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Could not load ticket: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}