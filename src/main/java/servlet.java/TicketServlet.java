package servlet;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import dao.TicketDAO;
import model.Ticket;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;


/*public class TicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            int passengerId = Integer.parseInt(request.getParameter("passenger_id"));
            int trainId = Integer.parseInt(request.getParameter("train_id"));

            Ticket ticket = new Ticket(passengerId, trainId);
            TicketDAO dao = new TicketDAO();

            boolean success = dao.bookTicket(ticket);

            if (success) {
                out.println("<h2>Ticket booked successfully!</h2>");
            } else {
                out.println("<h2>Failed to book ticket.</h2>");
            }
        } catch (Exception e) {
            e.printStackTrace(out);
        }
    }
}*/
