package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.*;
import dao.TrainDAO;
import model.Train;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


@WebServlet("/addTrain")
public class TrainServlet extends HttpServlet {
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("trainName");
        String source = req.getParameter("source");
        String dest = req.getParameter("destination");
        double fare = Double.parseDouble(req.getParameter("fare"));

        Train train = new Train(name, source, dest, fare);
        TrainDAO dao = new TrainDAO();

        boolean saved = dao.addTrain(train);

        res.setContentType("text/html");
        PrintWriter out = res.getWriter();

        if (saved) {
            out.println("<h2>Train added successfully!</h2>");
        } else {
            out.println("<h2>Error adding train!</h2>");
        }
    }
}
