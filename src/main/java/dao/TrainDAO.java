package dao;

import java.sql.*;
import java.util.*;
import db.DBConnection;
import model.Train;

public class TrainDAO {

    public boolean addTrain(Train train) {
        boolean success = false;
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO trains (train_name, source, destination, fare) VALUES (?, ?, ?, ?)");
            ps.setString(1, train.getTrainName());
            ps.setString(2, train.getSource());
            ps.setString(3, train.getDestination());
            ps.setDouble(4, train.getFare());
            int rows = ps.executeUpdate();
            success = (rows > 0);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return success;
    }

    public List<Train> getAllTrains() {
        List<Train> list = new ArrayList<>();
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement("SELECT * FROM trains");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Train t = new Train();
                t.setTrainId(rs.getInt("train_id"));
                t.setTrainName(rs.getString("train_name"));
                t.setSource(rs.getString("source"));
                t.setDestination(rs.getString("destination"));
                t.setFare(rs.getDouble("fare"));
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
