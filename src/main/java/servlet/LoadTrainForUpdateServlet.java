package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import dao.TrainDAO;
import model.Train;

// No @WebServlet annotation needed since we map in web.xml

public class LoadTrainForUpdateServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TrainDAO trainDAO;

    @Override
    public void init() {
        trainDAO = new TrainDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            // 1. Get the train ID from the URL parameter
            int trainId = Integer.parseInt(request.getParameter("id"));
            
            // 2. Fetch the train data from the DAO
            Train train = trainDAO.getTrainById(trainId);
            
            if (train != null) {
                // 3. Set the train object as a request attribute
                request.setAttribute("train", train);
                
                // 4. Forward to the updateTrain.jsp page
                request.getRequestDispatcher("updateTrain.jsp").forward(request, response);
            } else {
                // Handle case where train isn't found
                request.setAttribute("error", "Train not found for updating.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid train ID.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}

