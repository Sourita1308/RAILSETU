package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import dao.PassengerDao;
import model.Passenger;

/*@WebServlet("/addPassenger")
public class PassengerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        int age = Integer.parseInt(request.getParameter("age"));
        String gender = request.getParameter("gender");

        Passenger passenger = new Passenger(name, age, gender);

        PassengerDao dao = new PassengerDao();
        boolean result = dao.addPassenger(passenger);

        if (result) {
            // ✅ Forward to confirmation or ticket page
            request.setAttribute("message", "Passenger added successfully!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("passenger_success.jsp");
            dispatcher.forward(request, response);
            System.out.println("DEBUG: PassengerServlet triggered");

        } else {
            // ❌ Show error message
            request.setAttribute("error", "Error adding passenger!");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}*/
