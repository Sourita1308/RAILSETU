package servlet;

import dao.TrainDAO;
import model.Train;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

// This servlet doesn't need @WebServlet since we will map it in web.xml
public class ViewTrainsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainDAO trainDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get the list of trains from the DAO
            List<Train> trainList = trainDAO.getAllTrains();
            
            // 2. Set the list as an attribute for the JSP
            request.setAttribute("trainList", trainList);
            
            // 3. Forward the request (and data) to the new JSP page
            request.getRequestDispatcher("viewTrains.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            // If something goes wrong, send to the error page
            request.setAttribute("error", "Could not retrieve train list: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}
