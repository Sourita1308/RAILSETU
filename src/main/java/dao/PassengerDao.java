package dao;

import java.sql.*;
import model.Passenger;
import db.DBConnection;


public class PassengerDao {

    public boolean addPassenger(Passenger passenger) {
        boolean result = false;
        try (Connection con = DBConnection.getConnection()) {
            String query = "INSERT INTO passenger (name, age, gender) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, passenger.getName());
            ps.setInt(2, passenger.getAge());
            ps.setString(3, passenger.getGender());

            int rows = ps.executeUpdate();
            if (rows > 0) result = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}
