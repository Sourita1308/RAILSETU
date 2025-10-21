package dao;

import java.sql.*;
import db.DBConnection;
import model.Ticket;

public class TicketDAO {

    public boolean bookTicket(Ticket ticket) {
        boolean success = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO tickets (passenger_id, train_id) VALUES (?, ?)");
            ps.setInt(1, ticket.getPassengerId());
            ps.setInt(2, ticket.getTrainId());
            int rows = ps.executeUpdate();
            success = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }
}
